#!/bin/bash
# Symlink dotfiles into ~/.config
# Safe to re-run — backs up existing files before linking.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/dotfiles"
CONFIG="$HOME/.config"
BACKUP="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

link_config() {
  local src="$DOTFILES/$1"
  local dst="$CONFIG/$2"
  local dir
  dir="$(dirname "$dst")"
  mkdir -p "$dir"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/"
    echo "  Backed up existing $(basename "$dst") → $BACKUP/"
  fi

  ln -sfn "$src" "$dst"
  echo "  Linked: $dst"
}

echo "Linking dotfiles from $DOTFILES → $CONFIG"

link_config "hypr"                                    "hypr"
link_config "waybar"                                  "waybar"
link_config "mako"                                    "mako"
link_config "kitty"                                   "kitty"
link_config "fish/config.fish"                        "fish/config.fish"
link_config "starship/starship.toml"                  "starship.toml"
link_config "wireplumber/wireplumber.conf.d"          "wireplumber/wireplumber.conf.d"

# Make scripts executable
chmod +x "$DOTFILES/hypr/scripts/"*.sh 2>/dev/null || true

# XDG user dirs
xdg-user-dirs-update 2>/dev/null || true

echo ""
echo "Dotfiles installed. Existing configs backed up to $BACKUP (if any)."
echo "Reload Hyprland with SUPER+SHIFT+R if already running."
