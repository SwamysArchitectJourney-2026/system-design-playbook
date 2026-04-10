---
learning_level: "Advanced"
prerequisites:
  - "System Design Fundamentals"
  - "Distributed Systems and Networking Basics"
  - "../VideoConferencing/01_System-Design-Overview-Part1-A.md"
estimated_time: "25 minutes"
learning_objectives:
  - "Define functional and non-functional requirements for a large-scale live streaming platform"
  - "Explain why live broadcast architecture differs from interactive video conferencing"
  - "Describe the end-to-end live streaming pipeline from ingest to viewers at global scale"
related_topics:
  prerequisites:
    - "../VideoConferencing/01_System-Design-Overview-Part1-A.md"
  builds_upon:
    - "../VideoConferencing/02_Detailed-Design-Part1-H.md"
  enables:
    - "./01_Live-Streaming-System-Design-Part1-B.md"
  cross_refs: []
---

# System Design: Large-Scale Live Streaming – Part 1-A (Overview)

## 1. Problem Framing

### 1.1 Scenario

You are designing a **live streaming platform** that can broadcast:

- A sports final to millions of concurrent viewers.
- A keynote or live event with a single (or small set of) producers and a very large fan-out audience.

This is **not** an interactive “everyone can talk” meeting. It is **one-to-many (or few-to-many)** broadcast with strict latency and scale requirements.

### 1.2 Core Differences vs Video Conferencing

- **Interaction pattern**:
  - Live streaming: 1–few producers → many viewers.
  - Video conferencing: many-to-many, symmetric interaction.
- **Latency trade-offs**:
  - Live streaming: often targets low-latency, but can tolerate a few seconds of delay for stability and scale.
  - Conferencing: requires sub-second, tightly interactive latency.
- **Bandwidth & topology**:
  - Live streaming: heavy **fan-out**; must aggressively use CDNs and regional edges.
  - Conferencing: more balanced, managed via SFUs and TURN.

## 2. Requirements

### 2.1 Functional Requirements

- **Single or few live sources**:
  - Multiple cameras and audio inputs at the venue.
  - Ability to switch between sources (e.g., main camera, commentator camera, screen feed).
- **Global broadcast**:
  - Millions of concurrent viewers across regions and device types.
- **Device diversity**:
  - Mobile, web browsers, smart TVs, set-top boxes.
- **Quality adaptation**:
  - Adaptive bitrate streaming (ABR) for variable network conditions.
- **Basic interaction**:
  - Live chat / reactions (optional, via a separate low-bandwidth channel).

### 2.2 Non-Functional Requirements

- **Scalability**:
  - Handle sudden spikes (e.g., kickoff, key moments) without overload.
- **Latency**:
  - Target end-to-end glass-to-glass latency (e.g., 3–7 seconds for scalable HLS/DASH; possibly lower with LL-HLS or WebRTC-based streaming).
- **Reliability**:
  - No single point of failure in ingest or distribution.
- **Cost efficiency**:
  - Optimize egress costs by using CDNs and edge caching.
- **Observability**:
  - Real-time QoS metrics (rebuffering, bitrate, join success).

## 3. High-Level Architecture (Conceptual)

### 3.1 Ingest Path (Producer Side)

- **Input Manager**:
  - Aggregates multiple video and audio feeds from the venue.
  - Chooses which camera/audio mix is currently “on air”.
  - Encodes into one or more master streams (e.g., high-bitrate mezzanine).

### 3.2 Transcoding & Packaging

- **Transcoder Cluster**:
  - Converts the input stream into multiple bitrates and resolutions.
  - Outputs an **ABR ladder** (e.g., 1080p/720p/480p/360p).
- **Packager**:
  - Segments streams into small chunks (e.g., 2–6 seconds).
  - Produces manifests/playlists (HLS, DASH).

### 3.3 Distribution Layer

- **Origin Servers**:
  - Store the latest segments and manifests.
- **CDN / Edge Nodes**:
  - Distribute content globally, caching segments at edge locations.
  - Minimize latency and reduce origin load.

### 3.4 Playback

- **Client Player**:
  - Uses HLS/DASH or another streaming protocol.
  - Implements ABR to switch between qualities based on bandwidth and device capabilities.
  - Optionally exposes a **side channel** (WebSocket/HTTP) for chat and reactions.

## 4. Example Flow (Narrative)

1. Multiple cameras and microphones capture the event.
2. The **Input Manager** combines/switches feeds into a primary program stream.
3. The program stream is sent to a **Transcoder Cluster**.
4. Transcoders generate multiple quality renditions and send them to a **Packager**.
5. The Packager creates small media segments and manifests.
6. Segments/manifests are published to **Origin Servers**.
7. A **CDN** pulls from origin and serves content to viewers’ players from edge locations.
8. Players request manifests and segments, adapt bitrate, and render the stream.

## 5. Where This Module Fits in the Learning Path

- **Builds Upon**:
  - The networking, UDP/TCP, STUN/TURN, and scale concepts from the video conferencing module.
  - The high-level ideas of capacity planning and observability.
- **Adds**:
  - A **broadcast-optimized** architecture focused on pipeline (ingest → transcode → package → CDN).
  - Device/codec/ABR-centric thinking.
- **Leads To**:
  - Deeper modules (e.g., `Part1-B`) on:
    - Capacity planning for one-to-many fan-out.
    - Latency vs scalability trade-offs (e.g., CMAF/LL-HLS vs HLS).
    - Advanced analytics and QoE optimization.

## 6. Evaluation Angles to Emphasize

- Clear contrast between **live streaming vs conferencing**.
- The **tree-like fan-out** from a single ingest to many edge nodes.
- Use of **transcoders & CDNs** to offload origin and control costs.
- How to **degrade gracefully** (lower bitrate, lower resolution) instead of failing.
- Observability of QoE: rebuffer rate, startup time, average bitrate, error rates.
