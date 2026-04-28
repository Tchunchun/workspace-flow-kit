# AGENTS.md — Project Instructions for example-project

## Source Of Truth

- Read `.project-system/folder-triage-config.md` before deciding where files belong.
- Use `.project-system/project-context.md` for compact project context.
- Use `.project-system/inventory.md` as a lightweight artifact map.

## File Lifecycle Rules

- `workspace-flow-bootstrap` is the only workflow allowed to create the initial scaffold directly in final locations.
- After bootstrap, every brand-new file must be created in `_inbox/`.
- `workspace-flow-triage` is the separate explicit step that moves files from `_inbox/` to final folders.
- Edits to existing files stay in place.

## Hard Rules

- One home per file; do not duplicate artifacts across folders.
- Keep metadata in `.project-system/`.
- Put project repos and implementation folders under `06-code/`.
- Never create version-suffixed duplicates such as `_v2`, `_FINAL`, `_NEW`.
- Archive superseded final documents in `docs/archive/`.
