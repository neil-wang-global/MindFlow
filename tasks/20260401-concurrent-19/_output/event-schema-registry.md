# Event Schema Registry Design

## Overview

An event schema registry provides a centralized repository for managing, versioning, and validating event schemas in a distributed system. It serves as the single source of truth for event contracts between producers and consumers, enforcing compatibility rules to prevent breaking changes during schema evolution.

## Schema Model

### Storage Structure

Schemas are organized in a hierarchical subject-version namespace:

```
{subject}/{version}/schema.json
```

- **Subject**: a unique identifier for the event type (e.g., `order.created`, `payment.processed`)
- **Version**: a monotonically increasing integer (1, 2, 3, ...) assigned by the registry on registration
- **Schema**: the event schema in JSON Schema (draft 2020-12) format

### Schema Metadata

Each registered schema carries:

| Field | Type | Description |
|-------|------|-------------|
| `id` | integer | Global unique schema ID (auto-assigned) |
| `subject` | string | Event type subject name |
| `version` | integer | Version within the subject (auto-incremented) |
| `schema` | object | The JSON Schema definition |
| `compatibility` | enum | Compatibility mode for this subject |
| `fingerprint` | string | SHA-256 hash of the canonical schema form |
| `created_at` | ISO 8601 | Registration timestamp |
| `deprecated` | boolean | Whether this version is deprecated |

### Canonical Form

Before storage, schemas are normalized to a canonical form (sorted keys, whitespace-stripped) to enable deduplication via fingerprint comparison. Registering an identical schema returns the existing version rather than creating a duplicate.

## Versioning Strategy

### Version Assignment

- Versions are **monotonically increasing integers** within each subject, assigned by the registry (not by producers)
- Version 1 is the initial schema; each subsequent registration increments the version
- Versions are **immutable** once registered — a registered schema version cannot be modified or deleted (soft-delete via deprecation only)

### Deprecation

- Individual versions can be marked `deprecated: true`
- Deprecated versions remain readable but produce a warning header in API responses
- Producers referencing deprecated versions receive a `X-Schema-Deprecated: true` header

## Compatibility Modes

Each subject is configured with one compatibility mode. The registry validates new schemas against existing versions before accepting registration.

| Mode | Rule | Validates Against |
|------|------|-------------------|
| **BACKWARD** | New schema can read data written by the previous schema | Latest registered version |
| **FORWARD** | Previous schema can read data written by the new schema | Latest registered version |
| **FULL** | Both backward and forward compatible | Latest registered version |
| **BACKWARD_TRANSITIVE** | New schema can read data written by all previous versions | All registered versions |
| **FORWARD_TRANSITIVE** | All previous versions can read data written by the new schema | All registered versions |
| **FULL_TRANSITIVE** | Both backward and forward compatible with all versions | All registered versions |
| **NONE** | No compatibility checking — any schema accepted | Not applicable |

### Compatibility Validation Rules

- **Adding an optional field**: backward and forward compatible
- **Removing an optional field**: backward compatible, not forward compatible
- **Adding a required field**: not backward compatible
- **Removing a required field**: forward compatible, not backward compatible
- **Changing field type**: incompatible in all modes
- **Renaming a field**: incompatible in all modes (treated as remove + add)

### Default Mode

New subjects default to `BACKWARD` compatibility. The default can be configured at the registry level.

## API Surface

### RESTful Endpoints

#### Schema Registration

```
POST /subjects/{subject}/versions
Content-Type: application/json

{
  "schema": { ... },
  "compatibility": "BACKWARD"  // optional, uses subject default
}

Response 200:
{ "id": 42, "version": 3 }

Response 409 (Compatibility Violation):
{
  "error_code": "COMPATIBILITY_VIOLATION",
  "message": "New schema is not backward compatible with version 2",
  "violations": [
    "Field 'user_id' type changed from string to integer"
  ]
}

Response 422 (Invalid Schema):
{
  "error_code": "INVALID_SCHEMA",
  "message": "Schema does not conform to JSON Schema draft 2020-12"
}
```

#### Schema Retrieval

```
GET /subjects/{subject}/versions/{version}
GET /subjects/{subject}/versions/latest
GET /schemas/ids/{id}
```

#### Compatibility Checking

```
POST /compatibility/subjects/{subject}/versions/{version}
Content-Type: application/json

{ "schema": { ... } }

Response 200:
{ "is_compatible": true }

Response 200 (incompatible):
{
  "is_compatible": false,
  "violations": [ "..." ]
}
```

#### Subject Management

```
GET /subjects
GET /subjects/{subject}/versions
DELETE /subjects/{subject}/versions/{version}  // soft-delete (deprecate)
PUT /subjects/{subject}/config
  { "compatibility": "FULL" }
```

#### Registry Configuration

```
GET /config
PUT /config
  { "default_compatibility": "BACKWARD" }
```

### Response Conventions

- All responses include `Content-Type: application/json`
- Error responses use a consistent envelope: `{ "error_code": "...", "message": "..." }`
- Pagination via `Link` headers for list endpoints
- ETags for cache validation on retrieval endpoints

## Failure Handling

### Registration Failures

| Failure | HTTP Status | Behavior |
|---------|-------------|----------|
| Schema invalid | 422 | Reject with validation details |
| Compatibility violation | 409 | Reject with violation list |
| Duplicate schema (same fingerprint) | 200 | Return existing version (idempotent) |
| Storage unavailable | 503 | Return `Retry-After` header; client retries |
| Concurrent registration race | 409 | Last-writer loses; retry with latest version |

### Retrieval Failures

| Failure | HTTP Status | Behavior |
|---------|-------------|----------|
| Subject not found | 404 | Return `SUBJECT_NOT_FOUND` error |
| Version not found | 404 | Return `VERSION_NOT_FOUND` error |
| Storage read failure | 503 | Return `Retry-After` header; serve from cache if available |

### Degradation Strategy

- **Read path**: cache the latest N versions per subject in a local LRU cache. On storage failure, serve from cache with a `X-Served-From-Cache: true` header and `Cache-Age` indicating staleness
- **Write path**: no writes accepted during storage unavailability. Return 503 with `Retry-After`. Do not queue writes — producers must retry
- **Compatibility check path**: if the full version history cannot be loaded for transitive checks, reject the registration with a clear error rather than silently skipping validation

### Consistency Guarantees

- Schema registration is atomic: either the schema is stored and the version is assigned, or nothing changes
- Version assignment uses optimistic concurrency control with a compare-and-swap on the subject's version counter
- The fingerprint index is updated in the same transaction as schema storage

## Operational Concerns

### Caching

- Read-through LRU cache for schemas, keyed by (subject, version)
- Cache-aside for subject configuration
- Cache invalidation on write: invalidate the subject's "latest" cache entry on new registration
- Cache TTL: configurable, default 5 minutes for configuration, indefinite for immutable schema versions

### Monitoring

| Metric | Type | Description |
|--------|------|-------------|
| `registry.schema.registered` | counter | Schemas registered (by subject) |
| `registry.schema.retrieved` | counter | Schema retrievals (by subject, version) |
| `registry.compatibility.check` | counter | Compatibility checks (by result) |
| `registry.compatibility.violation` | counter | Compatibility violations (by subject, mode) |
| `registry.storage.latency` | histogram | Storage operation latency |
| `registry.cache.hit_ratio` | gauge | Cache hit ratio |
| `registry.error` | counter | Errors by type |

### Alerting

- **Storage latency p99 > 500ms**: warning
- **Storage error rate > 1%**: critical
- **Compatibility violation spike (> 10/min)**: warning (may indicate producer misconfiguration)
- **Cache hit ratio < 80%**: warning

### Deployment

- The registry is deployed as a stateless service with an external storage backend (PostgreSQL or similar ACID-compliant store)
- Horizontal scaling via load balancer; all nodes share the same storage
- Schema data is append-only (versions are never mutated), simplifying replication and backup
- Blue-green deployment: new registry versions are backward compatible with existing schema data

### Backup and Recovery

- Continuous backup of the schema storage
- Point-in-time recovery capability
- Schema export/import API for migration between registry instances

## Design Rationale

This design follows the Soul constraints:

1. **Contract-first API design**: the registry is itself the contract enforcement mechanism, with a well-defined RESTful API surface
2. **Resilience over raw performance**: read-path degradation via caching, explicit failure modes on write path, no silent validation skipping
3. **Operational simplicity**: stateless service, append-only storage model, standard HTTP semantics
4. **Explicit failure handling**: every failure mode has a defined HTTP status, error code, and recovery path
