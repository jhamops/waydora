#!/bin/bash
# Phase 3 — Steam + Proton + Gaming Tools
# Run from within Hyprland (Wayland session active).
# Games: Dota 2 (native), Lies of P + RE9 (Proton-GE)
set -euo pipefail

echo "=== Phase 3: Gaming Setup ==="

# ── Steam (RPM Fusion nonfree) ────────────────────────────────────────────────
echo "[1/5] Installing Steam..."
sudo dnf install -y \
  steam \
  steam-devices

# 32-bit libs needed by Steam
sudo dnf install -y \
  glibc.i686 \
  libstdc++.i686 \
  sdl2-compat.i686

# ── Performance tools ─────────────────────────────────────────────────────────
echo "[2/5] Installing gaming performance tools..."
sudo dnf install -y \
  gamemode \
  gamescope \
  mangohud

# Enable gamemode service for the user
systemctl --user enable gamemoded 2>/dev/null || \
  echo "  gamemode user service: check manually with systemctl --user enable gamemoded"

# ── Proton-GE (for Lies of P + RE9) ──────────────────────────────────────────
# Proton-GE gives better compatibility than stock Proton for RE Engine games
echo "[3/5] Installing Proton-GE..."
PROTON_GE_VER="9-27"  # Update to latest from https://github.com/GloriousEggroll/proton-ge-custom/releases
PROTON_DIR="$HOME/.steam/steam/compatibilitytools.d"
mkdir -p "$PROTON_DIR"

if [ ! -d "$PROTON_DIR/GE-Proton${PROTON_GE_VER}" ]; then
  echo "  Downloading GE-Proton${PROTON_GE_VER}..."
  wget -qO /tmp/ge-proton.tar.gz \
    "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${PROTON_GE_VER}/GE-Proton${PROTON_GE_VER}.tar.gz"
  tar -xf /tmp/ge-proton.tar.gz -C "$PROTON_DIR"
  rm /tmp/ge-proton.tar.gz
  echo "  GE-Proton${PROTON_GE_VER} installed to $PROTON_DIR"
else
  echo "  GE-Proton${PROTON_GE_VER} already installed"
fi

# ── Controller support ────────────────────────────────────────────────────────
echo "[4/5] Configuring controller support..."
# xpadneo not packaged for Fedora 44 — kernel hid-xpad module handles Xbox
# controllers; steam-devices (installed above) covers udev rules.
# linuxconsoletools (no hyphen) provides jstest/jscal.
sudo dnf install -y \
  linuxconsoletools

# udev rules for controllers (steam-devices covers most)
sudo usermod -aG input "$USER"

# ── Vulkan + DXVK support ─────────────────────────────────────────────────────
echo "[5/5] Installing Vulkan layers..."
sudo dnf install -y \
  vulkan-tools \
  vulkan-loader \
  vulkan-loader.i686 \
  mesa-vulkan-drivers \
  mesa-vulkan-drivers.i686

echo ""
echo "════════════════════════════════════════════"
echo " Phase 3 complete"
echo "════════════════════════════════════════════"
echo ""
echo " Steam launch options for games:"
echo ""
echo " Dota 2 (native — no Proton needed):"
echo "   DXVK_ASYNC=1 gamemoderun %command%"
echo ""
echo " Lies of P (RE-Engine, use Proton-GE):"
echo "   PROTON_USE_WINED3D=0 gamemoderun %command%"
echo "   → In Steam: Properties → Compatibility → GE-Proton${PROTON_GE_VER}"
echo ""
echo " RE9 (Resident Evil series, Proton-GE):"
echo "   PROTON_USE_WINED3D=0 MANGOHUD=1 gamemoderun %command%"
echo "   → In Steam: Properties → Compatibility → GE-Proton${PROTON_GE_VER}"
echo ""
echo " NOTE: Log out/in for 'input' group to take effect for controllers"
