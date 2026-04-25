#!/bin/bash
# Photonicat2 OpenWrt Build Script
# Usage: bash scripts/build.sh

set -e

BUILD_DIR=$(cd "$(dirname "$0")/.." && pwd)
LOG_FILE="$BUILD_DIR/build.log"

echo "========================================="
echo "Photonicat2 OpenWrt Build"
echo "========================================="

cd "$BUILD_DIR"

# 1. Apply patches (if not already applied)
echo "[1/6] Applying patches..."
if [ -f "patches/feeds-ddns-cloudflare/apply.sh" ]; then
    bash patches/feeds-ddns-cloudflare/apply.sh || true
fi
if [ -f "patches/feeds-footer-version/apply.sh" ]; then
    bash patches/feeds-footer-version/apply.sh || true
fi

# 2. Update feeds
echo "[2/6] Updating feeds..."
./scripts/feeds update -a || true

# 3. Install feeds
echo "[3/6] Installing feeds..."
./scripts/feeds install -a || true

# 4. Configure
echo "[4/6] Configuration..."
if [ ! -f ".config" ]; then
    echo "No .config found. Run 'make menuconfig' first."
    exit 1
fi

# 5. Build
echo "[5/6] Building (this will take 30-60 minutes)... "
make -j$(nproc) world 2>&1 | tee "$LOG_FILE"

# 6. Verify
echo "[6/6] Build complete!"
if [ -f "bin/targets/rockchip/armv8/"*.sysupgrade.img.gz ]; then
    echo "Firmware found:"
    ls -lh bin/targets/rockchip/armv8/*.img.gz
else
    echo "ERROR: Firmware not found!"
    exit 1
fi
