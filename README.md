# NCIT Project Report (LaTeX) — Flint Secure

College **minor-project proposal** (PDF) and UML for **Flint Secure**. The running product is developed in a separate repository:

**Planning docs (future tense — for authors & UML):** [`docs/README.md`](docs/README.md)  
**Optional dev codebase:** `/Users/pablo/Development/Work/Flintsecure/flint_secure` (do not describe as “implemented” in the proposal PDF; see [`docs/WRITING-GUIDE.md`](docs/WRITING-GUIDE.md))

Formatting follows **Nepal College of Information Technology — Academic Project Guidelines 2019** (`Project_Guideline-2019.pdf`). Sample **final** reports in `Refrence_pdf_projects_old/` are not the proposal template.

## Files

| File | Purpose |
|------|---------|
| `ncitproject.cls` | Document class (margins, fonts, title page, page numbers, sections) |
| `proposal.tex` | Example **Major Project Proposal** (8–10 pages when filled) |
| `Makefile` | Build PDF |

## Build (XeLaTeX + Times New Roman)

```bash
make pdf
open proposal.pdf
```

The document uses **Times New Roman** via `fontspec` and **Arial Black** on the college banner (macOS system fonts).

Install [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) in Cursor for build-on-save.

## Document types

Use class options on the first line:

```latex
\documentclass[proposal,major]{ncitproject}   % Major proposal (default)
\documentclass[midterm,major]{ncitproject}     % Mid-term report
\documentclass[final,major]{ncitproject}       % Final report
\documentclass[proposal,minor]{ncitproject}    % Minor project
\documentclass[proposal,first]{ncitproject}    % Project I
```

## Metadata (title page — Appendix A)

```latex
\ProjectTitle{Your Project Title}
\DegreeName{Bachelor of Engineering in ...}
\DepartmentName{Computer Engineering}
\SupervisorName{Name}
\SupervisorDesignation{Designation}
\SubmissionDate{04 Jun 2026}
\SetStudents{%
  Student One & Roll No.: 123 \\
  Student Two & Roll No.: 456 \\
}
\maketitlepage
```

## What the class enforces

- A4, portrait, 1″ margins + 0.5″ left binding offset  
- Times New Roman 12 pt body; Helvetica bold 20 pt college name on cover  
- 1.5 line spacing; 6 pt paragraph spacing  
- No header; footer: Roman (`I`, `II`…) on abstract and front lists, then Arabic (`1`, `2`…) from Problem Statement onward (per guideline)  
- Each `\section` starts on a new page; legal-style numbering (1, 1.1, …)  
- Centred figures/tables with captions; numbered equations  
- `\frontmatter` → Roman pages; `\mainmatter` → Arabic (for final reports)  

## UML 2.0 figures (code)

Diagrams are **PlantUML source** in `figures/uml/src/*.puml`. Build PDFs with:

```bash
make uml   # or: brew install plantuml && make uml
make pdf
```

Edit any `.puml` file, run `make uml`, then `make pdf` to update the proposal. See `figures/uml/README.md`.

## Deferred sections (not in initial proposal)

Saved in `archive/` for later reports:

- `archive/scope-and-limitations.tex`
- `archive/future-work.tex`

## Proposal sections (NCIT Guidelines 2019 — initial proposal, 8–10 pages)

Matches `Project_Guideline-2019.pdf` (not the long **final** reports in `Refrence_pdf_projects_old/`).

1. Title page (Appendix A: 14 pt body, 16 pt title, Arial Black college name)  
2. **ABSTRACT** (single paragraph, max 250 words) + **Keywords:** (≥10)  
3. Problem Statement  
4. Project Objectives (one **Main Objective** subsection)  
5. Significance of the Study  
6. Literature Study/Review (≥15% of body text)  
7. Proposed Methodology / technical description (SDLC, tools table, build steps, UML 2.0)  
8. Proposed Performance Analysis and Validation Scheme  
9. Proposed Deliverable/Output  
10. Project Task and Time Schedule  
11. Bibliography/References  

**Deferred** (saved in `archive/`, not in the initial proposal): Scope and Limitations, Further Works.

## Mid-term / final

Copy `proposal.tex` and add sections listed in the guideline PDF (e.g. Tasks Done So Far, Results and Discussion). For final reports, use `\frontmatter` before Acknowledgement and `\mainmatter` before Introduction.
