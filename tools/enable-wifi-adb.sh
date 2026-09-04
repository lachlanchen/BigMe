#!/usr/bin/env bash
set -euo pipefail

ip="${1:-}"
port="${2:-5555}"

if [[ -z "$ip" ]]; then
  echo "Usage: $0 <device-ip> [adb-port]" >&2
  exit 2
fi

device_count="$(adb devices | awk 'NR > 1 && $2 == "device" { count++ } END { print count + 0 }')"
if [[ "$device_count" -lt 1 ]]; then
  echo "No authorized USB ADB device found." >&2
  echo "Enable USB debugging on the BigMe, reconnect USB, and accept the prompt first." >&2
  exit 1
fi

adb tcpip "$port"
sleep 2
adb connect "$ip:$port"
adb devices -l
