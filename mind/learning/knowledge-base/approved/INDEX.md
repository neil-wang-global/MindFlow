# Approved Knowledge Index

| File | Type | Summary |
|------|------|---------|
| kb-concept-token-bucket-mechanism.md | concept | Token bucket algorithm: fixed-capacity bucket with constant-rate token addition controls traffic conformance and allows bursts |
| kb-concept-token-leaky-equivalence.md | concept | Token bucket and leaky bucket (as meter) are mathematically equivalent mirror images |
| kb-concept-circuit-breaker-states.md | concept | Circuit breaker pattern: three-state proxy (Closed, Open, Half-Open) monitors failure counts and transitions between states based on configurable thresholds |
| kb-concept-circuit-breaker-timeout.md | concept | Circuit breaker timeout for Open-to-Half-Open transition should use increasing (exponential backoff) strategy rather than static timeout |
| kb-concept-cap-impossibility.md | concept | CAP theorem: no distributed data store can simultaneously provide consistency, availability, and partition tolerance; practical choice is CP vs AP |
| kb-concept-cap-classification.md | concept | Distributed databases classified as CP (MongoDB, Redis) or AP (Cassandra, CouchDB) based on partition behavior; no distributed NoSQL is CA |
| kb-concept-pacelc-extension.md | concept | PACELC extends CAP with latency-consistency trade-off during normal operation; four models (PA/EL, PA/EC, PC/EL, PC/EC) |
