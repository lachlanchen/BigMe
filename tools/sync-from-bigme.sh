#!/usr/bin/env bash
set -euo pipefail

src="${1:-}"
dest="${2:-./bigme-downloads}"

if [[ -z "$src" ]]; then
  echo "Usage: $0 <android-source> [local-destination]" >&2
  exit 2
fi

device_count="$(adb devices | awk 'NR > 1 && $2 == "device" { count++ } END { print count + 0 }')"
if [[ "$device_count" -lt 1 ]]; then
  echo "No authorized ADB device found." >&2
  echo "Run ./tools/bigme-status.sh and authorize USB debugging on the BigMe." >&2
  exit 1
fi

mkdir -p "$dest"
adb pull "$src" "$dest"
