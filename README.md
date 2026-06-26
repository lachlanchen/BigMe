# BigMe
BigMe device connection and file sync workspace

## Current Device

macOS sees the connected device over USB as:

- Product: `k65v1_64_bsp`
- Vendor: MediaTek / `0x0e8d`
- Serial: `INCPQ130A234L46003381`
- Manufacturer: `alps`

Android platform tools are installed locally, including `adb`.

At initial setup, `adb devices -l` did not list an authorized device. Enable
Developer options and USB debugging on the BigMe, then reconnect USB and accept
the RSA authorization prompt on the device.

## Commands

Check connection:

```bash
./tools/bigme-status.sh
```

Sync a file or folder to the BigMe:

```bash
./tools/sync-to-bigme.sh /path/to/file.pdf
./tools/sync-to-bigme.sh /path/to/folder /sdcard/Documents/LinguaLeaf
```

The default destination is `/sdcard/Documents/`.
