# Default Folder Triage Config (Bundled Fallback)

This is the built-in fallback used by the `inbox-triage` skill when a project's `.project-system/folder-triage-config.md` is missing. Copy this file to `.project-system/folder-triage-config.md` and customise it.

## 1. Folder Structure

### Folder Tree

```text
Project-Name/
├── .project-system/
│   ├── folder-triage-config.md
│   ├── project-context.md
│   ├── inventory.md
│   └── routing-log.md
├── _inbox/
├── meetings/
├── 01-strategy/
├── 02-discovery/
│   ├── findings/
│   └── research/
├── 03-design/
├── 04-delivery/
│   ├── qa-and-testing/
│   ├── specs/
│   └── metrics/
├── 05-comms/
│   ├── announcements/
│   ├── external/
│   └── slides/
├── 06-code/
├── 07-operations/
│   ├── config/
│   ├── templates/
│   └── onboarding/
└── docs/
    └── archive/
```

### Folder Summary

| Folder | Zone | Key rule |
|--------|------|----------|
| `_inbox/` | Scratchpad | Always empty after triage |
| `meetings/` | Decisions | One file per meeting, `YYYY-MM-DD-topic.md` |
| `01-strategy/` | Why | Living docs; date suffix, not version suffix |
| `02-discovery/research/` | Problem (raw) | Interviews, surveys, SVGs, comparisons |
| `02-discovery/findings/` | Problem (synthesised) | Insights, themes, annotated screenshots |
| `03-design/` | Vision | Wireframes, mockups, design system notes |
| `04-delivery/specs/` | Execution | In-progress PRDs; move to `docs/` when final |
| `04-delivery/qa-and-testing/` | Execution | Bug screenshots, test plans, UAT |
| `04-delivery/metrics/` | Execution | Eval output, usage data, CSVs |
| `05-comms/slides/` | Story | `.pptx` decks and `.html` prototypes |
| `05-comms/announcements/` | Story | Internal updates |
| `05-comms/external/` | Story | Partner content, blog drafts |
| `06-code/` | Engine | Every child must be a git repo |
| `07-operations/config/` | System | One copy per file, no duplicates |
| `07-operations/templates/` | System | Blanks only; outputs move elsewhere |
| `07-operations/onboarding/` | System | New joiner guides and checklists |
| `docs/` | Showcase | Done only — nothing in progress |
| `docs/archive/` | Showcase | Superseded versions only |

### Bootstrap And File Lifecycle

- **Bootstrap exception:** `project-folder-bootstrap` may create the initial scaffold directly in final locations.
- **Post-bootstrap intake:** After bootstrap, every brand-new file must go to `_inbox/` first.
- **Triage is separate:** Routing rules are used when filing files out of `_inbox/`, not when creating them.
- **Edits stay in place:** Changes to existing files happen in their current location.
- **Archive superseded finals:** Move superseded final artifacts to `docs/archive/` instead of creating version-suffixed duplicates.

## 2. Routing Rules

These routing rules are for filing files from `_inbox/` into their final destination folders. They do not change the rule that all brand-new post-bootstrap files must be created in `_inbox/` first.

### Filename Pattern Rules

| If the filename contains… | Route to |
|--------------------------|----------|
| `meeting`, `standup`, `sync`, `retro`, `review`, `steerco`, `agenda` | `meetings/` |
| `okr`, `roadmap`, `north-star`, `strategy`, `vision`, `prioriti`, `business-case` | `01-strategy/` |
| `interview`, `survey`, `research`, `comparison`, `analysis`, `competitive` | `02-discovery/research/` |
| `finding`, `insight`, `theme`, `synthesis` | `02-discovery/findings/` |
| `wireframe`, `mockup`, `design`, `ui`, `ux`, `flow`, `prototype` | `03-design/` |
| `spec`, `prd`, `requirements`, `design-doc`, `technical-doc` | `04-delivery/specs/` |
| `bug`, `qa`, `test`, `uat`, `screenshot`, `capture` | `04-delivery/qa-and-testing/` |
| `eval`, `metric`, `benchmark`, `usage`, `analytics`, `results`, `dashboard` | `04-delivery/metrics/` |
| `announcement`, `update`, `launch`, `release-note` | `05-comms/announcements/` |
| `one-pager`, `partner`, `blog`, `press`, `external`, `sales` | `05-comms/external/` |
| `deck`, `slides`, `presentation`, `steerco` | `05-comms/slides/` |
| `onboarding`, `new-joiner`, `getting-started` | `07-operations/onboarding/` |
| `template` | `07-operations/templates/` |
| `config`, `setup`, `mobileconfig`, `mdm`, `environment` | `07-operations/config/` |

### Extension Rules

| Extension | Route to | Notes |
|-----------|----------|-------|
| `.pptx` | `05-comms/slides/` | |
| `.html` | `05-comms/slides/` | Assumed to be a web prototype |
| `.mobileconfig` | `07-operations/config/` | |
| `.sh`, `.ps1`, `.bat` | `07-operations/config/` | Setup scripts |
| `.csv`, `.xlsx` | `04-delivery/metrics/` | Unless filename pattern overrides |
| `.svg` | `02-discovery/research/` | Diagrams |
| `.fig` | `03-design/` | Figma exports |
| `.png`, `.jpg`, `.jpeg`, `.gif` | `04-delivery/qa-and-testing/` | Default: assume QA capture |
| `.pdf` | `docs/` | Assumed to be a final deliverable |
| `.docx` | `docs/` | Unless filename pattern routes elsewhere |
| `.md` | Content peek required |

### Content Peek Rules

| If the content contains… | Route to |
|--------------------------|----------|
| `## Attendees`, `## Action items`, date in H1 title | `meetings/` |
| `# OKR`, `## Objective`, `Q1`/`Q2`/`Q3`/`Q4` + goal language | `01-strategy/` |
| `# Roadmap`, `## Now`, `## Next`, `## Later` | `01-strategy/` |
| `# Research`, `## Methodology`, `## Participants` | `02-discovery/research/` |
| `## Findings`, `## Insights`, `## Themes`, `## Key takeaways` | `02-discovery/findings/` |
| `# PRD`, `# Spec`, `## Problem statement`, `## Success metrics`, `## Acceptance criteria` | `04-delivery/specs/` |
| `## Test plan`, `## UAT`, `## Bug report` | `04-delivery/qa-and-testing/` |
| `# Announcement`, `## TL;DR`, `All,` + internal memo language | `05-comms/announcements/` |

## 3. Naming Rules

| Violation | Example | Suggested fix |
|-----------|---------|---------------|
| Spaces in filename | `My Report.md` | `my-report.md` |
| Underscores | `plaid_spec.md` | `plaid-spec.md` |
| Version suffix | `report_v2.md` | `report.md` |
| All caps | `PLAID_SPEC.md` | `plaid-spec.md` |
| Meeting note missing date | `steerco-notes.md` | `2026-04-24-steerco.md` |

## 4. How Claude Should Use This File

- Read this file before deciding where a document belongs.
- Treat `_inbox/` as the required intake point for all brand-new post-bootstrap files.
- Validate destinations against the folder structure section.
- Use routing rules in this order when triaging from `_inbox/`: filename, extension, content peek, then ask.
- Suggest naming corrections when the naming rules are violated.
- Do not create version-suffixed duplicates.
