# Raw Source

## Source ID
- src-002

## ACQ Event
- ACQ-001 — the acquisition event that triggered this fetch; must match the corresponding entry in `search-log.md` and `verification-report.md`

## Source URL
- https://en.wikipedia.org/wiki/Leaky_bucket

## Fetch Timestamp
- 2026-04-01T10:02:30Z

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

The **leaky bucket** is an algorithm based on an analogy of how a bucket with a constant leak will overflow if either the average rate at which water is poured in exceeds the leak rate, or if more water than the bucket's capacity is poured in at once. It can determine whether a sequence of discrete events conforms to defined limits on their average and peak rates or frequencies, enabling actions to be limited to those rates or delayed until conformance is achieved. It may also check conformance to an average rate alone, removing any variation.

It is used in packet-switched computer networks and telecommunications networks for traffic policing, traffic shaping, and scheduling of data transmissions (in the form of packets) to defined limits on bandwidth and burstiness.

## Overview

Two different methods of applying the leaky bucket analogy appear in the literature. These yield what seem to be two different algorithms, both called "the leaky bucket algorithm," generally without reference to the other method — creating confusion about properties and behavior.

### Version 1: Leaky Bucket as a Meter

In one version, the bucket is a counter or variable separate from the traffic flow. This counter checks conformance only: it increments when a packet arrives (water added intermittently) and decrements at a fixed rate (water leaking out). The counter value represents the water level. If the counter stays below a specified limit when a packet arrives, the packet conforms to bandwidth and burstiness limits. This is referred to as the leaky bucket as a meter.

### Version 2: Leaky Bucket as a Queue

In the second version, the bucket is a queue in the traffic flow. Packets enter the queue as they arrive and are removed (first come, first served) usually at a fixed rate — equivalent to water leaking from the bucket. This configuration imposes conformance rather than checking it. When serviced at a fixed rate with equal-length packets, the output is necessarily devoid of burstiness or jitter.

### Equivalence

The leaky bucket as a meter is exactly equivalent to (a mirror image of) the token bucket algorithm — adding water to the leaky bucket mirrors removing tokens from the token bucket for conforming packets; water leaking mirrors regular token addition; and testing against overflow mirrors testing against underflow. Given equivalent parameters, both algorithms identify the same traffic as conforming or nonconforming. The leaky bucket as a queue can be seen as a special case of the meter version.

## As a Meter

Jonathan S. Turner is credited with the original description. He describes it as: "A counter associated with each user transmitting on a connection is incremented whenever the user sends a packet and is decremented periodically." If the counter exceeds a threshold upon incrementing, the network discards the packet.

The ITU-T in recommendation I.371 and the ATM Forum's UNI specification describe essentially the same meter version as the generic cell rate algorithm: "The continuous-state leaky bucket can be viewed as a finite capacity bucket whose real-valued content drains out at a continuous rate of 1 unit of content per time unit and whose content is increased by the increment T for each conforming cell."

### Uses

The meter version can serve in either traffic shaping or traffic policing. In ATM networks (as the GCRA), it compares bandwidth and burstiness of traffic on a virtual channel or virtual path against specified limits on cell arrival rate and maximum jitter.

### Parameters

Limits may include bandwidth and burstiness of the output. Bandwidth may be given as a packet rate, bit rate, or emission interval. Burstiness may be specified as delay variation tolerance or maximum burst size (MBS).

### Comparison with the Token Bucket Algorithm

The leaky bucket as a meter is often contrasted with the token bucket. These are mirror images: one adds regularly and removes for conforming packets down to zero; the other removes regularly and adds for conforming packets up to capacity. They are fundamentally the same algorithm described differently.

## As a Queue

The leaky bucket as a queue is essentially a simple FIFO buffer serviced at a fixed rate to remove burstiness or jitter. Andrew S. Tanenbaum describes it: "The leaky bucket consists of a finite queue. When a packet arrives, if there is room on the queue it is appended to the queue; otherwise it is discarded. At every clock tick one packet is transmitted (unless the queue is empty)."

## References

1. ITU-T, Traffic control and congestion control in B ISDN, Recommendation I.371, 2004, page 17
2. Turner, J., New directions in communications, IEEE Communications Magazine 24(10): 8–15, ISSN 0163-6804, 1986
3. Tanenbaum, A.S., Computer Networks, Fourth Edition, ISBN 0-13-166836-6, Prentice Hall PTR, 2003, page 401
4. ATM Forum, The User Network Interface (UNI), v. 3.1, ISBN 0-13-393828-X, Prentice Hall PTR, 1995
