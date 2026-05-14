#!/bin/bash
# Phase 2 — Hyprland Stack + Fish + Kitty + Starship
# Run AFTER rebooting from Phase 1.
# Verify NVIDIA is loaded: lsmod | grep nvidia && nvidia-smi
set -euo pipefail

echo "=== Phase 2: Hyprland Desktop Stack ==="

# ── Sanity check ──────────────────────────────────────────────────────────────
if ! lsmod | grep -q "^nvidia "; then
  echo "ERROR: NVIDIA module not loaded. Did you reboot after Phase 1?"
  echo "  Run: lsmod | grep nvidia"
  exit 1
fi
echo "NVIDIA confirmed: $(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null || echo 'driver loaded')"

# ── Hyprland core ─────────────────────────────────────────────────────────────
echo "[1/9] Installing Hyprland + Wayland portals..."
sudo dnf install -y \
  hyprland \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal-gtk \
  xdg-desktop-portal \
  qt5-qtwayland \
  qt6-qtwayland \
  libseat

# ── Wayland utilities (status bar, notifications, lock, screenshots) ──────────
echo "[2/9] Installing Wayland utilities..."
sudo dnf install -y \
  waybar \
  mako \
  swaybg \
  hyprlock \
  hypridle \
  grim \
  slurp \
  wofi \
  cliphist

# ── Audio (PipeWire stack) ────────────────────────────────────────────────────
echo "[3/9] Installing audio stack..."
sudo dnf install -y \
  pipewire \
  pipewire-alsa \
  pipewire-pulse \
  pipewire-jack-audio-connection-kit \
  wireplumber \
  pamixer \
  playerctl \
  pavucontrol

# ── Display manager: SDDM ─────────────────────────────────────────────────────
echo "[4/9] Installing SDDM..."
sudo dnf install -y sddm
sudo systemctl enable sddm
sudo systemctl disable gdm 2>/dev/null || echo "(GDM already disabled)"

# ── Terminal: Kitty ───────────────────────────────────────────────────────────
echo "[5/9] Installing Kitty terminal..."
sudo dnf install -y kitty

# ── Shell: Fish + Starship + tools ────────────────────────────────────────────
echo "[6/9] Installing Fish + Starship..."
sudo dnf install -y fish
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Change default shell to fish
FISH_PATH=$(which fish)
if ! grep -qF "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$FISH_PATH"
echo "Default shell changed to fish (takes effect on next login)"

# ── Fonts ─────────────────────────────────────────────────────────────────────
echo "[7/9] Installing fonts..."
sudo dnf install -y \
  jetbrains-mono-fonts \
  google-noto-fonts-common \
  google-noto-emoji-fonts \
  fontawesome-fonts

# JetBrains Mono Nerd Font (not in Fedora repos — direct download)
echo "  Downloading JetBrains Mono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNF"
mkdir -p "$FONT_DIR"
NFVER="3.3.0"
wget -qO /tmp/JetBrainsMono.zip \
  "https://github.com/ryanoasis/nerd-fonts/releases/download/v${NFVER}/JetBrainsMono.zip"
unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR" '*.ttf'
fc-cache -fv "$FONT_DIR"
rm /tmp/JetBrainsMono.zip
echo "  JetBrains Mono Nerd Font installed to $FONT_DIR"

# ── GTK theme + icons ─────────────────────────────────────────────────────────
echo "[8/9] Installing themes and icons..."
sudo dnf install -y \
  papirus-icon-theme

# Tokyo Night GTK theme (manual install — not in Fedora repos)
THEME_DIR="$HOME/.themes"
mkdir -p "$THEME_DIR"
if [ ! -d "$THEME_DIR/Tokyonight-Dark" ]; then
  echo "  Installing sassc (needed to build Tokyo Night GTK theme)..."
  sudo dnf install -y sassc
  echo "  Downloading Tokyo Night GTK theme..."
  rm -rf /tmp/tokyonight-gtk
  git clone --depth=1 https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git /tmp/tokyonight-gtk
  bash /tmp/tokyonight-gtk/themes/install.sh --color dark --dest "$THEME_DIR"
  rm -rf /tmp/tokyonight-gtk
fi

# ── Miscellaneous apps ────────────────────────────────────────────────────────
echo "[9/9] Installing misc applications..."
sudo dnf install -y \
  chromium \
  nautilus \
  mpv \
  imv \
  evince \
  imagemagick \
  lazygit \
  neovim \
  obsidian 2>/dev/null || \
  echo "  obsidian not in repos — install separately from obsidian.md"

# ── Deploy dotfiles ────────────────────────────────────────────────────────────
SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "Deploying dotfiles from $SETUP_DIR/dotfiles..."
bash "$SETUP_DIR/install-dotfiles.sh"

echo ""
echo "════════════════════════════════════════════"
echo " Phase 2 complete"
echo "════════════════════════════════════════════"
echo " - Edit ~/.config/hypr/monitors.conf with your resolution/refresh rate"
echo " - Log out of GNOME → select 'Hyprland' from SDDM session menu"
echo " - After testing Hyprland, run: bash phase3-gaming.sh"
echo " - After gaming setup, run: bash phase4-cleanup.sh to remove GNOME"
