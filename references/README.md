# Project references (PDF library)

Full-text copies of sources cited in `proposal.pdf`, plus open supplementary reports.

## Folders

| Folder | Contents |
|--------|----------|
| `papers/` | One file per bibliography entry in `sections/body.tex` |
| `supplementary/` | Extra open reports (not in the numbered bibliography) |
| `MANUAL-DOWNLOAD.md` | Papers that need browser / college library access |

## Download status (last run)

| File | Citation | Status |
|------|----------|--------|
| `01-fiu-nepal-annual-report-2023-24.pdf` | FIU-Nepal (2024) | Downloaded (NRB official PDF, ~33 MB) |
| `02-eckersley-2010-browser-uniqueness.pdf` | Eckersley (2010) | Downloaded (EFF / PETS, open) |
| `03-laperdrix-2016-beauty-and-beast.pdf` | Laperdrix et al. (2016) | **Manual** — HAL blocks automated download |
| `04-vastel-2018-fp-stalker.pdf` | Vastel et al. (2018) | **Manual** — IEEE / HAL |
| `05-bolton-hand-2002-fraud-review.pdf` | Bolton & Hand (2002) | **Manual** — Project Euclid blocks bots |
| `06-west-bhattacharya-2016-fraud-review.pdf` | West & Bhattacharya (2016) | **Partial / retry** — Elsevier paywall; mirror may be incomplete |
| `07-fiore-2019-gan-fraud.pdf` | Fiore et al. (2019) | **Manual** — ScienceDirect / university access |
| `08-dalpozzolo-2015-calibrating-probability.pdf` | Dal Pozzolo et al. (2015) | Downloaded (author PDF, open) |
| `09-mjaaland-2021-sim-swap.pdf` | Mjaaland et al. (2021) | **Manual** — IEEE Xplore |

**Supplementary:** `supplementary/ENISA-countering-sim-swapping.pdf` (EU agency report on SIM swap — useful background for the SIM-swap part of the proposal).

## Re-download everything

```bash
./scripts/download-references.sh
```

Automated download only works for **open** URLs. For the rest, follow `MANUAL-DOWNLOAD.md` (save PDFs into `papers/` with the same filenames).

## Legal note

Use these copies for **your own study and citation** in the NCIT project. Do not redistribute paywalled publisher PDFs. Prefer official open links where listed in `SOURCES.md`.

## Git

Large PDFs are listed in `.gitignore` so the repo stays small. Keep this folder on your laptop or a shared drive for the team.
