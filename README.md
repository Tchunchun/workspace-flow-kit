# file-system-template

A reusable workspace template for PMs, designers, researchers, and engineers who want a consistent project folder structure with explicit intake and filing rules.

## What This Template Provides

- a standard work-folder layout for strategy, discovery, design, delivery, comms, code, operations, and docs
- a hidden `.project-system/` control plane for routing rules and project metadata
- a bootstrap skill for initializing or retrofitting a project folder
- a triage skill for filing new documents from `_inbox/`

## Workspace Structure

At the root:

- `README.md` — human-facing overview and usage guide
- `CLAUDE.md` — agent-facing operating instructions
- `project-folder-bootstrap.skill` — packaged skill for initializing the folder system
- `inbox-triage.skill` — packaged skill for filing `_inbox/` contents
- `_inbox/` — temporary intake folder for brand-new files after bootstrap
- `.project-system/` — hidden routing and context metadata

Inside `.project-system/`:

- `folder-triage-config.md` — canonical source of truth for folder structure, routing, and naming rules
- `project-context.md` — short project brief
- `inventory.md` — lightweight map of important artifacts
- `routing-log.md` — optional triage audit trail
- `skill-sources/` — editable source for packaged skills
- `rebuild-skills.sh` — rebuild helper for packaged `.skill` files

## How To Use It

1. Copy this template into a new project folder.
2. Rename the root folder to match the project name.
3. Run `project-folder-bootstrap.skill` if you want Claude to create or retrofit the standard structure.
4. Customize `.project-system/folder-triage-config.md` for the project.
5. Put all brand-new post-bootstrap files into `_inbox/`.
6. Run `inbox-triage` to move those files into their final folders.

## Visible Work Folders

The standard structure is defined in `.project-system/folder-triage-config.md` and includes:

- `meetings/`
- `01-strategy/`
- `02-discovery/research/`
- `02-discovery/findings/`
- `03-design/`
- `04-delivery/specs/`
- `04-delivery/qa-and-testing/`
- `04-delivery/metrics/`
- `05-comms/slides/`
- `05-comms/announcements/`
- `05-comms/external/`
- `06-code/`
- `07-operations/config/`
- `07-operations/templates/`
- `07-operations/onboarding/`
- `docs/`
- `docs/archive/`

## Workflow

The intended lifecycle is simple:

- bootstrap creates the initial scaffold directly in final locations
- after bootstrap, every brand-new file goes to `_inbox/`
- triage is a separate explicit step
- edits to existing files stay in place

This keeps file creation and file placement decoupled.

## Customization

Edit `.project-system/folder-triage-config.md` when you want to:

- add or rename folders
- change routing behavior
- define naming conventions
- adjust ambiguity rules or filing exceptions

If you rename a folder, move existing files to the new location before relying on triage.

## Skill Maintenance

Packaged skills stay at the root for use. Their editable source lives under:

- `.project-system/skill-sources/project-folder-bootstrap/`
- `.project-system/skill-sources/inbox-triage/`

Rebuild the packaged archives with:

```bash
.project-system/rebuild-skills.sh
```

## Notes

- Keep build artifacts out of this structure.
- Avoid version suffixes like `_v2` or `_FINAL`.
- Use `docs/archive/` for superseded documents.