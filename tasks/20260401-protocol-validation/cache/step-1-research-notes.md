# Step 1 Research Notes: Token Bucket Algorithm

## Summary

The token bucket algorithm is a rate limiting mechanism used in packet-switched networks and API rate limiting. It uses a fixed-capacity bucket where tokens are added at a constant rate. Requests consume tokens; if tokens are available the request proceeds, otherwise it is rejected or queued.

## Key Parameters
- **Bucket capacity (b)**: Maximum tokens the bucket can hold — determines burst size
- **Token rate (r)**: Rate at which tokens are added — determines sustained average rate
- **Maximum burst size**: B_max = T_max * M where T_max = b/(M-r)

## Core Mechanism
1. Tokens added at rate r (one token every 1/r seconds)
2. Bucket holds at most b tokens; overflow tokens discarded
3. Packet of n bytes requires n tokens; if available, tokens removed and packet sent
4. If insufficient tokens, packet is non-conformant (dropped, queued, or marked)

## Comparison with Leaky Bucket
- The leaky bucket as a meter is mathematically equivalent (mirror image) to token bucket
- Token bucket: adds tokens regularly, removes for conforming packets
- Leaky bucket meter: removes (leaks) regularly, adds for conforming packets
- Given identical parameters, both classify the same packets as conforming/nonconforming
- Leaky bucket as a queue is a special case — produces jitter-free output but cannot allow bursts

## Key Trade-off
- Token bucket **allows bursts** up to bucket capacity while maintaining long-term average rate
- Leaky bucket as queue enforces **strict rate** with no burstiness
- Choice depends on whether burst tolerance is desired

## Sources
- src-001: Wikipedia Token Bucket article (verified, passed)
- src-002: Wikipedia Leaky Bucket article (verified, passed)
- Both sources verified by independent subagent — see acquire/verification-report.md
