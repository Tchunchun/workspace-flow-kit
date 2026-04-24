# Project Init Skill Requirements

Date: 2026-04-24

## Goal

Create a new skill that helps initialize a project folder from the template.

## Core Requirements

- The skill shall create the project folder structure.
- The skill shall include the markdown file templates.
- The project model uses one merged root config file: `_folder-triage-config.md`.
- The project shall also include human-facing and agent-facing root docs such as `README.md` and `CLAUDE.md`.

## Working Direction Agreed In Planning

- Build a workflow skill, tentatively named `project-init`.
- The skill should initialize a fresh project workspace from this template.
- It should create folders first, then write root markdown files, then write starter folder-level templates.
- It should be safe to rerun and should not silently overwrite customized files.
- It should be packaged as a `.skill` archive.

## Likely Generated Artifacts

- Root files: `README.md`, `CLAUDE.md`, `_folder-triage-config.md`
- Core folders from the canonical structure
- Starter markdown templates in key folders

## Open Decisions Still Not Finalized

- Whether folder-level `README.md` files are created by default
- Whether the skill should use a minimal fast path or interactive setup questions
- Whether to support multiple presets such as `consumer`, `internal-tool`, and `research`