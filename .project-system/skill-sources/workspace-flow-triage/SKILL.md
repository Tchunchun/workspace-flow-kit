---
name: workspace-flow-triage
description: Use when routing files from a Workspace Flow Kit `_inbox/` into `01-problem`, `02-design`, `03-comms`, `04-evals`, `05-ops`, `06-code`, or `docs` based on `.project-system/folder-triage-config.md`. Trigger on requests like "triage my inbox", "route my files", "sort my _inbox", "where does this go", "file these for me", or "clean up workspace files".
metadata:
   category: workflow
   triggers: triage my inbox, route my files, sort my _inbox, where does this go, file these for me, clean up workspace files
compatibility:
  requires: [Read, Write, mcp__workspace__bash]
---

# workspace-flow-triage

Route files from `_inbox/` into the correct Workspace Flow Kit folders with a proposal-first, confirm-before-moving workflow.

## Source material behind this skill

This skill is grounded in the project's `.project-system/folder-triage-config.md`, real Workspace Flow Kit routing decisions, and Agent Skills best-practice guidance: use project-specific rules, keep instructions concise, provide gotchas, and validate before execution.

## Workflow

1. **Locate the project root.** Prefer the nearest folder containing `.project-system/folder-triage-config.md`. If multiple roots are plausible, ask which project to triage.
2. **Read the routing source of truth.** Load `.project-system/folder-triage-config.md` before scanning files. If missing, use `references/default-folder-triage-config.md` and clearly say the project is using bundled defaults.
3. **Scan `_inbox/`.** Ignore hidden files and `README.md`. Flag folders containing `.git/` as code repos that need manual confirmation before moving.
4. **Classify each item in order:**
   - filename pattern rules
   - extension rules
   - content peek for `.md` and `.docx`
   - ambiguous / needs user call
5. **Check naming.** Suggest kebab-case, remove `_v2`, `_FINAL`, `_NEW`, and preserve file extensions.
6. **Present one complete triage report.** Do not move files yet.
7. **Execute only approved moves.** Respect overrides and skips.
8. **Validate after moving.** Confirm approved files moved, skipped files remain in `_inbox/`, and no destination was overwritten unintentionally.

## Default destination model

Use the project config as authoritative. If using bundled defaults, route to:

| Destination | Use for |
|---|---|
| `01-problem/` | problems, pain, research, findings, insights, opportunities |
| `02-design/` | flows, specs, requirements, UX/UI, architecture, solution shaping |
| `03-comms/` | updates, memos, launch notes, decks, external drafts |
| `04-evals/` | rubrics, metrics, test plans, QA captures, benchmark results |
| `05-ops/` | setup, onboarding, templates, process docs, config |
| `06-code/` | repositories, app code, skill source, implementation folders |
| `docs/` | final/reference artefacts |

## Triage report template

```text
📋 _inbox/ triage — [N] item(s) found

1. [original-name]
   → [destination]/[suggested-name]
   Reason: [filename | extension | content] matched [rule]

2. [original-name]  ⚠️ Needs your call
   → [option-a]/ or [option-b]/
   Reason: [why ambiguous]

Reply with:
- ok/all to approve everything
- skip [number]
- [number] → [folder]
- [number] rename [new-name]
```

For 10+ items, group the report by destination folder.

## Gotchas

- The config path is `.project-system/folder-triage-config.md`; do not use root-level routing files if the hidden config exists.
- Never move a `.git/` repository without explicit confirmation. Recommend `06-code/[repo-name]/`.
- Images are often ambiguous: QA/eval captures usually go to `04-evals/`, while design assets go to `02-design/`.
- A `.pdf` or `.docx` is not automatically final if filename/content points to active problem, design, comms, eval, or ops work.
- Do not create version-suffixed duplicates to resolve conflicts. Ask whether to overwrite, rename meaningfully, or skip.
- Do not empty `_inbox/` by guessing. Low-confidence files need a visible warning.

## Validation loop

Before executing moves:

1. Re-check every proposed destination exists in the loaded config.
2. Re-check each suggested filename preserves the extension.
3. Re-check conflicts at destination paths.
4. Downgrade to ambiguous when filename, extension, and content disagree.

After executing moves, summarize:

```text
✅ Moved [N] item(s):
- [source] → [destination]

⏭️ Skipped [N] item(s):
- [path]

_inbox status: [empty | still has N item(s)]
```
