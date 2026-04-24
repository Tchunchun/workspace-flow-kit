---
name: project-folder-bootstrap
description: Use when the user wants to initialize or retrofit a project folder with the standard `_inbox/`, `.project-system/`, root `CLAUDE.md`, and canonical work folders. Trigger on requests like "set up this project folder", "bootstrap this workspace", "initialize the project structure", "add the project system", or "prepare this folder for inbox triage".
metadata:
  category: workflow
  triggers: set up this project folder, bootstrap this workspace, initialize the project structure, add the project system, prepare this folder for inbox triage
compatibility:
  requires: [Read, Write, mcp__workspace__bash]
---

# project-folder-bootstrap

Set up a project folder so humans and agents can work from the same filesystem model without scattered metadata.

## What this skill does

1. Confirms the target project folder and whether this is a new setup or a retrofit
2. Audits what already exists before creating anything
3. Creates the standard folder tree when folders are missing
4. Installs starter control files into `.project-system/`
5. Installs a root `CLAUDE.md` and optional `README.md` stub when needed
6. Preserves existing files unless the user explicitly approves replacement
7. Validates that the folder system is usable by `inbox-triage`

This skill is for setup and light retrofits. It does not reorganize existing project content unless the user explicitly asks for that.

This skill is also the only exception to the normal intake rule: it may create the initial scaffold directly in final locations. After bootstrap, all brand-new files must go to `_inbox/` first.

---

## Step 1: Confirm the target folder

Start from the current workspace folder unless the user names a different target.

If multiple plausible project folders are present, ask which one to bootstrap.

Then classify the request as one of these modes:

- **new project**: the target is mostly empty or intentionally being created from scratch
- **retrofit**: the target already has real work files and needs the project-system structure added safely

State the mode before making changes.

---

## Step 2: Audit the current state

Before creating files, inspect whether these already exist:

- `README.md`
- `CLAUDE.md`
- `.project-system/`
- `.project-system/folder-triage-config.md`
- `.project-system/project-context.md`
- `.project-system/inventory.md`
- `.project-system/routing-log.md`
- `_inbox/`

Also inspect whether the standard work folders already exist:

- `meetings/`
- `01-strategy/`
- `02-discovery/`
- `03-design/`
- `04-delivery/`
- `05-comms/`
- `06-code/`
- `07-operations/`
- `docs/`

Summarize the gap briefly before making changes:

```text
Bootstrap plan for [project-name]

Already present:
- README.md
- 04-delivery/
- docs/

Will create:
- .project-system/
- _inbox/
- CLAUDE.md
- missing standard folders

Will not overwrite:
- README.md
```

If important control files already exist, ask whether to keep, replace, or compare before writing.

---

## Step 3: Create the standard folder tree

Create any missing directories from this baseline structure:

```text
Project-Name/
├── README.md
├── CLAUDE.md
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

Only create missing folders. Do not rename or delete existing folders unless the user explicitly asks.

---

## Step 4: Install the starter files

Use the bundled references in this skill as the source templates.

Write these files when they do not already exist:

- `references/template-root-CLAUDE.md` → `CLAUDE.md`
- `references/default-folder-triage-config.md` → `.project-system/folder-triage-config.md`
- `references/template-project-context.md` → `.project-system/project-context.md`
- `references/template-inventory.md` → `.project-system/inventory.md`
- `references/template-routing-log.md` → `.project-system/routing-log.md`

For `README.md`:

- if `README.md` already exists, leave it in place
- if `README.md` is missing, offer to create `references/template-README.md`
- if the user says yes, write it and replace placeholders you can infer safely

When creating files, replace obvious placeholders when the value is known:

- `[PROJECT NAME]` → folder name or user-provided project name
- `[YYYY-MM-DD]` → today’s date

For starter root docs, use the repository or target folder name directly as the project name. Do not humanize it or rename it away from the GitHub repo name unless the user explicitly asks.

Do not invent owner names, team members, priorities, or strategy details. Leave those placeholders in place if the user has not provided them.

The generated files must reinforce the lifecycle clearly:

- `README.md` stays human-facing
- `CLAUDE.md` stays agent-facing
- `.project-system/folder-triage-config.md` defines routing and naming rules
- all brand-new post-bootstrap files go to `_inbox/`
- starter root docs should stay minimal and should not restate the full routing config

---

## Step 5: Retrofit behavior

If this is a retrofit of an existing project:

- keep existing project artefacts where they are
- add the control-plane files and missing folders around them
- do not move loose files into `_inbox/` unless the user explicitly asks for cleanup
- do not overwrite existing `CLAUDE.md` or project-system files without approval

If a file exists and the bundled template would conflict, present options:

```text
`CLAUDE.md` already exists.

Choose one:
- keep existing
- replace with bundled starter
- compare and merge manually
```

---

## Gotchas

- Keep metadata in `.project-system/`; do not create extra root control files.
- This skill sets up structure. It does not perform inbox filing; use `inbox-triage` for that.
- Do not overwrite an existing `CLAUDE.md` or `.project-system/folder-triage-config.md` without clear approval.
- Do not move git repositories or existing code folders as part of bootstrapping.
- If the target folder already has a working structure, add only what is missing.
- Do not generate instructions that tell Claude to create brand-new post-bootstrap files directly in final folders.

---

## Step 6: Validate the bootstrap

After creating files and folders, verify:

1. `.project-system/folder-triage-config.md` exists
2. `_inbox/` exists
3. `CLAUDE.md` exists
4. the standard second-level folders exist where expected
5. no approved file was overwritten unintentionally

If validation passes, summarize the result like this:

```text
Bootstrap complete for [project-name]

Created:
- .project-system/folder-triage-config.md
- .project-system/project-context.md
- .project-system/inventory.md
- .project-system/routing-log.md
- CLAUDE.md
- _inbox/
- 7 standard work folders

Left unchanged:
- README.md
- 04-delivery/
- docs/

Next recommended edits:
- fill in project-context placeholders
- customize folder-triage-config for this project
- run inbox triage after dropping files into _inbox/
```

---

## Validation loop

Before claiming success:

1. Re-check that every created file is in the intended path.
2. Re-check that placeholder replacement did not alter Markdown structure.
3. Re-check that any preserved existing files were not modified.
4. Re-check that `.project-system/folder-triage-config.md` is present, because `inbox-triage` depends on it.

If any of those checks fail, repair the missing piece before finishing.

---

## Next-action hook

After a successful bootstrap, offer the next step clearly:

> "The project folder is initialized. If you want, I can now customize `project-context.md`, tune `folder-triage-config.md`, or help triage files into `_inbox/`."

Do not automatically populate project strategy or move existing files unless the user asks.

---

## Tone and communication style

- Be concise and operational.
- Make the create-vs-preserve decision explicit.
- Prefer safe defaults over broad rewrites.
- When retrofitting an active project, bias toward minimal intrusion.