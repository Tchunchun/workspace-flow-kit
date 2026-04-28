# CLAUDE.md — Project Instructions for [PROJECT NAME]

## Canonical Files At Root

- `README.md` — human-facing project overview
- `CLAUDE.md` — agent-facing instructions
- `.project-system/folder-triage-config.md` — source of truth for structure, routing, and naming rules
- `.project-system/project-context.md` — project brief and current priorities
- `.project-system/inventory.md` — lightweight map of key artefacts
- `.project-system/routing-log.md` — optional triage and rename audit trail

Read these files before making organisational changes.

## Core Workflow

- After bootstrap, every brand-new file starts in `_inbox/`.
- Triage is the explicit step that moves files from `_inbox/` into final folders.
- Edits to existing files stay in place.

Bootstrap exception:

- `workspace-flow-bootstrap` may create the initial scaffold directly in final locations.
- This exception does not apply to normal post-bootstrap file creation.

## Triage Workflow

1. read `.project-system/folder-triage-config.md`
2. read `.project-system/project-context.md`
3. inspect `.project-system/inventory.md` if discovery context is needed
4. classify files using filename, extension, then content peek
5. propose ambiguous moves before acting
6. suggest naming fixes when conventions are violated

## Creation Rules

When asked to create a new document:

- create it in `_inbox/` after bootstrap, even when the destination seems obvious
- use triage as the separate explicit step that moves it into the correct destination folder
- update `.project-system/inventory.md` if the new file is strategically important

## Hard Rules

- do not invent new top-level folders casually
- do not duplicate routing rules across multiple files
- do not move files without explanation when confidence is low
- do not create version-suffixed duplicates such as `_v2`, `_FINAL`, or `_NEW`
- do not assume a file is final just because it is a `.pdf` or `.docx` without checking context
- put project repos and implementation folders under `06-code/`