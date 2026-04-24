# File System Organization for AI Projects & Customer Engagements

> **Audience:** Technical PMs, Engineers, Researchers, and Designers working on AI projects and customer engagements
> **Last Updated:** 2026-04-24
> **Methodology:** PARA + Stage-Gated Hybrid Structure

---

## Table of Contents

1. [Why This Matters](#1-why-this-matters)
2. [Core Methodology](#2-core-methodology)
3. [Top-Level Structure](#3-top-level-structure)
4. [Per-Engagement Structure](#4-per-engagement-structure)
5. [The 00-Index Folder](#5-the-00-index-folder)
6. [Naming Conventions](#6-naming-conventions)
7. [Document Lifecycle States](#7-document-lifecycle-states)
8. [Design-Specific Guidance](#8-design-specific-guidance)
9. [Research & Data Guidance](#9-research--data-guidance)
10. [Templates Folder](#10-templates-folder)
11. [Golden Rules for PMs](#11-golden-rules-for-pms)
12. [References](#12-references)

---

## 1. Why This Matters

AI projects are multi-disciplinary by nature — PMs, researchers, engineers, and designers all produce different artifact types (PRDs, datasets, model experiments, design specs, stakeholder decks) that need to coexist and remain findable throughout the engagement lifecycle.

Poor file organization in AI projects leads to:

- Lost or overwritten research and experiment results
- Version confusion on PRDs and design specs
- Slow onboarding for new team members
- Data integrity issues (edited "raw" files)
- Compliance risk from misplaced legal/privacy docs

A consistent structure eliminates these problems and makes collaboration seamless across roles.

---

## 2. Core Methodology

This guide uses a **PARA + Stage-Gated Hybrid** approach:

- **PARA** (Projects, Areas, Resources, Archive) provides the top-level organizational logic — created by Tiago Forte, *Building a Second Brain* (2022)
- **Stage-Gated subfolders** mirror the AI development lifecycle within each engagement, giving every document type a clear, predictable home
- **Johnny Decimal-inspired numbering** (00–09 prefix) enforces sort order and makes navigation fast without requiring memorization

> **Key principle:** The folder structure should match how the team *works*, not how an org chart is drawn. Organize by engagement first, then by work phase.

---

## 3. Top-Level Structure

```
AI-Projects/
├── _Templates/               ← Reusable folder + doc templates for new engagements
├── _Resources/               ← Shared reference: AI ethics, vendor docs, standards, guides
├── Engagements/              ← One subfolder per customer or internal engagement
└── Archive/                  ← Completed engagements, organized by YYYY/
    ├── 2025/
    └── 2026/
```

**Rules:**
- Prefix `_` on shared folders (`_Templates`, `_Resources`) keeps them sorted to the top
- Never store client files in `_Resources` — it is team-wide reference material only
- Move entire engagement folders to `Archive/YYYY/` upon project close — do not delete

---

## 4. Per-Engagement Structure

Each customer or project engagement gets its own folder under `Engagements/`. Copy the template from `_Templates/folder-structure-template/` at kickoff.

```
Engagements/
└── ClientName_ProjectName/
    ├── 00-Index/                   ← README, team roster, tool links, conventions
    ├── 01-Discovery/               ← Kickoff notes, stakeholder interviews, problem framing
    ├── 02-Research/                ← User research, market analysis, AI feasibility studies
    ├── 03-Design/                  ← UX flows, wireframes, AI model design, architecture diagrams
    ├── 04-Requirements/            ← PRDs, user stories, epics, acceptance criteria
    ├── 05-Delivery/                ← Sprint docs, release notes, test results, demo recordings
    ├── 06-Stakeholder/             ← Exec decks, meeting notes, decisions log, status updates
    ├── 07-Data/
    │   ├── raw/                    ← Original datasets — NEVER edited
    │   ├── processed/              ← Cleaned, transformed, feature-engineered data
    │   └── external/               ← Third-party or vendor-sourced datasets
    ├── 08-Models/                  ← Experiment logs, model checkpoints, evaluation results
    ├── 09-Legal-Compliance/        ← Contracts, AI risk assessments, data privacy/DPA docs
    └── _Archive/                   ← Superseded drafts and old versions from this engagement
```

### Folder Descriptions

| Folder | Owner | Typical Contents |
|--------|-------|-----------------|
| `00-Index` | PM | README.md, team roster, links to Figma/Notion/Jira |
| `01-Discovery` | PM / Research | Kickoff deck, interview notes, problem statement |
| `02-Research` | Research / PM | User interviews, competitive analysis, feasibility report |
| `03-Design` | Design / Eng | Architecture diagrams, UX wireframes, conversation flows |
| `04-Requirements` | PM | PRD, user stories, API specs, acceptance criteria |
| `05-Delivery` | Eng / PM | Sprint notes, QA results, release docs, changelogs |
| `06-Stakeholder` | PM | Exec summaries, decision logs, meeting notes, status decks |
| `07-Data` | Data / Research | Raw + processed datasets, data dictionaries |
| `08-Models` | ML Eng / Research | Experiment notebooks, eval metrics, model registry refs |
| `09-Legal-Compliance` | PM / Legal | MSA, DPA, AI risk register, ethics review docs |
| `_Archive` | All | Superseded files — retain, don't delete |

---

## 5. The 00-Index Folder

Every engagement must have a `00-Index/README.md` created **on Day 1**. This is the front door of your project — new team members should be able to orient themselves entirely from this file.

### README.md Template

```markdown
# [ClientName] — [ProjectName]

## Project Brief
One paragraph describing the engagement: what we're building, for whom, and why.

## Status
🟢 Active | 🟡 On Hold | 🔴 Blocked | ✅ Complete

## Team
| Name        | Role            | Contact            |
|-------------|-----------------|--------------------|
| Jane Smith  | PM              | jane@company.com   |
| John Lee    | ML Engineer     | john@company.com   |
| Sara Kim    | UX Designer     | sara@company.com   |

## Key Dates
- Kickoff: YYYY-MM-DD
- Target Launch: YYYY-MM-DD
- Review Cadence: Weekly Thursdays

## Tool Links
- **Jira / Linear:** [link]
- **Figma / FigJam:** [link]
- **Notion:** [link]
- **Data Store:** [link]
- **Model Registry:** [link]
- **Slack Channel:** #project-name

## Folder Conventions
- Naming format: `YYYY-MM-DD_Client_DocType_Topic_v#.ext`
- States: `_WIP` → `_REVIEW` → `_FINAL`
- Raw data: NEVER edit files in `07-Data/raw/`

## Key Documents
| Document | Location | Status |
|----------|----------|--------|
| PRD v2 | `04-Requirements/` | FINAL |
| Research Report | `02-Research/` | REVIEW |
| Architecture Diagram | `03-Design/` | WIP |
```

---

## 6. Naming Conventions

### Standard Format

```
YYYY-MM-DD_ClientName_DocType_Topic_v#.ext
```

### Examples

```
2026-04-24_AcmeCorp_PRD_ChatbotV2_v1.docx
2026-03-15_AcmeCorp_RES_UserInterviews_v2.pdf
2026-04-01_AcmeCorp_DES_ConversationFlow_FINAL.fig
2026-04-10_AcmeCorp_DECK_ExecutiveBriefing_v3.pptx
2026-04-20_AcmeCorp_EVAL_ModelAccuracyReport_v1.xlsx
2026-04-22_AcmeCorp_DATA_TrainingSet_CustomerFeedback_raw.csv
```

### Document Type Prefixes

| Prefix | Document Type | Typical Format |
|--------|--------------|----------------|
| `PRD` | Product Requirements Doc | .docx / .md |
| `RFC` | Request for Comments / Tech Spec | .md |
| `RES` | Research (user, market, technical) | .pdf / .docx |
| `DES` | Design file or architecture diagram | .fig / .png / .pdf |
| `DECK` | Presentation / stakeholder deck | .pptx / .pdf |
| `LOG` | Decision log, meeting notes | .md / .docx |
| `EVAL` | Model evaluation / test results | .xlsx / .md |
| `DATA` | Dataset reference or data dictionary | .csv / .xlsx |
| `RFC` | Technical specification or API contract | .md |
| `RISK` | Risk register, AI ethics review | .docx / .xlsx |

### Naming Rules

- Use `YYYY-MM-DD` for all dates — sorts chronologically
- Use hyphens (`-`) within topic names: `UserInterviews-Round2`
- Use underscores (`_`) as field separators
- No spaces, no special characters (`& # % $ @`)
- Limit filenames to 50 characters where possible
- Pad numbered sequences with leading zeros: `001`, `002`…

---

## 7. Document Lifecycle States

Every document moves through three states. Append the state as a filename suffix:

```
_WIP      → Actively being drafted or edited
_REVIEW   → Shared for feedback, awaiting sign-off
_FINAL    → Approved, locked — do not edit
```

### Lifecycle Example (PRD)

```
2026-04-01_AcmeCorp_PRD_ChatbotV2_v1_WIP.docx       ← PM drafting
2026-04-10_AcmeCorp_PRD_ChatbotV2_v2_REVIEW.docx    ← Shared with eng/design
2026-04-18_AcmeCorp_PRD_ChatbotV2_v3_FINAL.docx     ← Signed off, frozen
```

**When a doc reaches FINAL:**
- Move previous versions to `_Archive/`
- Keep only the FINAL version in the active folder
- Never rename or edit a FINAL file — create a new version instead

---

## 8. Design-Specific Guidance

Design assets span live tools (Figma, FigJam, Miro) and exported static files. Manage both separately.

### Live Design Tools
Store **links only** in `00-Index/README.md` — do not download or duplicate live tool files locally. This avoids stale copies and version drift.

### Exported/Static Design Files
Save to `03-Design/` when you need a snapshot for a milestone, review, or handoff:

```
03-Design/
├── architecture/
│   ├── 2026-03-10_AcmeCorp_DES_SystemArchitecture_v1.png
│   └── 2026-04-01_AcmeCorp_DES_SystemArchitecture_v2_FINAL.pdf
├── ux-flows/
│   ├── 2026-03-20_AcmeCorp_DES_OnboardingFlow_v1_WIP.png
│   └── 2026-04-15_AcmeCorp_DES_OnboardingFlow_v2_FINAL.pdf
└── conversation-design/
    └── 2026-04-10_AcmeCorp_DES_ChatbotDialogFlow_FINAL.pdf
```

### Design Handoff Checklist
- [ ] Export FINAL design as `.pdf` for record-keeping
- [ ] Link live Figma file in `00-Index/README.md`
- [ ] Include dev spec export or Dev Mode link for engineering
- [ ] Archive all WIP/REVIEW design exports to `_Archive/`

---

## 9. Research & Data Guidance

### Research Documents (`02-Research/`)

Organize by research type and round:

```
02-Research/
├── user-research/
│   ├── 2026-02-10_AcmeCorp_RES_InterviewGuide_v1_FINAL.docx
│   ├── 2026-02-20_AcmeCorp_RES_InterviewNotes_Round1_FINAL.docx
│   └── 2026-03-05_AcmeCorp_RES_SynthesisReport_v2_FINAL.pdf
├── market-research/
│   └── 2026-02-01_AcmeCorp_RES_CompetitiveLandscape_FINAL.pdf
└── ai-feasibility/
    └── 2026-03-01_AcmeCorp_RES_FeasibilityStudy_v1_FINAL.docx
```

### Data Files (`07-Data/`)

**The cardinal rule: Never edit files in `raw/`.**

```
07-Data/
├── raw/                    ← Immutable originals — read only
│   └── customer-feedback-export-2026-01.csv
├── processed/              ← Cleaned, transformed versions
│   ├── 2026-02-01_AcmeCorp_DATA_CustomerFeedback_cleaned_v1.csv
│   └── 2026-03-10_AcmeCorp_DATA_TrainingSet_v2_FINAL.csv
└── external/               ← Third-party or vendor datasets
    └── industry-benchmark-2025.xlsx
```

### Model Experiments (`08-Models/`)

```
08-Models/
├── experiments/
│   ├── exp-001_baseline_gpt4_2026-03-01/
│   ├── exp-002_finetuned_v1_2026-03-15/
│   └── exp-003_finetuned_v2_FINAL_2026-04-01/
├── evaluation/
│   ├── 2026-04-05_AcmeCorp_EVAL_ModelComparison_v1_FINAL.xlsx
│   └── 2026-04-10_AcmeCorp_EVAL_AccuracyReport_FINAL.md
└── registry-links.md       ← Links to MLflow, W&B, or model registry
```

---

## 10. Templates Folder

The `_Templates/` folder is the team's starter kit. Every new engagement begins by copying the folder template and README.

```
_Templates/
├── folder-structure-template/      ← Empty copy of the 00–09 structure
│   ├── 00-Index/
│   │   └── README-template.md
│   ├── 01-Discovery/
│   ├── 02-Research/
│   ├── 03-Design/
│   ├── 04-Requirements/
│   ├── 05-Delivery/
│   ├── 06-Stakeholder/
│   ├── 07-Data/
│   │   ├── raw/
│   │   ├── processed/
│   │   └── external/
│   ├── 08-Models/
│   ├── 09-Legal-Compliance/
│   └── _Archive/
├── PRD-template.docx
├── Research-brief-template.docx
├── Stakeholder-deck-template.pptx
├── Decision-log-template.xlsx
├── AI-risk-assessment-template.docx
└── README-template.md
```

**How to start a new engagement:**
1. Duplicate `_Templates/folder-structure-template/`
2. Rename to `ClientName_ProjectName`
3. Move into `Engagements/`
4. Fill in `00-Index/README.md` before creating any other files

---

## 11. Golden Rules for PMs

| # | Rule | Why |
|---|------|-----|
| 1 | Create `00-Index/README.md` on Day 1 | Eliminates onboarding friction and context-switching overhead |
| 2 | Never edit files in `07-Data/raw/` | Preserves data integrity and reproducibility |
| 3 | One folder per engagement — never mix clients | Prevents accidental data leakage between customers |
| 4 | Archive at project close, never delete | AI projects frequently revisit past experiments and decisions |
| 5 | Store links to live tools (Figma, Notion, Jira) in README | Avoids stale local copies of design work |
| 6 | Move docs to `_Archive/` when superseded | Keeps active folders clean without data loss |
| 7 | Agree on conventions before the first file is created | Consistency beats perfection — a simple shared system beats a perfect solo one |
| 8 | Use `_WIP` / `_REVIEW` / `_FINAL` suffixes on all docs | Signals document state without opening the file |
| 9 | Limit folder depth to 4 levels max | Prevents navigation fatigue and broken file paths |
| 10 | Document your system in `_Templates/README.md` | Keeps the system alive as the team grows and rotates |

---

## 12. References

| Source | URL | Relevance |
|--------|-----|-----------|
| **Tiago Forte — PARA Method** | [fortelabs.com](https://fortelabs.com/blog/para/) | Top-level org framework |
| **Smashing Magazine** — Product asset organization | [smashingmagazine.com](https://www.smashingmagazine.com/2021/05/product-records-organization-collaboration-best-practices/) | PM cross-functional doc management |
| **DEV Community** — ML project folder structure | [dev.to](https://dev.to/luxdevhq/generic-folder-structure-for-your-machine-learning-projects-4coe) | AI/ML-specific folder templates |
| **Zapier** — File organization for teams | [zapier.com](https://zapier.com/blog/organize-files-folders/) | Working / Final / Archive lifecycle |
| **Figma** — AI tools for PMs | [figma.com](https://www.figma.com/resource-library/ai-for-product-managers/) | Design + research doc management |
| **Penn Libraries** — Data management | [guides.library.upenn.edu](https://guides.library.upenn.edu/datamgmt/fileorg) | Raw/processed data discipline |
| **UVA Library** — File management best practices | [guides.lib.virginia.edu](https://guides.lib.virginia.edu/RDM/file-management) | Naming conventions, version control |
| **Microsoft 365** — 11 ideas for organizing files | [microsoft.com](https://www.microsoft.com/en-us/microsoft-365/business-insights-ideas/resources/11-ideas-for-how-to-organize-digital-files) | Team-wide consistency principles |
| **Medium / Satheesh Kumar** — Agentic AI file org | [medium.com](https://medium.com/@sathee12/organizing-files-for-agentic-ai-systems-my-rough-draft-e413dbe241d7) | Technical AI project structure |
| **Johnny Decimal System** | [johnnydecimal.com](https://johnnydecimal.com) | Numeric folder addressing |

---

*This document is a living guide. Update it as your team's workflows evolve.*
*Owner: [PM Team Lead] | Review cadence: Quarterly*
