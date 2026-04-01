# Notification System Requirements

## Overview
Requirements for a notification database schema that stores notification records, recipient information, delivery channels, and delivery status tracking.

## Entities

### 1. Notification
- `notification_id` (PK): unique identifier for each notification
- `title`: notification title/subject
- `body`: notification content/message body
- `priority`: priority level (low, medium, high, critical)
- `created_at`: timestamp when the notification was created
- `created_by`: identifier of the system or user that created the notification
- `category`: notification category (system, marketing, transactional, alert)
- `expires_at`: optional expiration timestamp

### 2. Recipient
- `recipient_id` (PK): unique identifier for each recipient
- `external_user_id`: external system user identifier
- `email`: recipient email address
- `phone`: recipient phone number
- `device_token`: push notification device token
- `preferences_json`: notification preference settings
- `created_at`: timestamp when recipient was registered

### 3. Channel
- `channel_id` (PK): unique identifier for each channel
- `channel_name`: name of the delivery channel (email, sms, push, in-app)
- `is_active`: whether the channel is currently active
- `provider`: third-party provider name (e.g., SendGrid, Twilio)
- `provider_config`: provider-specific configuration

### 4. Delivery
- `delivery_id` (PK): unique identifier for each delivery attempt
- `notification_id` (FK): references Notification
- `recipient_id` (FK): references Recipient
- `channel_id` (FK): references Channel
- `status`: delivery status (pending, sent, delivered, failed, bounced)
- `sent_at`: timestamp when the notification was sent
- `delivered_at`: timestamp when delivery was confirmed
- `failure_reason`: reason for delivery failure (nullable)
- `retry_count`: number of retry attempts
- `created_at`: timestamp of the delivery record creation

### 5. NotificationRecipientMapping
- `notification_id` (FK, composite PK): references Notification
- `recipient_id` (FK, composite PK): references Recipient
- `read_at`: timestamp when the recipient read the notification (nullable)
- `dismissed_at`: timestamp when the recipient dismissed the notification (nullable)

## Relationships
- A Notification can be sent to many Recipients (many-to-many via NotificationRecipientMapping)
- A Delivery links one Notification to one Recipient via one Channel (many-to-one on each FK)
- A Recipient can receive deliveries through multiple Channels
- Each Delivery record tracks a single delivery attempt for a specific notification-recipient-channel combination

## Constraints
- `notification_id`, `recipient_id`, `channel_id`, `delivery_id` must be unique
- `Delivery.notification_id` must reference an existing Notification
- `Delivery.recipient_id` must reference an existing Recipient
- `Delivery.channel_id` must reference an existing Channel
- `status` values are restricted to: pending, sent, delivered, failed, bounced
- `priority` values are restricted to: low, medium, high, critical
- `category` values are restricted to: system, marketing, transactional, alert
- `email` should be unique per recipient
- `created_at` fields are non-nullable
