# Notification Schema (PARTIAL — 3NF VIOLATION)

## Status: FAILED — 3NF violation detected

## Tables

### notifications
| Column | Type | Constraints |
|--------|------|-------------|
| notification_id | UUID | PK |
| title | VARCHAR(255) | NOT NULL |
| body | TEXT | NOT NULL |
| priority | VARCHAR(20) | NOT NULL, CHECK(priority IN ('low','medium','high','critical')) |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() |
| created_by | VARCHAR(100) | NOT NULL |
| category | VARCHAR(50) | NOT NULL |
| expires_at | TIMESTAMP | NULLABLE |

### recipients
| Column | Type | Constraints |
|--------|------|-------------|
| recipient_id | UUID | PK |
| external_user_id | VARCHAR(100) | NOT NULL |
| email | VARCHAR(255) | UNIQUE |
| phone | VARCHAR(20) | NULLABLE |
| device_token | VARCHAR(500) | NULLABLE |
| preferences_json | JSONB | NULLABLE |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() |

### deliveries
| Column | Type | Constraints |
|--------|------|-------------|
| delivery_id | UUID | PK |
| notification_id | UUID | FK -> notifications, NOT NULL |
| recipient_id | UUID | FK -> recipients, NOT NULL |
| channel_name | VARCHAR(50) | NOT NULL |
| channel_provider | VARCHAR(100) | NOT NULL |
| channel_is_active | BOOLEAN | NOT NULL |
| status | VARCHAR(20) | NOT NULL |
| sent_at | TIMESTAMP | NULLABLE |
| delivered_at | TIMESTAMP | NULLABLE |
| failure_reason | TEXT | NULLABLE |
| retry_count | INTEGER | DEFAULT 0 |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() |

## 3NF Violation Analysis

**VIOLATION in `deliveries` table**: The columns `channel_name`, `channel_provider`, and `channel_is_active` create a transitive dependency. These attributes depend on the channel identity (which should be a separate entity referenced by FK), not on the delivery_id. Specifically:
- `delivery_id -> channel_name -> channel_provider` (transitive dependency)
- `delivery_id -> channel_name -> channel_is_active` (transitive dependency)

The Channel entity from requirements was incorrectly denormalized into the deliveries table, violating 3NF by introducing transitive dependencies between non-key attributes.

**Missing**: `notification_recipient_mapping` table was not yet created.
