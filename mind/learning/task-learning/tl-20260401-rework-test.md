# Task Learning Record

## Task ID
- 20260401-rework-test

## Task Summary
- Designed a notification database schema. Step 1 gathered requirements (5 entities: Notification, Recipient, Channel, Delivery, NotificationRecipientMapping). Step 2 designed the schema in 3NF. Step 2's first attempt failed due to a transitive dependency violation (Channel attributes denormalized into Delivery table). The rework failure policy was applied: partial output was preserved, preceding Step output and current Step constraints were re-read, and the second attempt produced a correct 3NF-compliant schema.
- Final deliverable: `tasks/20260401-rework-test/_output/notification-schema.md`

## External Acquisition
- Status: none

## Candidate Knowledge
- none

## Potential Capability Impact
- none

## Next Promotion Target
- none

## Notes
- This task was a protocol test for the rework failure policy. The rework protocol executed correctly: partial output was preserved in `cache/step-2-schema-partial.md`, the preceding Step's output (`cache/step-1-requirements.md`) and current Step's constraints were re-read before re-execution, and the second attempt succeeded within the max rework limit of 1.
