# Workspace Flow Kit

A reusable workspace template for PMs, designers, researchers, and engineers who want a flow-first project structure with explicit intake and filing rules.

## What This Template Provides

- a standard work-folder layout for problem framing, design, comms, evals, ops, code, and docs
- a hidden `.project-system/` control plane for routing rules and project metadata
- `workspace-flow-bootstrap` for initializing or retrofitting a project folder
- `workspace-flow-triage` for filing new documents from `_inbox/`

## Workspace Structure

At the root:

- `README.md` — human-facing overview and usage guide
- `CLAUDE.md` — agent-facing operating instructions
- `workspace-flow-bootstrap.skill` — packaged skill for initializing the folder system
- `workspace-flow-triage.skill` — packaged skill for filing `_inbox/` contents
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

### Install the Skills

**VS Code (GitHub Copilot):**

Copy the skill source directories into your Copilot skills folder:

```bash
cp -r .project-system/skill-sources/workspace-flow-bootstrap ~/.copilot/skills/
cp -r .project-system/skill-sources/workspace-flow-triage ~/.copilot/skills/
```

**Claude Code:**

Copy the skill source directories into your Claude skills folder:

```bash
cp -r .project-system/skill-sources/workspace-flow-bootstrap ~/.claude/skills/
cp -r .project-system/skill-sources/workspace-flow-triage ~/.claude/skills/
```

### Use the Skills

1. Open the project folder you want to organize and ask the agent to bootstrap it.
2. Customize the folder structure and routing rules in `.project-system/folder-triage-config.md` — this is the single source of truth that controls which folders exist, how files get routed, and what naming conventions apply.
3. Put all brand-new post-bootstrap files into `_inbox/`.
4. Ask the agent to triage `_inbox/` to move files into their final folders.

## Visible Work Folders

The standard user-facing structure is defined in `.project-system/folder-triage-config.md` and includes:

- `_inbox/`
- `01-problem/`
- `02-design/`
- `03-comms/`
- `04-evals/`
- `05-ops/`
- `06-code/`
- `docs/`
- `docs/archive/`

`.project-system/` remains as the hidden control plane even when the simplified tree is shown without it.

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

- `.project-system/skill-sources/workspace-flow-bootstrap/`
- `.project-system/skill-sources/workspace-flow-triage/`

Rebuild the packaged archives with:

```bash
.project-system/rebuild-skills.sh
```

## Notes

- Keep build artifacts out of this structure.
- Avoid version suffixes like `_v2` or `_FINAL`.
- Use `docs/archive/` for superseded documents.