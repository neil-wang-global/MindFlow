# Raw Source

## Source ID
- src-001

## ACQ Event
- ACQ-001 — the acquisition event that triggered this fetch; must match the corresponding entry in `search-log.md` and `verification-report.md`

## Source URL
- https://en.wikipedia.org/wiki/Token_bucket

## Fetch Timestamp
- 2026-04-01T10:02:00Z

## Source Type
- Technical Documentation

## Credibility Assessment
- High
- assessment is based on source authority only, not on content

## Fetch Status
- success

## Fetch Completeness
- complete

## Original Content

The **token bucket** is an algorithm used in packet-switched and telecommunications networks. It can check that data transmissions, as packets, conform to defined limits on bandwidth and burstiness (measuring unevenness in traffic flow). It also serves as a scheduling algorithm for determining transmission timing that complies with bandwidth and burstiness limits (see network scheduler).

## Overview

The algorithm uses an analogy of a fixed-capacity bucket into which tokens—typically representing a unit of bytes or a single packet of predetermined size—are added at a fixed rate. When checking a packet for conformance, the bucket is inspected for sufficient tokens. If enough tokens exist, the appropriate number are removed ("cashed in") and the packet passes through for transmission. If tokens are insufficient, the packet is non-conformant and the bucket contents remain unchanged. Non-conformant packets can be handled in several ways:

- They may be dropped.
- They may be enqueued for later transmission once enough tokens accumulate.
- They may be transmitted but marked as non-conformant, potentially dropped later during network overload.

A conforming flow can contain traffic averaging up to the token addition rate, with burstiness determined by bucket depth. This burstiness can be expressed as jitter tolerance (how much sooner a packet might conform than expected) or as burst tolerance/maximum burst size (how much traffic above average might conform in a finite period).

## Algorithm

The token bucket algorithm works conceptually as follows:

- A token is added to the bucket every 1/r seconds.
- The bucket holds at most b tokens. Tokens arriving when the bucket is full are discarded.
- When a packet of n bytes arrives:
  - If at least n tokens are in the bucket, n tokens are removed and the packet is sent to the network.
  - If fewer than n tokens are available, no tokens are removed and the packet is considered non-conformant.

### Variations

On platforms lacking sufficient clock resolution to add a single token every 1/r seconds, an alternative formulation exists. Given the ability to update the token bucket every S milliseconds, the number of tokens to add every S milliseconds equals (r * S) / 1000.

### Properties

#### Average rate

Over the long run, the output of conformant packets is limited by the token rate, r.

#### Burst size

Let M be the maximum possible transmission rate in bytes/second. Then T_max = b/(M-r) if r < M, infinity otherwise. This represents the maximum burst time—the duration for which rate M is fully utilized. The maximum burst size is thus B_max = T_max * M.

### Uses

The token bucket can be used in either traffic shaping or traffic policing. In traffic policing, nonconforming packets may be discarded or reduced in priority for downstream functions to drop during congestion. In traffic shaping, packets are delayed until conformant. Both approaches protect networks against excessive or bursty traffic (see bandwidth management and congestion avoidance). Traffic shaping is commonly applied in host network interfaces to prevent transmissions from being discarded by network traffic management functions.

The algorithm also controls database IO flow. In that context, "limitation applies to neither IOPS nor the bandwidth but rather to a linear combination of both." By defining tokens as the normalized sum of IO request weight and length, the algorithm ensures the time derivative of that function remains below a required threshold.

## Comparison to Leaky Bucket

The token bucket is directly comparable to one of two versions of the leaky bucket algorithm in the literature. The comparable version—the leaky bucket as a meter—mirrors the token bucket: conforming packets add fluid (equivalent to tokens removed in the token bucket) to a finite-capacity bucket, from which fluid drains at a constant rate (equivalent to the fixed-rate token addition).

A second version, the leaky bucket as a queue, is a special case of the meter version where conforming packets pass through the bucket. This version applies only to traffic shaping and generally does not permit bursty output (it is jitter-free), making it significantly different from the token bucket.

Both leaky bucket versions share the same name in the literature, creating "considerable confusion over the properties of that algorithm." However, fundamentally both algorithms are identical and, with correct implementation and identical parameters, classify the same packets as conforming or nonconforming.

## Hierarchical Token Bucket

The hierarchical token bucket (HTB) is a faster replacement for class-based queueing (CBQ) as a queuing discipline in Linux. It limits each client's download/upload rate to prevent any single client from saturating total bandwidth.

## References

1. "Implementing a New IO Scheduler Algorithm for Mixed Read/Write Workloads". 3 August 2022.
2. Turner, J., New directions in communications (or which way to the information age?). IEEE Communications Magazine 24(10): 8–15. ISSN 0163-6804, 1986.
3. Andrew S. Tanenbaum, Computer Networks, Fourth Edition, ISBN 0-13-166836-6, Prentice Hall PTR, 2003, page 401.
4. ATM Forum, The User Network Interface (UNI), v. 3.1, ISBN 0-13-393828-X, Prentice Hall PTR, 1995.
5. ITU-T, Traffic control and congestion control in B ISDN, Recommendation I.371, International Telecommunication Union, 2004, Annex A, page 87.
