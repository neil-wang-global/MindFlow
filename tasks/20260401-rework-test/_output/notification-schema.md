# Notification Database Schema

## Overview
A 3NF-compliant relational schema for a notification system. This schema was produced after rework — the first attempt denormalized Channel attributes into the Delivery table, creating transitive dependencies. The corrected version maintains Channel as a separate entity.

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
| category | VARCHAR(50) | NOT NULL, CHECK(category IN ('system','marketing','transactional','alert')) |
| expires_at | TIMESTAMP | NULLABLE |

**3NF analysis**: All non-key attributes depend only on `notification_id` (the PK). No partial dependencies (single-column PK). No transitive dependencies — `title`, `body`, `priority`, `created_at`, `created_by`, `category`, and `expires_at` are all independent facts about the notification.

### recipients
| Column | Type | Constraints |
|--------|------|-------------|
| recipient_id | UUID | PK |
| external_user_id | VARCHAR(100) | NOT NULL, UNIQUE |
| email | VARCHAR(255) | UNIQUE, NOT NULL |
| phone | VARCHAR(20) | NULLABLE |
| device_token | VARCHAR(500) | NULLABLE |
| preferences_json | JSONB | NULLABLE |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() |

**3NF analysis**: All non-key attributes depend only on `recipient_id`. No partial or transitive dependencies.

### channels
| Column | Type | Constraints |
|--------|------|-------------|
| channel_id | UUID | PK |
| channel_name | VARCHAR(50) | NOT NULL, UNIQUE |
| is_active | BOOLEAN | NOT NULL, DEFAULT TRUE |
| provider | VARCHAR(100) | NOT NULL |
| provider_config | JSONB | NULLABLE |

**3NF analysis**: All non-key attributes depend only on `channel_id`. `provider` and `provider_config` depend on the channel identity, not on each other transitively — each channel has exactly one provider configuration. `is_active` is a direct attribute of the channel.

### notification_recipient_mapping
| Column | Type | Constraints |
|--------|------|-------------|
| notification_id | UUID | PK (composite), FK -> notifications |
| recipient_id | UUID | PK (composite), FK -> recipients |
| read_at | TIMESTAMP | NULLABLE |
| dismissed_at | TIMESTAMP | NULLABLE |

**3NF analysis**: Composite PK `(notification_id, recipient_id)`. Both `read_at` and `dismissed_at` are fully dependent on the composite key (they describe when a specific recipient interacted with a specific notification). No partial dependencies. No transitive dependencies.

### deliveries
| Column | Type | Constraints |
|--------|------|-------------|
| delivery_id | UUID | PK |
| notification_id | UUID | FK -> notifications, NOT NULL |
| recipient_id | UUID | FK -> recipients, NOT NULL |
| channel_id | UUID | FK -> channels, NOT NULL |
| status | VARCHAR(20) | NOT NULL, CHECK(status IN ('pending','sent','delivered','failed','bounced')) |
| sent_at | TIMESTAMP | NULLABLE |
| delivered_at | TIMESTAMP | NULLABLE |
| failure_reason | TEXT | NULLABLE |
| retry_count | INTEGER | NOT NULL, DEFAULT 0 |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() |

**3NF analysis**: All non-key attributes depend only on `delivery_id`. Channel information is referenced via `channel_id` FK — no channel attributes are stored here (corrected from the first attempt which denormalized `channel_name`, `channel_provider`, `channel_is_active` into this table). No partial or transitive dependencies.

## Indexes
- `idx_deliveries_notification_id` on `deliveries(notification_id)`
- `idx_deliveries_recipient_id` on `deliveries(recipient_id)`
- `idx_deliveries_channel_id` on `deliveries(channel_id)`
- `idx_deliveries_status` on `deliveries(status)`
- `idx_notifications_category` on `notifications(category)`
- `idx_notifications_created_at` on `notifications(created_at)`
- `idx_recipients_external_user_id` on `recipients(external_user_id)`

## Foreign Key Relationships
- `deliveries.notification_id` -> `notifications.notification_id`
- `deliveries.recipient_id` -> `recipients.recipient_id`
- `deliveries.channel_id` -> `channels.channel_id`
- `notification_recipient_mapping.notification_id` -> `notifications.notification_id`
- `notification_recipient_mapping.recipient_id` -> `recipients.recipient_id`

## Rework Note
The first attempt (preserved in `cache/step-2-schema-partial.md`) embedded channel attributes (`channel_name`, `channel_provider`, `channel_is_active`) directly into the `deliveries` table, creating transitive dependencies that violated 3NF. The corrected schema extracts the `channels` table and references it via FK. The `notification_recipient_mapping` table, which was missing from the first attempt, has also been added.
