# UML 2.0 diagrams as code (PlantUML)

Diagrams are written in **PlantUML** (`.puml`) — text files you edit like code.

Files are numbered in **UML 2.0 systematic order**: behavior diagrams first (requirements → processes → interactions), then structure diagrams (domain → architecture → deployment → context).

## Edit diagrams

| # | Source file | UML 2.0 type | Diagram |
|---|-------------|--------------|---------|
| 01 | `src/01-use-case.puml` | Behavior — Use Case | PlantUML reference copy (optional). **Proposal PDF** uses TikZ: `figures/use-case-diagram.tex`. |
| 02 | `src/02-activity-scoring.puml` | Behavior — Activity | Risk scoring workflow (UC-02 branches) |
| 03 | `src/03-class-domain.puml` | Structure — Class | Core domain model |
| 04 | `src/04-sequence-identify.puml` | Behavior — Interaction (Sequence) | Device identification flow (UC-01) |
| 05 | `src/05-sequence-score.puml` | Behavior — Interaction (Sequence) | Transaction scoring flow (UC-02) |
| 06 | `src/06-component.puml` | Structure — Component | Go API modules and workers |
| 07 | `src/07-deployment.puml` | Structure — Deployment | Oracle Cloud / Docker layout |
| 08 | `src/08-package-context.puml` | Structure — Package | System context (logical grouping) |

## Build

```bash
make uml    # .puml → PDF in figures/uml/
make pdf    # runs uml first, then LaTeX
```

**Requirements (recommended):**

```bash
brew install plantuml graphviz
```

This installs PlantUML and Graphviz (`dot`) for layout. A Java-only fallback downloads `tools/plantuml.jar` but may not produce valid PDFs without the brew packages above.

## Preview a single diagram

```bash
./scripts/build-uml.sh
open figures/uml/04-sequence-identify.pdf
```

## Proposal vs mid-term wording

Diagrams **`01-use-case`** and **`05-sequence-score`** (included in the initial proposal) use **plain-language** labels—no `/v1/...` paths. Other `.puml` files may keep technical endpoint names for later reports; canonical paths are in `docs/API-OVERVIEW.md`.

## LaTeX integration

`sections/uml-figures.tex` uses `\umlfigure[scale]{label}{basename}{caption}` (e.g.\ `01-use-case` PDF basename).
The basename matches the `.puml` filename (without extension).

## PlantUML syntax reference

- [plantuml.com](https://plantuml.com/guide)
- [uml-diagrams.org](https://www.uml-diagrams.org/) — UML 2.5 diagram taxonomy
- Use case: `actor`, `usecase`, `rectangle <<system>>`
- Activity: `start`, `if`, `partition`, `stop`
- Class: `class`, `enum <<enumeration>>`, `-->`, `..>`
- Sequence: `participant`, `->`, `alt` / `else` / `end`, `activate` / `deactivate`
- Component: `component`, `package`, `database`, `queue`
- Deployment: `node`, `artifact`, `cloud`
- Package: `package`, nested packages, dependencies between packages
