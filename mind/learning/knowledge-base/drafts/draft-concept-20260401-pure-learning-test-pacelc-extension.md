# Draft Knowledge

## Type
- concept

## Task ID
- 20260401-pure-learning-test

## Summary
- PACELC extends CAP by adding latency-consistency trade-off during normal operation, producing four database configuration models

## From Task Learning
- mind/learning/task-learning/tl-20260401-pure-learning-test.md
- candidate knowledge item reference: KDC-003

## Source Type
- grounded-external

## Source Anchor
- tasks/20260401-pure-learning-test/acquire/raw-sources/src-002-pacelc-theorem.md
  - ACQ Event: ACQ-001
  - Verification Report: tasks/20260401-pure-learning-test/acquire/verification-report.md §ACQ-001
  - Verification Status: passed

## Original Excerpt
> "The PACELC design principle extends the CAP theorem for distributed database systems. It addresses what happens both **during** and **in the absence of** network partitions"

## Candidate Conclusion
- The PACELC theorem (Abadi 2010/2012, formally proved by Golab 2018) extends CAP by adding the latency-consistency trade-off during normal (non-partition) operation. This produces four configuration models (PA/EL, PA/EC, PC/EL, PC/EC) that more precisely classify real databases. PACELC is considered more comprehensive than CAP for cloud-scale systems where partitions are rare but latency-consistency trade-offs are constant. Publication details confirmed via ACQ-002: Golab's formal proof in ACM SIGACT News, vol. 49, pp. 73-81, "Proving PACELC."

## Review Status
- pending

## Review Target
- mind/learning/reviews/review-20260401-pure-learning-test-pacelc-extension.md

## Notes
- none
