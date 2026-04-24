---
name: inbox-triage
description: Use when the user wants files routed from a project's `_inbox/` into the correct folders based on `.project-system/folder-triage-config.md`. Trigger on requests like "triage my inbox", "route my files", "sort my _inbox", "where does this go", "file these for me", or cleanup requests for project files.
metadata:
   category: workflow
   triggers: triage my inbox, route my files, sort my inbox, file these for me, where does this go, clean up my files
compatibility:
  requires: [Read, Write, mcp__workspace__bash]
---

# inbox-triage

Help the user route files from a project's `_inbox/` folder to the right destination — one file at a time, with their confirmation before anything moves.

## What this skill does

1. Finds the project root by locating `.project-system/folder-triage-config.md`
2. Reads the routing rules from the project's canonical triage config
3. Scans `_inbox/` for files to triage
4. For each file: proposes a destination and (if needed) a better filename
5. Waits for the user to confirm, override, or skip each move
6. Executes only the approved moves

This is **suggest mode** — nothing moves without explicit user approval.

---

## Step 1: Locate the project root

Look for `.project-system/folder-triage-config.md` starting from the current workspace folder. If there are multiple projects connected, ask the user which project they want to triage.

If `.project-system/folder-triage-config.md` is missing but a legacy root `_folder-triage-config.md` exists, use that and tell the user the project is still on the older layout.

If the config is missing but legacy `_folder-structure.md` and `_routing-rules.md` both exist, use those instead.

If none of those files exist, tell the user:
> "I can't find `.project-system/folder-triage-config.md` in this project. This file defines where things belong and how files should be routed — without it I can't suggest destinations. Would you like me to create one based on the folders I can see?"

---

## Step 2: Read the config files

Preferred path:

- Read **`.project-system/folder-triage-config.md`** fully before scanning anything. It contains the valid destination folders, routing logic, and naming rules.

Legacy compatibility path:

- If the hidden config is absent but legacy root **`_folder-triage-config.md`** exists, read it and continue.
- If the merged config is absent but both **`_folder-structure.md`** and **`_routing-rules.md`** are present, read both and combine them mentally.

Fallback path:

- If the project config is missing, load **`references/default-folder-triage-config.md`** from this skill and tell the user you are using bundled defaults.

---

## Step 3: Scan _inbox/

List everything in `_inbox/` excluding:
- `README.md` — that's the inbox's own documentation, leave it alone
- Hidden files (`.DS_Store`, etc.)
- Sub-folders that are git repos (contain `.git/`) — flag these separately, they need to move to the code folder manually

If `_inbox/` is empty, tell the user cheerfully and stop:
> "_inbox/ is empty — nothing to triage! Great discipline."

**Large batch flag**: If there are 10 or more files, set `large_batch = true`. This changes the Step 5 report format to group files by destination folder instead of listing them in scan order.

---

## Step 4: Classify each file

For each file, apply routing rules in this order:

1. **Filename pattern match** — check against patterns in the routing section of the loaded triage config
2. **Extension match** — check the file extension table
3. **Content peek** — for `.md` files, read the first 20 lines and check content signals. For `.docx` files, run:
   ```
   python3 -c "import docx; print('\n'.join([p.text for p in docx.Document('path').paragraphs[:10]]))"
   ```
   If `python-docx` isn't available, fall back to extension-only routing for that file and note this to the user.
4. **Ambiguous** — if no rule matches confidently, flag as "needs your call"

Also check the filename against naming conventions:
- Spaces → hyphens
- Underscores → hyphens  
- `_v2`, `_FINAL`, `_NEW` suffixes → strip and note
- Missing date prefix on meeting notes → suggest `YYYY-MM-DD-` prefix
- CamelCase or ALL_CAPS → convert to kebab-case

## Gotchas

- The preferred config path is `.project-system/folder-triage-config.md`, not a root metadata file.
- If both the hidden config and a legacy root config exist, prefer the hidden config.
- Do not move folders that contain `.git/`; route them manually to `06-code/`.
- Treat images as ambiguous when there is any plausible design-vs-QA conflict.
- Do not auto-overwrite destination files. Ask whether to overwrite, rename, or skip.

---

## Step 5: Present the triage report

Show all files together as a triage report before asking for any confirmations. This gives the user the full picture first. Format it like this:

```
📋 _inbox/ triage — 5 files found

1. steerco-slides.pptx
   → 05-comms/slides/steerco-slides.pptx
   ✏️  Rename: steerco-2026-04-24.pptx  (add date for deck files)
   Reason: .pptx extension → slides

2. meeting notes april.md
   → meetings/2026-04-24-meeting-notes-april.md
   ✏️  Rename: 2026-04-24-meeting-notes-april.md  (spaces → hyphens, add date prefix)
   Reason: content contains "## Attendees", "## Action items"

3. eval_results_Q2.csv
   → 04-delivery/metrics/eval-results-q2.csv
   ✏️  Rename: eval-results-q2.csv  (underscores → hyphens)
   Reason: filename contains "eval", "results" + .csv extension

4. plaid-auth-spec_FINAL.md
   → 04-delivery/specs/plaid-auth-spec.md
   ✏️  Rename: plaid-auth-spec.md  (strip _FINAL suffix)
   Reason: content contains "## Acceptance criteria", "# PRD"

5. mystery-notes.md  🔶 Low confidence
   → 02-discovery/findings/mystery-notes.md  (best guess — content unclear)
   Reason: no filename or content signals matched; routed by exclusion

6. random-screenshot.png  ⚠️  Needs your call
   → 04-delivery/qa-and-testing/  or  03-design/
   Reason: .png could be a QA capture or a design asset — which is it?
```

### Confidence tiers

Each file in the report gets one of three signals:

- **(no icon)** — high confidence: a filename pattern or content signal matched clearly.
- **🔶 Low confidence** — the skill made a best guess but no strong signal matched. The suggested destination is shown, but the user should double-check.
- **⚠️ Needs your call** — genuinely ambiguous; the skill cannot choose between two or more destinations.

This reduces the ask-every-time pattern while still surfacing uncertainty.

### Large batch format

If `large_batch` was set in Step 3 (10+ files), group the report by destination folder:

```
📋 _inbox/ triage — 14 files found (grouped by destination)

── 05-comms/slides/ (3 files) ──
1. steerco-slides.pptx → steerco-2026-04-24.pptx
2. quarterly-review.pptx → quarterly-review.pptx
3. demo.html → demo.html

── meetings/ (2 files) ──
4. meeting notes april.md → 2026-04-24-meeting-notes-april.md
5. sync-call.md → 2026-04-24-sync-call.md

...
```

Then ask:
> "Does this look right? Reply with:
> - **ok** or **all** to approve everything
> - **skip [number]** to leave a file in _inbox/
> - **[number] → [folder]** to override a destination
> - **[number] rename [new-name]** to override a filename
> Or just tell me in plain English what you'd like to change."

---

## Step 6: Execute approved moves

Once the user confirms (fully or partially):

- Move each approved file to its destination using the confirmed filename
- If the destination folder doesn't exist yet, create it — but tell the user you're doing this
- Print a clean summary of what moved:

```
✅ Moved 4 files:
   steerco-slides.pptx          → 05-comms/slides/steerco-2026-04-24.pptx
   meeting notes april.md       → meetings/2026-04-24-meeting-notes-april.md
   eval_results_Q2.csv          → 04-delivery/metrics/eval-results-q2.csv
   plaid-auth-spec_FINAL.md     → 04-delivery/specs/plaid-auth-spec.md

⏭️  Skipped 1 file (still in _inbox/):
   random-screenshot.png
```

---

## Edge cases to handle gracefully

**Git repos in _inbox/**: If a folder has a `.git/` directory, don't move it — git repos need to be moved carefully to avoid breaking the working tree. Flag it:
> "⚠️ `bicep-samples/` looks like a git repo. Please move it manually to `06-code/bicep-samples/` — I'll skip it for now."

**File already exists at destination**: Before moving, check if a file with that name already exists at the destination. If it does, tell the user and ask whether to overwrite, rename (add `-2`), or skip.

**No `_routing-rules.md`**: Fall back to extension-only routing and note which files you couldn't classify with confidence.

**Multiple projects in workspace**: If the user has more than one project folder connected, ask which project's `_inbox/` to triage before starting.

**Large batches (10+ files)**: Group files by destination folder in the report to make it easier to scan. Show the group header first, then the files within it.

---

## Validation loop

Before moving files:

1. Re-check that each proposed destination exists in the loaded config.
2. Re-check that any filename correction still preserves the file extension.
3. If a proposal conflicts with a user override, follow the user override.
4. If confidence dropped after a content peek, present the file as ambiguous instead of guessing.

---

## Post-triage: next-action hook

After a successful triage, if `_inbox/` is now empty, acknowledge the win. Then offer a clear next step:

> "All clear! If you'd like, I can triage again the next time you drop files in `_inbox/` — just say 'triage' or 'file these for me'."

If the user says "set this up to run automatically" or "remind me to triage", offer to create a scheduled task or a reminder — but **never do this unprompted**.

---

## Fallback routing rules

This skill depends on `.project-system/folder-triage-config.md` being present in the project. If that file is missing or incomplete, the skill first checks for a legacy root `_folder-triage-config.md`, then the legacy pair `_folder-structure.md` and `_routing-rules.md`. If those are absent too, it loads `references/default-folder-triage-config.md` (bundled with this skill) as a fallback — making the skill self-contained for new projects.

When the fallback is used, note this to the user:
> "I'm using the built-in default folder triage config since `.project-system/folder-triage-config.md` isn't in your project. You can create one with `mkdir -p .project-system && cp references/default-folder-triage-config.md ./.project-system/folder-triage-config.md` and customise it."

---

## Tone and communication style

- Be concise in the triage report — the user is trying to clear a backlog, not read an essay
- Explain reasoning briefly (one line per file is enough)
- When something is ambiguous, say so honestly rather than guessing confidently
- After a successful triage, note if `_inbox/` is now empty — that's a win worth acknowledging
