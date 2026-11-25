# Lian Li UNI FAN SL Plugin for CoolerControl

This plugin integrates the **Lian Li UNI HUB SL v1.8 / v1** controller (`0cf2:a100` / `0cf2:7750`) directly into [CoolerControl](https://gitlab.com/coolercontrol/coolercontrol) under Linux.

## Features

- **Direct Fan Speed Control**: Control fan duty cycle (0–100%) via USB HID output reports.
- **Real-Time Hardware RPM Reporting**: Reads accurate, real-time fan RPM directly from the controller hardware via HID Input Reports (`HIDIOCGINPUT`).
- **CoolerControl GUI Integration**: Manage fan speeds, create custom temperature curves (based on CPU Tctl, Liquid Coolant, or GPU Temp), and set Mix Profiles.
- **Multi-channel Sync**: Automatically controls all connected SL fan channels on the hub simultaneously.

## Installation

```bash
git clone https://github.com/DENRI1994/coolercontrol-plugin-lianli.git
cd coolercontrol-plugin-lianli
sudo ./install.sh
```

Then in CoolerControl:
1. Under **Devices**, you will see **Lian Li Uni Hub SL** with the channel **Lian Li SL Fans**.
2. Create or assign a Profile / Temperature Curve (e.g. Graph or Mix Profile).

## Protocol Details

Uses report ID `0xE0` on `/dev/hidraw*`:
- **Mode Register**: `0x31` (`[0xE0, 0x10, 0x31, 0x10 << channel]`) to disable Motherboard RPM Sync and enable manual USB mode.
- **Speed Register**: `0x20 + channel` (`[0xE0, 0x20 + channel, 0x00, speed_byte]`) where `speed_byte = (800 + 11 * percent) / 19`.
- **RPM Readback**: `ioctl(fd, HIDIOCGINPUT, [0xE0, ...])`, reading 16-bit big-endian RPM for each channel directly from hardware.
