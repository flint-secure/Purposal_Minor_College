# Writing guide — initial proposal vs later reports

## Rule for `proposal.pdf` (proposal defense)

This document is an **initial project proposal**: it describes what the team **plans to do**, not what is already finished.

| Use in proposal | Avoid in proposal |
|-----------------|-------------------|
| will, shall, proposed, planned, expected to | implemented, built, deployed, completed, exists today |
| “The system **will** expose…” | “The system **exposes**…” |
| “Workers **will** consume…” | “Workers **consume**…” |
| “A 168-case suite **will be** developed” | “We have 168 tests passing” |
| **device identification API**, **transaction scoring API** | Raw URL paths such as `/v1/identify`, `/v1/score` |

The LaTeX source (`sections/body.tex`, `proposal.tex`) already follows this rule. **Do not** copy past tense from `docs/` into the PDF without editing.

**API path names** (`POST /v1/identify`, etc.) belong in `API-OVERVIEW.md` and the dev repo. The **proposal PDF** and its two UML figures (`01-use-case`, `07-sequence-score`) use plain-language labels only. Other PlantUML files in `figures/uml/src/` may keep technical paths for mid-term/final reports.

**Sections omitted from the initial proposal** (stored in `../archive/`): Scope and Limitations, Further Works (`future-work.tex`). Add them for mid-term or final reports with `\input{archive/...}`.

**Punctuation in proposal LaTeX:** Do not use `---` (em dash) or decorative `--` in body text. Use colons for step labels (`Step 1:`), parentheses for asides, and the word **to** for week ranges (`Weeks 2 to 3`). Bibliography page ranges may keep standard en-dashes (`235--255`).

**Page numbers (Guidelines 2019):** **Roman** (`I`, `II`, `III`…) on the abstract, Table of Contents, List of Tables, and List of Figures (footer and page column in those lists). **Arabic** (`1`, `2`, `3`…) from the first main section (Problem Statement) through the end. Figure/table entries in LOF/LOT show Arabic page numbers where the item appears in the body.

## What `docs/` is for

| Document | Tense | Audience |
|----------|-------|----------|
| `USE-CASES.md`, `ARCHITECTURE.md`, `API-OVERVIEW.md` | **Proposed** (future) | Authors, UML, defense slides |
| `INTERNAL-DEV-NOTES.md` | Dev status (past/present) | **Team only** — never paste into proposal |
| `REPOSITORY-MAP.md` | Neutral paths | Developers finding files in `flint_secure` |

## After proposal approval (mid-term / final)

Switch to past/present tense for completed work (“Tasks Done So Far”, “Results and Discussion”). Use `INTERNAL-DEV-NOTES.md` then to track progress.

## Separate dev repository

Work may proceed in `/Users/pablo/Development/Work/Flintsecure/flint_secure` during the semester. That does **not** change the proposal document type: the submitted **proposal** stays future-oriented unless the college asks for a revised proposal.
