# folder-triage-config.md

Canonical source of truth for this project's folder structure, file-routing logic, and naming rules. Read by the `workspace-flow-triage` skill.

## 1. Folder Structure

```text
example-project/
├── _inbox/
├── 01-problem/
├── 02-design/
├── 03-comms/
├── 04-evals/
├── 05-ops/
├── 06-code/
├── docs/
│   └── archive/
├── README.md
├── CLAUDE.md
└── .project-system/
    ├── folder-triage-config.md
    ├── project-context.md
    ├── inventory.md
    └── routing-log.md
```

| Folder | Use for |
|---|---|
| `_inbox/` | Brand-new untriaged files |
| `01-problem/` | Problem framing, research, findings, hypotheses |
| `02-design/` | Flows, specs, requirements, architecture, UX/UI |
| `03-comms/` | Updates, launch notes, memos, slides, external drafts |
| `04-evals/` | Rubrics, test plans, QA captures, benchmark results, metrics |
| `05-ops/` | Setup, onboarding, templates, runbooks, configuration |
| `06-code/` | Repositories and implementation workspaces |
| `docs/` | Final/reference artefacts |
| `docs/archive/` | Superseded final artefacts |

## 2. Lifecycle Rules

- `workspace-flow-bootstrap` may create the initial scaffold directly in final locations.
- After bootstrap, every brand-new file goes to `_inbox/` first.
- `workspace-flow-triage` moves files from `_inbox/` only after presenting a routing proposal.
- Edits to existing files stay in place.
- Do not create version-suffixed duplicates such as `_v2`, `_FINAL`, or `_NEW`.

## 3. Routing Rules

### Filename patterns

| If filename contains | Route to |
|---|---|
| `problem`, `pain`, `hypothesis`, `opportunity`, `finding`, `insight`, `theme`, `research`, `interview`, `survey`, `analysis` | `01-problem/` |
| `design`, `flow`, `wireframe`, `mockup`, `ux`, `ui`, `architecture`, `solution`, `spec`, `prd`, `requirements` | `02-design/` |
| `announcement`, `update`, `launch`, `memo`, `stakeholder`, `one-pager`, `blog`, `press`, `sales`, `deck`, `slides`, `presentation`, `meeting` | `03-comms/` |
| `eval`, `evaluation`, `rubric`, `benchmark`, `metric`, `results`, `dashboard`, `bug`, `qa`, `test`, `uat`, `screenshot`, `capture` | `04-evals/` |
| `onboarding`, `getting-started`, `setup`, `config`, `template`, `process`, `runbook`, `workflow` | `05-ops/` |
| `repo`, `app`, `skill`, `source`, `implementation`, `code` | `06-code/` |
| `final`, `published`, `reference`, `handoff`, `guide` | `docs/` |

### Extension defaults

| Extension | Route to |
|---|---|
| `.pptx` | `03-comms/` |
| `.html`, `.svg`, `.fig` | `02-design/` |
| `.csv`, `.xlsx`, `.png`, `.jpg`, `.jpeg`, `.gif` | `04-evals/` |
| `.sh`, `.ps1`, `.bat`, `.mobileconfig` | `05-ops/` |
| `.pdf`, `.docx` | `docs/` |
| `.md` | Content peek required |

### Content peek for Markdown

| If content contains | Route to |
|---|---|
| `## Problem`, `## Pain`, `## Findings`, `## Insights`, `# Research` | `01-problem/` |
| `## Flow`, `## Design`, `## Architecture`, `## Requirements`, `## Acceptance criteria`, `# PRD`, `# Spec` | `02-design/` |
| `# Announcement`, `## TL;DR`, `## Stakeholders`, `## Launch` | `03-comms/` |
| `## Test plan`, `## UAT`, `## Evaluation`, `## Rubric`, `## Results`, `## Metrics` | `04-evals/` |
| `## Setup`, `## Onboarding`, `## Runbook`, `## Process`, `## Configuration` | `05-ops/` |

## 4. Ambiguous Cases

Ask before moving:

- markdown files with weak signals
- conflicting filename, extension, and content signals
- folders containing `.git/`
- images that may be design assets instead of QA/eval captures
- files whose final/reference status is unclear

## 5. Naming Rules

Use kebab-case filenames. Preserve file extensions. Strip `_v2`, `_FINAL`, and `_NEW` rather than keeping version-suffixed duplicates.
