#!/usr/bin/env bash
set -euo pipefail

src="${1:-}"
dest="${2:-/sdcard/Documents/}"

if [[ -z "$src" ]]; then
  echo "Usage: $0 <file-or-folder> [android-destination]" >&2
  exit 2
fi

if [[ ! -e "$src" ]]; then
  echo "Source not found: $src" >&2
  exit 1
fi

device_count="$(adb devices | awk 'NR > 1 && $2 == "device" { count++ } END { print count + 0 }')"
if [[ "$device_count" -lt 1 ]]; then
  echo "No authorized ADB device found." >&2
  echo "Run ./tools/bigme-status.sh and authorize USB debugging on the BigMe." >&2
  exit 1
fi

adb shell "mkdir -p '$dest'"
adb push "$src" "$dest"
