#!/usr/bin/env bash
set -euo pipefail

echo "USB devices matching likely BigMe/MediaTek entries:"
system_profiler SPUSBDataType 2>/dev/null | awk '
  /k65v1_64_bsp|MediaTek|Serial Number: INCPQ130A234L46003381/ { show=1 }
  show { print }
  show && /^$/ { show=0 }
'

echo
echo "ADB version:"
adb version

echo
echo "ADB devices:"
adb devices -l

echo
echo "Expected ADB state:"
echo "- device: ready for direct sync"
echo "- unauthorized: unlock BigMe and accept the USB debugging prompt"
echo "- no device: enable USB debugging, reconnect USB, or switch USB mode"
