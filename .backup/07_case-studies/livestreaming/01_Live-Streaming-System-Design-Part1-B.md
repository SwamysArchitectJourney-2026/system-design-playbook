---
learning_level: "Advanced"
prerequisites:
  - "./01_Live-Streaming-System-Design-Part1-A.md"
estimated_time: "25 minutes"
learning_objectives:
  - "Perform back-of-the-envelope capacity planning for a live streaming platform"
  - "Explain latency vs scalability trade-offs across common streaming protocols"
  - "Design a CDN and origin topology for global live broadcast"
related_topics:
  prerequisites:
    - "./01_Live-Streaming-System-Design-Part1-A.md"
  builds_upon:
    - "../VideoConferencing/02_Detailed-Design-Part1-H.md"
  enables: []
  cross_refs: []
---

# System Design: Large-Scale Live Streaming – Part 1-B (Capacity, Latency & CDN)

## 1. Capacity Planning (Back-of-the-Envelope)

In an evaluation, you rarely have exact numbers. What matters is how you **structure
assumptions** and reason about scale.

### 1.1 Viewership & Traffic Assumptions

Example scenario:

- **Daily active viewers**: 50 million users.
- **Peak concurrent viewers on a big event**: 5 million.
- **Average bitrate per viewer** (after ABR): 3 Mbps.
- **Ingest publishers**: 1–3 program feeds per event.

Rough bandwidth estimates:

- **Ingress** (from venue to cloud): ~10–30 Mbps per event (multiple cameras,
  high-bitrate mezzanine).
- **Egress to viewers at peak**:
  - `5,000,000 viewers × 3 Mbps ≈ 15,000,000 Mbps = 15 Tbps`.

You will **NOT** push all of this from a single region or origin. This is where
CDNs and regional edges are critical.

### 1.2 Origin & CDN Load

We want:

- Origins to serve **CDN PoPs**, not every client.
- CDNs to cache the segments and fan-out close to viewers.

If a CDN achieves an 80–90% cache hit ratio on segments:

- **Origin Egress** ≈ 10–20% of total.
- Using 80% hit ratio: `15 Tbps × 0.2 = 3 Tbps` from origins.

Origins are typically **multiple regional clusters**, not a single machine. You
might spread this across, say, 3 major regions (Americas, EMEA, APAC):

- ≈ 1 Tbps origin egress per macro-region (very rough planning number).

## 2. Latency vs Scalability Trade-offs

Live streaming has a **latency–scale** trade-off. Different protocols sit at
different points on that curve.

### 2.1 Protocol Options

- **HLS/DASH (HTTP-based segmented streaming)**:
  - Pros: Highly scalable, CDN-friendly, well supported on devices.
  - Cons: Latency typically 10–30 seconds (chunk sizes, buffering).
- **Low-Latency HLS/DASH (LL-HLS, CMAF)**:
  - Pros: Latency can drop to 2–7 seconds while retaining CDN benefits.
  - Cons: More complex player logic; partial segments and HTTP/2/3 tuning.
- **WebRTC-based streaming**:
  - Pros: Sub-second latency; great for interactive low-latency broadcast.
  - Cons: Harder to scale to millions without complex SFU trees; not as CDN-
    friendly as HTTP segment delivery.

### 2.2 Choosing the Right Point

Evaluation framing:

- For **massive fan-out** (sports finals, concerts):
  - Prefer LL-HLS / CMAF or conventional HLS with carefully tuned segments.
  - Accept a few seconds of latency for predictable scale.
- For **low-latency niche use cases** (auctions, betting, real-time trading):
  - Consider WebRTC or hybrid architectures (WebRTC for VIP/ultra-low-latency
    users, LL-HLS for the majority).

Key talking point:

> "For this design, I will assume LL-HLS/CMAF with ~3–7 seconds latency, because
> it balances global scale, device support, and CDN efficiency."

## 3. CDN & Origin Topology

### 3.1 Hierarchical Distribution

A common pattern is a **multi-tier tree**:

1. **Primary Ingest Region**:
   - Receives RTMP/SRT input from venue.
   - Runs initial transcode into high-quality mezzanine.
2. **Transcode/Packager Layer** (possibly in multiple regions):
   - Produces ABR ladder and segments (HLS/DASH/LL-HLS).
3. **Regional Origins**:
   - Store the latest segments for events in that region.
4. **CDN PoPs / Edge Nodes**:
   - Cache segments, handle most viewer requests.

Text view:

```text
[Venue Cameras] -> [Primary Ingest] -> [Transcode/Packager]
                      |
                      v
               [Regional Origins]
                      |
                      v
                 [CDN Edge PoPs]
                      |
                      v
                 [Viewers (Players)]
```

### 3.2 Geographic Routing

- Use **Anycast DNS** or a managed global front door to route viewers to the
  closest edge.
- Keep ingest regions close to the event location, but make sure **transcoded
  output** is replicated across multiple regions for resilience.

### 3.3 Failure Domains

Design so that failures are contained:

- **Per-event isolation**: Each large event can use its own origin bucket and
  logical partitioning.
- **Regional failover**: If one region fails, CDN can pull from a secondary
  origin in another region.
- **Graceful degradation**: Drop some renditions (e.g., 4K) before impacting
  lower resolutions.

## 4. QoE (Quality of Experience) Metrics

Technical metrics must connect back to **viewer-perceived quality**.

### 4.1 Key Metrics

- **Startup Time**: Time from "Play" to first frame.
- **Rebuffer Ratio**: Total time spent buffering / total play time.
- **Average Bitrate**: Effective bitrate actually delivered to viewers.
- **Join Success Rate**: Successful starts vs attempts.
- **Error Rate**: Playback errors, HTTP 4xx/5xx, player crashes.

### 4.2 Data Collection

- **Client-side SDK**:
  - Sends playback events: `startup`, `buffer_start`, `buffer_end`, `bitrate_change`.
  - Periodically reports QoE stats to a telemetry endpoint.
- **Server/CDN logs**:
  - Requests per segment and manifest.
  - Edge vs origin hit ratio.

### 4.3 Using QoE in Operations

- **Alerting**:
  - Rebuffer ratio > threshold for a region.
  - Sudden drop in average bitrate.
  - Spike in startup time.
- **Automated Actions** (future/advanced):
  - Adjust ABR ladder (disable highest bitrate temporarily).
  - Shift traffic away from a troubled CDN PoP.

## 5. Evaluation Walkthrough Pattern

When asked "How would you scale live streaming to millions of users?":

1. **Clarify requirements**: latency target, regions, devices.
2. **Describe pipeline**: ingest → transcode → package → origin → CDN → player.
3. **Do quick math**: peak concurrency, per-user bitrate, total egress.
4. **Explain CDN usage**: cache hit ratio, reduce origin load.
5. **Discuss latency choices**: why LL-HLS/CMAF or HLS vs WebRTC.
6. **Highlight QoE metrics**: startup, rebuffer, bitrate.
7. **Mention failure handling**: regional failover, graceful degradation.

This connects cleanly back to the broadcast ideas in the original
VideoConferencing source material, but framed as a distinct, broadcast-focused
system design scenario.
