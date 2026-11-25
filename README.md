# Lian Li UNI FAN SL Plugin for CoolerControl

This plugin integrates the **Lian Li UNI HUB SL v1.8 / v1** controller (`0cf2:a100` / `0cf2:7750`) directly into [CoolerControl](https://gitlab.com/coolercontrol/coolercontrol) under Linux.

## Features

- **Direct Fan Control**: Control fan duty cycle (0–100%) via USB HID output reports.
- **CoolerControl GUI Integration**: Manage fan speeds, create custom temperature curves (e.g., based on AMD Ryzen `k10temp` / `Tctl` or GPU temperature), and set profiles.
- **RPM Reporting**: Displays estimated fan RPM (800 – 1900 RPM) directly in CoolerControl graphs.
- **Multi-channel sync**: Automatically applies speeds to all connected SL fan channels on the hub.

## Installation

Clone this repository and run the installation script:

```bash
cd coolercontrol-lianli-plugin
sudo ./install.sh
```

Then open CoolerControl:
1. Navigate to **Devices**.
2. Look for **Lian Li Uni Hub SL** -> **Lian Li SL Fans**.
3. Create or assign a Profile / Temperature Curve.

## Protocol Details

Uses report ID `0xE0` on `/dev/hidraw*`:
- **Mode Register**: `0x31` (`[0xE0, 0x10, 0x31, 0x10 << channel]`) for manual mode.
- **Speed Register**: `0x20 + channel` (`[0xE0, 0x20 + channel, 0x00, speed_byte]`) where `speed_byte = (800 + 11 * percent) / 19`.
