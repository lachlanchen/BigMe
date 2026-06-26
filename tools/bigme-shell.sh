#!/usr/bin/env bash
set -euo pipefail

target="${1:-}"

if [[ -n "$target" ]]; then
  adb -s "$target" shell
else
  adb shell
fi
