#!/bin/bash
set -e

PLUGIN_DIR="/etc/coolercontrol/plugins/custom-device"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Installing Lian Li Fan Control Plugin for CoolerControl ==="

# 1. Install fan control script
echo "[1/4] Installing /usr/local/bin/lianli-fans..."
sudo install -m 755 "${SCRIPT_DIR}/lianli-fans" /usr/local/bin/lianli-fans

# 2. Create plugin directories
echo "[2/4] Setting up plugin directory: ${PLUGIN_DIR}..."
sudo mkdir -p "${PLUGIN_DIR}/ui"

# 3. Copy plugin binary, manifest, config and UI
echo "[3/4] Installing plugin files..."
sudo install -m 755 "${SCRIPT_DIR}/custom-device" "${PLUGIN_DIR}/custom-device"
sudo install -m 644 "${SCRIPT_DIR}/manifest.toml" "${PLUGIN_DIR}/manifest.toml"
sudo install -m 644 "${SCRIPT_DIR}/config.json" "${PLUGIN_DIR}/config.json"
sudo install -m 644 "${SCRIPT_DIR}/ui/index.html" "${PLUGIN_DIR}/ui/index.html"

# 4. Restart CoolerControl daemon
echo "[4/4] Restarting coolercontrold..."
sudo systemctl restart coolercontrold

echo ""
echo "=== Done! Lian Li Uni Hub SL is now integrated into CoolerControl! ==="
echo "Open CoolerControl to see 'Lian Li Uni Hub SL' under Devices."
