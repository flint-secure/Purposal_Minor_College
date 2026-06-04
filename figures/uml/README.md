# UML 2.0 diagrams as code (PlantUML)

Diagrams are written in **PlantUML** (`.puml`) — text files you edit like code.

## Edit diagrams

| Source file | Diagram |
|-------------|---------|
| `src/01-use-case.puml` | Use case |
| `src/02-system-context.puml` | System context |
| `src/03-component.puml` | Component |
| `src/04-deployment.puml` | Deployment |
| `src/05-class-domain.puml` | Class |
| `src/06-sequence-identify.puml` | Sequence — identify |
| `src/07-sequence-score.puml` | Sequence — score |
| `src/08-activity-scoring.puml` | Activity — scoring |

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
open figures/uml/06-sequence-identify.pdf
```

## LaTeX integration

`sections/uml-figures.tex` uses `\umlfigure{label}{basename}{caption}`.
The basename matches the `.puml` filename (without extension).

## PlantUML syntax reference

- [plantuml.com](https://plantuml.com/guide)
- Use case: `@startuml` + `actor`, `usecase`, `rectangle`
- Sequence: `participant`, `->`, `alt` / `else` / `end`
- Class: `class`, `enum`, `-->`
- Activity: `start`, `if`, `partition`, `stop`
