# NCIT Project Report (LaTeX)

Formatting follows **Nepal College of Information Technology — Academic Project Guidelines 2019** (`Project_Guideline-2019.pdf`).

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
- Header: project title; footer: `[current/total]` page numbers  
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

## Proposal sections (initial proposal)

1. Title page (`\maketitlepage`)  
2. Abstract + keywords (max ~250 words)  
3. Problem Statement  
4. Project Objectives  
5. Significance of the Study  
6. Literature Study/Review  
7. Proposed Methodology (includes UML 2.0 placeholders)  
8. Proposed Performance Analysis and Validation  
9. Proposed Deliverable/Output  
10. Project Task and Time Schedule  
11. Bibliography/References  

## Mid-term / final

Copy `proposal.tex` and add sections listed in the guideline PDF (e.g. Tasks Done So Far, Results and Discussion). For final reports, use `\frontmatter` before Acknowledgement and `\mainmatter` before Introduction.
