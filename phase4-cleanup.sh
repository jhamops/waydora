#!/bin/bash
# Phase 4 — Remove GNOME, set Hyprland as default session
# Run ONLY after verifying Hyprland is stable and you no longer need GNOME.
# This is DESTRUCTIVE — GNOME cannot be easily restored after this.
set -euo pipefail

echo "=== Phase 4: Remove GNOME + Set Hyprland Default ==="
echo ""
echo "WARNING: This will remove GNOME Desktop and all GNOME apps."
echo "Make sure Hyprland is working before proceeding."
echo ""
read -rp "Type 'yes' to continue: " confirm
[ "$confirm" = "yes" ] || { echo "Aborted."; exit 0; }

# ── Remove GNOME ──────────────────────────────────────────────────────────────
echo "[1/3] Removing GNOME..."
sudo dnf remove -y \
  gnome-shell \
  gnome-session \
  gnome-control-center \
  gnome-software \
  gnome-terminal \
  gnome-text-editor \
  gnome-system-monitor \
  gnome-shell-extension-* \
  gdm \
  mutter

# Remove GNOME group (suppresses future deps pulling it back)
sudo dnf group remove -y "GNOME Desktop Environment" 2>/dev/null || true
sudo dnf autoremove -y

# ── Set SDDM + Hyprland as default ────────────────────────────────────────────
echo "[2/3] Setting SDDM as display manager..."
sudo systemctl enable sddm --force
sudo systemctl set-default graphical.target

# Configure SDDM to use the Hyprland-UWSM session
sudo mkdir -p /etc/sddm.conf.d
cat <<EOF | sudo tee /etc/sddm.conf.d/10-hyprland.conf
[General]
DisplayServer=x11
# Hyprland itself runs on Wayland; SDDM uses X11 for reliability with NVIDIA

[Autologin]
# Uncomment to enable autologin (optional):
# User=$USER
# Session=hyprland-uwsm
EOF

# ── SELinux file contexts (keep enforcing) ────────────────────────────────────
echo "[3/3] Restoring SELinux contexts..."
sudo restorecon -Rv /etc/sddm.conf.d/ 2>/dev/null || true
sudo restorecon -Rv "$HOME/.config/hypr/" 2>/dev/null || true

echo ""
echo "════════════════════════════════════════════"
echo " Phase 4 complete — REBOOT to enter Hyprland"
echo "════════════════════════════════════════════"
echo " SDDM will appear at boot → select 'Hyprland' session"
