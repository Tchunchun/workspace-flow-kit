# CLAUDE.md — Agent Instructions

## What This Repo Is

- Reusable project workspace template
- Hidden control plane lives in `.project-system/`
- Main skills: `project-folder-bootstrap.skill`, `inbox-triage.skill`

## Source Of Truth

- Read `.project-system/folder-triage-config.md` before deciding where files belong
- Use `.project-system/project-context.md` for compact project context when present
- Use `.project-system/inventory.md` as a lightweight artifact map when present

## File Lifecycle Rules

- `project-folder-bootstrap` is the only workflow allowed to create the initial scaffold directly in final locations
- After bootstrap, every brand-new file must be created in `_inbox/`
- Triage is a separate explicit step that moves files from `_inbox/` to final folders
- Edits to existing files stay in place
- No post-bootstrap exception exists for direct-to-folder new-file creation

## Skill Triggers

### project-folder-bootstrap

- Use when asked to initialize or retrofit a folder with this template
- Infer the project name from the current folder unless the user overrides it
- Create folders and minimal root/control-plane files directly in final locations
- Preserve existing files by default and ask before replacing anything

### inbox-triage

- Use when files have been added to `_inbox/` and need filing
- Read `.project-system/folder-triage-config.md` first
- Propose destinations and naming fixes before moving anything
- Keep `_inbox/` empty after triage when possible

## Hard Rules

- One home per file; do not duplicate artifacts across folders
- Keep metadata in `.project-system/`
- Never create version-suffixed duplicates such as `_v2`, `_FINAL`, `_NEW`
- Archive superseded documents in `docs/archive/`
- Keep build artifacts out of the workspace structure

## Behavior Rules For Claude

- When asked to file a document, check `.project-system/folder-triage-config.md` first
- When asked to create a brand-new document after bootstrap, create it in `_inbox/`
- When asked to edit an existing document, edit it in place
- Briefly explain which routing rule matched when suggesting a destination
- Summarize what changed and why when `.project-system/folder-triage-config.md` is edited
