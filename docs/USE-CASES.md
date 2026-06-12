# Proposed use cases — Flint Secure

**Initial proposal catalogue** — all flows below are **planned** behaviour for the system we will build this semester.  
Use this file for UML (`figures/uml/src/01-use-case.puml`) and `sections/body.tex`.  
Tense: **will** / **planned** (see [WRITING-GUIDE.md](WRITING-GUIDE.md)).

## Actors

| Actor | Description | Planned interface |
|-------|-------------|-------------------|
| **PSP backend** | Payment service provider integrating Flint at checkout or wallet | Server HTTP + API key |
| **End-user device (SDK)** | Mobile or browser client collecting signals | `POST /v1/identify`, `POST /v1/score` |
| **Fraud / risk analyst** | Staff reviewing alerts and confirming fraud | Web dashboard |
| **Client admin** | PSP technical staff managing integration keys | `/v1/admin/keys` |
| **Platform operator** | Flint operator onboarding tenants | `/v1/super/*` |
| **Async workers** | Background processors (system actor) | NATS JetStream |
| **Examiner / supervisor** | Proposal and later defenses | `proposal.pdf`, demo, Appendix B log |

## Primary use cases (proposal UML)

### UC-01 — Identify device (planned)

| Field | Detail |
|-------|--------|
| **Goal** | Return a stable `device_id` after browser or OS updates |
| **Actors** | SDK, PSP backend |
| **API** | `POST /v1/identify` |
| **Preconditions** | Valid API key; SDK will send `local_fp` and signal bundle |
| **Main flow** | The API **will** (1) match exact `local_fp` in persistent Redis (Layer 1); (2) recover via stored device ID if drift occurred (Layer 2); (3) fuzzy-match within a block key (Layer 3); (4) otherwise create a new device ID, store metadata, and publish `device.first_seen` for async indexing; (5) update velocity counters in the background. |
| **Postconditions** | Client receives `device_id`, confidence, and match method |

### UC-02 — Score transaction (planned)

| Field | Detail |
|-------|--------|
| **Goal** | Return score 0–100 and decision `ALLOW`, `FLAG`, or `BLOCK` within the latency target |
| **Actors** | SDK, PSP backend |
| **API** | `POST /v1/score` |
| **Preconditions** | `device_id`, `sender_id`, `amount`; optional hashed phone fields |
| **Main flow** | The API **will** authenticate, prefetch Redis signals, enrich network context, run a pure in-memory scoring function, return reasons and breakdown, then asynchronously update velocity and publish `transactions.scored` (messaging failures **will not** block the HTTP response). |
| **Postconditions** | PSP receives a decision; workers **will** update profiles over time |

### UC-03 — Review alerts and report fraud (planned)

| Field | Detail |
|-------|--------|
| **Goal** | Allow analysts to review flagged traffic and label outcomes |
| **Actors** | Fraud analyst |
| **Planned API** | Dashboard routes for alerts, fraud reports, resolution |
| **Main flow** | Analyst **will** list alerts, inspect transactions/devices, submit fraud labels, and resolve cases; workers **will** adjust trust and labels downstream |

### UC-04 — Manage client API keys (planned)

| Field | Detail |
|-------|--------|
| **Goal** | Rotate integration secrets per PSP tenant |
| **Actors** | Client admin |
| **Planned API** | Create, list, revoke keys under `/v1/admin/keys` |

## Supporting use cases (optional in proposal diagram)

| ID | Summary |
|----|---------|
| UC-05 | Platform operator **will** onboard PSP clients (`/v1/super/clients`) |
| UC-06 | Analyst **will** inspect identity links (phone hash ↔ device ↔ user) |
| UC-07 | System **will** expose quota usage per client |
| UC-08 | Dashboard **will** show stats, transactions, and devices |
| UC-09 | Workers **will** build behavioural profiles from scored events |
| UC-10 | Graph worker **will** flag suspected money-mule patterns |
| UC-11 | Config sync **will** refresh per-client weights in Redis |
| UC-12 | Integration **will** support optional HMAC signing and rate limits |

## Proposal defense activities (documentation only)

| ID | Activity |
|----|----------|
| UC-P1 | **Will** run an automated API test suite (target: 168 cases, ≥92% pass) |
| UC-P2 | **Will** run k6 load tests for P95 latency and throughput targets |
| UC-P3 | **Will** demo ALLOW / FLAG / BLOCK in a 10-minute presentation |
| UC-P4 | **Will** maintain supervisor meeting log (Appendix B) |

## UML mapping

| Diagram | File | Planned coverage |
|---------|------|------------------|
| Use case | `01-use-case.puml` | UC-01–UC-05 (core) |
| Activity scoring | `02-activity-scoring.puml` | UC-02 branches |
| Class domain | `03-class-domain.puml` | Planned entities |
| Sequence identify | `04-sequence-identify.puml` | UC-01 |
| Sequence score | `05-sequence-score.puml` | UC-02 |
| Component | `06-component.puml` | API + workers |
| Deployment | `07-deployment.puml` | Planned Docker/cloud layout |
| Package context | `08-package-context.puml` | System context / logical grouping |

## Out of scope for initial proposal

- Machine-learning scoring (see `../archive/future-work.tex`)
- Production hardening checklist (final report)
