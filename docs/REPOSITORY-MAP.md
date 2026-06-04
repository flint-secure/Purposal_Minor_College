# Planned repository layout

Folder structure **we plan to use** when implementing Flint Secure during the semester.  
This is a design map for the team—not evidence of completed work for the proposal.

Optional development may live under  
`/Users/pablo/Development/Work/Flintsecure/flint_secure`; paths below mirror that layout for convenience.

## Planned top-level

| Path | Planned role |
|------|----------------|
| `api/` | Go HTTP service |
| `workers/` | Go NATS consumers |
| `sdk/` | Browser SDK |
| `sdk_android/` | Android SDK |
| `sdk_ios/` | iOS SDK |
| `dashboard/` | Next.js operations UI |
| `infra/sql/` | PostgreSQL migrations |
| `docker-compose.yml` | Local dev stack |
| `figures/uml/` | UML sources (in **Propasal-small** proposal repo) |

## Planned Go API packages

| Package | Responsibility |
|---------|----------------|
| `handlers/` | identify, score, dashboard, admin, health |
| `scoring/` | Rule-based engine |
| `matching/` | Fuzzy device match |
| `store/` | Redis access |
| `velocity/` | Sorted-set counters |
| `middleware/` | GeoIP, rate limit, signing |
| `messaging/` | NATS client |
| `db/` | PostgreSQL pool |

## Planned workers

| Module | Responsibility |
|--------|----------------|
| `device_indexer` | New devices → Postgres |
| `transaction_indexer` | Scored transactions |
| `profile_builder` | User behaviour profiles |
| `recipient_risk` | Recipient aggregates |
| `device_trust` | Trust adjustments |
| `config_cache` | Client weights in Redis |
| `graph_engine` | Mule / graph analysis |

## Cross-links (proposal repo)

| Artifact | Purpose |
|----------|---------|
| `docs/USE-CASES.md` | Proposed use cases |
| `sections/body.tex` | Printable proposal (future tense) |
| `figures/uml/src/*.puml` | Design diagrams |

For private dev progress only, see [INTERNAL-DEV-NOTES.md](INTERNAL-DEV-NOTES.md).
