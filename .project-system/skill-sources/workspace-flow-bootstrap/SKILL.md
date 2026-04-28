---
name: workspace-flow-bootstrap
description: Use when initializing or retrofitting a project folder with Workspace Flow Kit: `_inbox`, `01-problem`, `02-design`, `03-comms`, `04-evals`, `05-ops`, `06-code`, `docs`, root agent instructions, and `.project-system` routing files. Trigger on requests like "set up this workspace", "bootstrap Workspace Flow Kit", "initialize the project structure", "add inbox triage", or "prepare this folder for workspace-flow-triage".
metadata:
  category: workflow
  triggers: set up this workspace, bootstrap Workspace Flow Kit, initialize the project structure, add inbox triage, prepare this folder for workspace-flow-triage
compatibility:
  requires: [Read, Write, mcp__workspace__bash]
---

# workspace-flow-bootstrap

Set up a project folder with the Workspace Flow Kit structure: an intake inbox, flow-based work folders, and a hidden routing control plane.

## Source material behind this skill

This skill is grounded in the Workspace Flow Kit repository conventions, the bundled reference templates, and the Agent Skills best-practice guidance to keep skills concise, procedural, and validated.

## Workflow

1. **Resolve the target folder.** Use the current workspace unless the user names a different folder. If multiple project roots are plausible, ask which one to bootstrap.
2. **Classify the mode.** Use `new project` for mostly empty folders and `retrofit` for folders with existing work.
3. **Audit before writing.** Check whether these exist: `README.md`, `AGENTS.md`, `CLAUDE.md`, `.project-system/`, `.project-system/folder-triage-config.md`, `.project-system/project-context.md`, `.project-system/inventory.md`, `.project-system/routing-log.md`, `_inbox/`, `01-problem/`, `02-design/`, `03-comms/`, `04-evals/`, `05-ops/`, `06-code/`, and `docs/`.
4. **State the bootstrap plan.** Summarize what is already present, what will be created, and what will not be overwritten.
5. **Create only missing folders.** Use this baseline:

```text
template-project/
├── _inbox/
├── 01-problem/
├── 02-design/
├── 03-comms/
├── 04-evals/
├── 05-ops/
├── 06-code/
└── docs/
    └── archive/
```

6. **Install starter files only when missing.** Use bundled references:
   - `references/template-root-CLAUDE.md` → `CLAUDE.md`
   - `references/default-folder-triage-config.md` → `.project-system/folder-triage-config.md`
   - `references/template-project-context.md` → `.project-system/project-context.md`
   - `references/template-inventory.md` → `.project-system/inventory.md`
   - `references/template-routing-log.md` → `.project-system/routing-log.md`
   - `references/template-README.md` → `README.md` only if missing and useful
7. **Replace safe placeholders.** Replace `[PROJECT NAME]` with the folder name or user-provided project name and `[YYYY-MM-DD]` with today. Do not invent owners, teams, priorities, or strategy.
8. **Validate before claiming success.** Re-check that `_inbox/`, `.project-system/folder-triage-config.md`, `CLAUDE.md`, and all flow folders exist.

## Retrofit rules

- Preserve existing files and folders by default.
- Do not move existing project content during bootstrap unless the user explicitly asks for cleanup.
- Do not overwrite existing `CLAUDE.md`, `AGENTS.md`, `README.md`, or `.project-system` files without clear approval.
- Do not move git repositories. Flag them and recommend placing project repos under `06-code/`.

## Gotchas

- `.project-system/` is intentionally hidden but still required; do not omit it from generated projects.
- Brand-new post-bootstrap files must start in `_inbox/`, even if their final destination seems obvious.
- `workspace-flow-bootstrap` is the only workflow allowed to create the initial scaffold directly in final folders.
- `06-code/` is generic. Do not hardcode project-specific repos such as `paper-drop-app/` unless the user asks for a Paper Drop example.
- Keep the root minimal: `AGENTS.md`, `CLAUDE.md`, optional `README.md`, `_inbox/`, flow folders, `docs/`, and `.project-system/`.

## Validation output

When complete, summarize in this format:

```text
Bootstrap complete for [project-name]

Created:
- [paths]

Left unchanged:
- [paths]

Next recommended edits:
- fill in `.project-system/project-context.md`
- customize `.project-system/folder-triage-config.md` if needed
- use `workspace-flow-triage` after dropping files into `_inbox/`
```

If validation fails, repair the missing piece before finishing.
