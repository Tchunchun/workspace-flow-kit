# folder-triage-config.md

Canonical source of truth for this project's folder structure, file-routing logic, and naming rules. Read by the `workspace-flow-triage` skill.

## 1. Folder Structure

### Folder Tree

```text
template-project/
├── _inbox/                # Intake: brand-new files, unreviewed notes, temporary drops
├── 01-problem/            # Problem: pain points, research, findings, hypotheses
├── 02-design/             # Design: flows, UX, solution sketches, specs, architecture
├── 03-comms/              # Comms: stakeholder updates, launch notes, slides, external drafts
├── 04-evals/              # Evals: rubrics, QA evidence, benchmarks, results, metrics
├── 05-ops/                # Ops: setup, onboarding, templates, process, configuration
├── 06-code/               # Code: product repos, skill repos, implementation workspaces
│   └── [repos]/
├── docs/                  # Docs: final/reference artefacts and archive
│   └── archive/           # Superseded final artefacts only
├── AGENTS.md              # Agent-facing instructions for Codex-compatible agents
├── CLAUDE.md              # Agent-facing instructions for Claude-compatible agents
├── README.md              # Human-facing overview when present
└── .project-system/       # Hidden control plane for routing and context
    ├── folder-triage-config.md
    ├── project-context.md
    ├── inventory.md
    └── routing-log.md
```

### Folder Summary

| Folder | Zone | Key rule |
|--------|------|----------|
| `_inbox/` | Intake | Always empty after triage when possible |
| `01-problem/` | Problem | User pain, research, findings, hypotheses, opportunity framing |
| `02-design/` | Design | Flows, specs, architecture, solution shaping, UX/UI artefacts |
| `03-comms/` | Comms | Updates, memos, slides, launch notes, external-facing drafts |
| `04-evals/` | Evals | Rubrics, test plans, QA captures, metrics, benchmark results |
| `05-ops/` | Ops | Setup, onboarding, process docs, reusable templates, config |
| `06-code/` | Code | Product repos, skill repos, implementation workspaces |
| `docs/` | Reference | Final/reference artefacts only |
| `docs/archive/` | Archive | Superseded final artefacts only |

### Bootstrap And File Lifecycle

- **Bootstrap exception:** `workspace-flow-bootstrap` may create the initial scaffold directly in final locations.
- **Post-bootstrap intake:** After bootstrap, every brand-new file must go to `_inbox/` first.
- **Triage is separate:** Routing rules are used when filing files out of `_inbox/`, not when creating them.
- **Edits stay in place:** Changes to existing files happen in their current location.
- **Archive superseded finals:** Move superseded final artefacts to `docs/archive/` instead of creating version-suffixed duplicates.

### Structure Rules

- **One home per file.** Do not duplicate the same artifact across folders.
- **Default to shallow folders.** Prefer one level under the root. Use `docs/archive/` and repo-internal trees only when needed.
- **No loose working files at root.** Keep project files inside named folders.
- **Keep operating metadata in `.project-system/`.** Do not scatter config files across root.
- **No version suffixes.** Never use `_v2`, `_FINAL`, `_NEW`.
- **No build artefacts.** `.venv/`, `node_modules/`, `dist/` belong in `.gitignore`.
- **Project-specific code repos belong in `06-code/`.** For Paper Drop, use `06-code/paper-drop-app/` and `06-code/paper-drop-skills/`.

## 2. Routing Rules

Rules are evaluated in order. First strong match wins.

These routing rules are for filing files from `_inbox/` into their final destination folders. They do not change the rule that all brand-new post-bootstrap files must be created in `_inbox/` first.

### 2.1 Filename Pattern Rules

| If the filename contains… | Route to |
|--------------------------|----------|
| `problem`, `pain`, `hypothesis`, `opportunity`, `finding`, `insight`, `theme`, `synthesis` | `01-problem/` |
| `interview`, `survey`, `research`, `comparison`, `analysis`, `competitive` | `01-problem/` |
| `design`, `flow`, `wireframe`, `mockup`, `ux`, `ui`, `architecture`, `solution` | `02-design/` |
| `spec`, `prd`, `requirements`, `design-doc`, `technical-doc` | `02-design/` |
| `announcement`, `update`, `launch`, `release-note`, `memo`, `stakeholder` | `03-comms/` |
| `one-pager`, `partner`, `blog`, `press`, `external`, `sales`, `deck`, `slides`, `presentation` | `03-comms/` |
| `eval`, `evaluation`, `rubric`, `benchmark`, `metric`, `usage`, `analytics`, `results`, `dashboard` | `04-evals/` |
| `bug`, `qa`, `test`, `uat`, `screenshot`, `capture`, `scorecard` | `04-evals/` |
| `onboarding`, `new-joiner`, `getting-started`, `setup`, `config`, `mobileconfig`, `mdm`, `environment` | `05-ops/` |
| `template`, `process`, `runbook`, `operating-model`, `workflow` | `05-ops/` |
| `repo`, `app`, `skill`, `source`, `implementation`, `code` | `06-code/` |
| `final`, `published`, `reference`, `handoff`, `guide` | `docs/` |

### 2.2 Extension Rules

| Extension | Route to | Notes |
|-----------|----------|-------|
| `.pptx` | `03-comms/` | Decks and stakeholder presentations |
| `.html` | `02-design/` | Assumed to be an interactive prototype unless filename says comms |
| `.mobileconfig` | `05-ops/` | |
| `.sh`, `.ps1`, `.bat` | `05-ops/` | Setup scripts |
| `.csv`, `.xlsx` | `04-evals/` | Unless filename pattern overrides |
| `.svg` | `02-design/` | Diagrams and design assets |
| `.fig` | `02-design/` | Figma exports |
| `.png`, `.jpg`, `.jpeg`, `.gif` | `04-evals/` | Default: assume QA/eval capture; ask if it may be design |
| `.pdf` | `docs/` | Assumed final/reference unless filename/content indicates active work |
| `.docx` | `docs/` | Unless filename pattern routes elsewhere |
| `.md` | Content peek required |

### 2.3 Content Peek Rules

For `.md` files, inspect the first 20 lines.
For `.docx` files, inspect the first paragraphs when possible.

| If the content contains… | Route to |
|--------------------------|----------|
| `## Problem`, `## Pain`, `## Findings`, `## Insights`, `## Themes`, `## Key takeaways`, `# Research` | `01-problem/` |
| `## Flow`, `## Design`, `## Architecture`, `## Requirements`, `## Acceptance criteria`, `# PRD`, `# Spec` | `02-design/` |
| `# Announcement`, `## TL;DR`, `All,`, `## Stakeholders`, `## Launch` | `03-comms/` |
| `## Test plan`, `## UAT`, `## Bug report`, `## Evaluation`, `## Rubric`, `## Results`, `## Metrics` | `04-evals/` |
| `## Setup`, `## Onboarding`, `## Runbook`, `## Process`, `## Configuration` | `05-ops/` |

### 2.4 Ambiguous Cases

Always flag these for confirmation:

- brand-new files still waiting in `_inbox/`
- markdown files with no clear signal
- conflicting filename and content signals
- folders containing `.git/`
- images that may be either design assets or QA captures
- files that already appear to be in the correct location
- files whose final/reference status is unclear

## 3. Naming Rules

| Type | Convention | Example |
|------|-----------|---------|
| Working docs | `kebab-case.md` | `user-interview-findings.md` |
| Presentations | `kebab-case.pptx` | `q2-roadmap-review.pptx` |
| Templates | `template-description.ext` | `template-prd.md` |
| Archived files | Original name, moved to `docs/archive/` | |

### Naming Corrections

| Violation | Example | Suggested fix |
|-----------|---------|---------------|
| Spaces in filename | `My Report.md` | `my-report.md` |
| Underscores | `plaid_spec.md` | `plaid-spec.md` |
| Version suffix | `report_v2.md` | `report.md` |
| All caps | `PLAID_SPEC.md` | `plaid-spec.md` |
| Date-specific note missing date | `launch-notes.md` | `2026-04-24-launch-notes.md` |

## 4. How Claude Should Use This File

- Read this file before deciding where a document belongs.
- Treat `_inbox/` as the required intake point for all brand-new post-bootstrap files.
- Validate destinations against the folder structure section.
- Use routing rules in this order when triaging from `_inbox/`: filename, extension, content peek, then ask.
- Suggest naming corrections when the naming rules are violated.
- Do not create version-suffixed duplicates.
