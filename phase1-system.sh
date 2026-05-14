#!/bin/bash
# Phase 1 — RPM Fusion + NVIDIA RTX 4050 + System Base
# Run as regular user with sudo access.
# REBOOT after this completes — akmod builds the kernel module on first boot.
set -euo pipefail

FEDORA_VER=$(rpm -E %fedora)
echo "=== Phase 1: Fedora ${FEDORA_VER} — RPM Fusion + NVIDIA ==="

# ── RPM Fusion ────────────────────────────────────────────────────────────────
echo "[1/6] Enabling RPM Fusion..."
sudo dnf install -y \
  "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-${FEDORA_VER}.noarch.rpm" \
  "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-${FEDORA_VER}.noarch.rpm"

sudo dnf upgrade -y

# ── NVIDIA drivers (RTX 4050 = Ada Lovelace, needs driver 525+) ───────────────
echo "[2/6] Installing NVIDIA drivers..."
sudo dnf install -y \
  akmod-nvidia \
  xorg-x11-drv-nvidia \
  xorg-x11-drv-nvidia-cuda \
  xorg-x11-drv-nvidia-cuda-libs \
  libva-nvidia-driver \
  libvdpau \
  nvidia-settings

# RTX 4050 supports the open kernel modules (included in akmod-nvidia ≥ 560)
# Force build now so first reboot is fast
sudo akmods --force

# ── Add NVIDIA modules to initramfs (required for Wayland KMS) ────────────────
echo "[3/6] Configuring initramfs for NVIDIA..."
cat <<'EOF' | sudo tee /etc/dracut.conf.d/nvidia.conf
add_drivers+=" nvidia nvidia_modeset nvidia_uvm nvidia_drm "
EOF
sudo dracut --force

# ── Kernel parameters for Wayland + RTX 4050 ─────────────────────────────────
# nvidia_drm.modeset=1    — enable KMS (required for Wayland)
# nvidia_drm.fbdev=1      — framebuffer console via KMS (Fedora 40+)
# NVreg_PreserveVideoMemoryAllocations=1 — proper suspend/resume
echo "[4/6] Setting kernel parameters..."
sudo grubby --update-kernel=ALL \
  --args="nvidia_drm.modeset=1 nvidia_drm.fbdev=1 nvidia.NVreg_PreserveVideoMemoryAllocations=1"

# ── Base utilities ─────────────────────────────────────────────────────────────
echo "[5/6] Installing base utilities..."
sudo dnf install -y \
  git curl wget unzip tar \
  btop \
  fastfetch \
  fzf \
  fd-find \
  zoxide \
  tmux \
  jq \
  ripgrep \
  wl-clipboard \
  xdg-utils \
  xdg-user-dirs \
  polkit \
  gnome-keyring \
  libsecret \
  gvfs \
  dbus-tools

# ── SELinux: stay in enforcing mode (RHCSA requirement) ───────────────────────
# Just verify it's set correctly, no changes needed
echo "[6/6] Verifying SELinux + firewalld..."
getenforce
sudo systemctl is-enabled firewalld || sudo systemctl enable firewalld

echo ""
echo "════════════════════════════════════════════"
echo " Phase 1 complete — REBOOT NOW"
echo "════════════════════════════════════════════"
echo " After reboot, verify NVIDIA loaded:"
echo "   lsmod | grep nvidia"
echo "   nvidia-smi"
echo " Then run: bash phase2-hyprland.sh"
