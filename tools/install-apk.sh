#!/usr/bin/env bash
set -euo pipefail

apk="${1:-}"

if [[ -z "$apk" ]]; then
  echo "Usage: $0 <apk-file>" >&2
  exit 2
fi

if [[ ! -f "$apk" ]]; then
  echo "APK not found: $apk" >&2
  exit 1
fi

device_count="$(adb devices | awk 'NR > 1 && $2 == "device" { count++ } END { print count + 0 }')"
if [[ "$device_count" -lt 1 ]]; then
  echo "No authorized ADB device found." >&2
  echo "Run ./tools/bigme-status.sh and authorize USB debugging on the BigMe." >&2
  exit 1
fi

adb install -r "$apk"
