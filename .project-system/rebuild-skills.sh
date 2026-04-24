#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)
SOURCE_ROOT="$SCRIPT_DIR/skill-sources"

if [[ ! -d "$SOURCE_ROOT" ]]; then
  echo "Missing skill source directory: $SOURCE_ROOT" >&2
  exit 1
fi

count=0

while IFS= read -r -d '' skill_dir; do
  skill_name=$(basename "$skill_dir")
  archive_path="$REPO_ROOT/$skill_name.skill"

  rm -f "$archive_path"
  (
    cd "$SOURCE_ROOT"
    zip -qr "$archive_path" "$skill_name"
  )

  echo "Built $(basename "$archive_path")"
  count=$((count + 1))
done < <(find "$SOURCE_ROOT" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

if [[ $count -eq 0 ]]; then
  echo "No skill source folders found in $SOURCE_ROOT" >&2
  exit 1
fi

echo "Done. Rebuilt $count skill archive(s)."