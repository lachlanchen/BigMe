# BigMe
BigMe device connection and file sync workspace

## Connect a device

Keep device serial numbers, local IP addresses, MAC addresses, and ADB pairing
codes in local operator notes rather than committed documentation. Discover the
currently connected device when needed:

```bash
adb devices -l
```

Android platform tools are installed locally, including `adb`.
OpenMTP is installed locally at `/Applications/OpenMTP.app` for GUI USB file
transfer when the device is in Android file-transfer/MTP mode.

At initial setup, `adb devices -l` did not list an authorized device. Wi-Fi ADB
port `5555`, SSH ports `22`/`8022`, and common wireless debugging ports refused
connections. Enable Developer options and USB debugging on the BigMe, then
reconnect USB and accept the RSA authorization prompt on the device.

If the device offers Android 11+ Wireless debugging, pair it from the BigMe
Developer options screen first:

```bash
adb pair <device-ip>:<pairing-port>
adb connect <device-ip>:<adb-port>
```

If USB debugging is authorized, this helper can switch the device to classic
ADB-over-Wi-Fi on port `5555`:

```bash
./tools/enable-wifi-adb.sh <device-ip>
```

## Commands

Check connection:

```bash
./tools/bigme-status.sh
./tools/bigme-status.sh <device-ip>  # also probe the local network route
```

Sync a file or folder to the BigMe:

```bash
./tools/sync-to-bigme.sh /path/to/file.pdf
./tools/sync-to-bigme.sh /path/to/folder /sdcard/Documents/LinguaLeaf
```

The default destination is `/sdcard/Documents/`.

Pull a file or folder from the BigMe:

```bash
./tools/sync-from-bigme.sh /sdcard/Documents ./downloads
```

Install an Android APK:

```bash
./tools/install-apk.sh /path/to/file-manager.apk
```

Open a shell:

```bash
./tools/bigme-shell.sh
```
