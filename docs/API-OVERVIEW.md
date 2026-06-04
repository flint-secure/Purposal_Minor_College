# Planned API overview — Flint Secure

Specification of the HTTP surface **we plan to build** for the minor project.  
Use future tense in the proposal; see [WRITING-GUIDE.md](WRITING-GUIDE.md).

**Planned base URL (development):** `http://localhost:8080`

## Authentication (planned)

| Route group | Header |
|-------------|--------|
| `/v1/identify`, `/v1/score`, `/v1/admin/*`, `/v1/dashboard/*` | `X-API-Key` |
| `/v1/super/*` | `X-Super-Admin-Key` |
| Optional | HMAC request signing + timestamp window |

## Health (planned)

| Method | Path |
|--------|------|
| GET | `/health`, `/health/live`, `/health/ready` |

## Core fraud APIs (proposal focus)

### POST `/v1/identify` (planned)

**Purpose:** Resolve or create `device_id`.

**Request:** `local_fp` plus SDK signal payload.

**Response:** `device_id`, `confidence`, `match_method`, optional network metadata.

---

### POST `/v1/score` (planned)

**Purpose:** Risk decision for one transaction.

**Request:** `device_id`, `sender_id`, `amount`, optional receiver and hashed phone fields.

**Response:** `score`, `decision` (`ALLOW` | `FLAG` | `BLOCK`), `reasons`, `breakdown`, timing.

**Side effect:** Event `transactions.scored` on NATS (async, fail-open).

## Client admin (planned)

| Method | Path |
|--------|------|
| POST | `/v1/admin/keys` |
| GET | `/v1/admin/keys` |
| DELETE | `/v1/admin/keys/{id}` |

## Dashboard / analyst (planned)

| Method | Path |
|--------|------|
| GET | `/v1/dashboard/stats` |
| GET | `/v1/dashboard/transactions` |
| GET | `/v1/dashboard/devices` |
| GET | `/v1/dashboard/alerts` |
| POST | `/v1/dashboard/fraud` |
| POST | `/v1/dashboard/alerts/{id}/resolve` |
| GET | `/v1/dashboard/quota` |
| GET | `/v1/dashboard/identity/phone/{hash}/devices` |
| GET | `/v1/dashboard/identity/device/{id}/phones` |
| GET | `/v1/dashboard/identity/user/{id}/devices` |

A Next.js dashboard **will** consume these routes for demos and pilot operations.

## Platform super-admin (planned)

| Method | Path |
|--------|------|
| GET | `/v1/super/health`, `/v1/super/stats` |
| GET/POST | `/v1/super/clients` |
| GET/PATCH | `/v1/super/clients/{slug}` |
| POST/GET | `/v1/super/clients/{slug}/keys` |
| DELETE | `/v1/super/clients/{slug}/keys/{id}` |

## SDK integration (planned)

| Platform | Role |
|----------|------|
| JavaScript | Browser fingerprint + API client |
| Android | Kotlin SDK for wallet / banking apps |
| iOS | Swift SDK for wallet / banking apps |

SDKs **will** hash signals client-side, call `/v1/identify`, then `/v1/score` on transactions.

## Messaging (planned)

| Subject | Producer | Consumers |
|---------|----------|-----------|
| `device.first_seen` | Identify API | Device indexer worker |
| `transactions.scored` | Score API | Profile, recipient, trust, transaction workers |

JetStream streams **will** separate device, transaction, and fraud channels.

## Validation (planned)

| Activity | Tool |
|----------|------|
| Functional API suite | Automated tests (target 168 cases) |
| Load / latency | k6 scripts (target P95 &lt; 50 ms, ≥3,200 RPS) |
| End-to-end smoke | Short integration script |

Results **will** appear in the mid-term and final reports, not as completed facts in the initial proposal.
