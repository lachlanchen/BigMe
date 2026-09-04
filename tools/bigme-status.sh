#!/usr/bin/env bash
set -euo pipefail

device_ip="${1:-}"

echo "USB devices matching likely BigMe/MediaTek entries:"
system_profiler SPUSBDataType 2>/dev/null | awk '
  /k65v1_64_bsp|MediaTek/ { show=1 }
  show { print }
  show && /^$/ { show=0 }
'

if [[ -n "$device_ip" ]]; then
  echo
  echo "Network reachability for the supplied device address:"
  ping -c 1 -W 1000 "$device_ip" >/dev/null 2>&1 \
    && echo "ping: reachable" \
    || echo "ping: not reachable"
  arp -n "$device_ip" 2>/dev/null || true

  echo
  echo "Common control ports:"
  for port in 22 5555 8022; do
    nc -vz -G 1 "$device_ip" "$port" >/dev/null 2>&1 \
      && echo "$port: open" \
      || echo "$port: closed/refused/unreachable"
  done
else
  echo
  echo "Network probe skipped. Pass the current device IP as the first argument to enable it."
fi

echo
echo "ADB version:"
adb version

echo
echo "ADB devices:"
adb devices -l

echo
echo "ADB mDNS wireless debugging services:"
adb mdns services || true

echo
echo "Expected ADB state:"
echo "- device: ready for direct sync"
echo "- unauthorized: unlock BigMe and accept the USB debugging prompt"
echo "- no device: enable USB debugging, reconnect USB, or switch USB mode"
