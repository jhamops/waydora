#!/usr/bin/env bash
# Toggle keybindings cheat sheet — open if closed, close if open

if ! hyprctl -j clients | python3 -c "import json,sys; exit(0 if any(c['class']=='keybindings' for c in json.load(sys.stdin)) else 1)" 2>/dev/null; then
    kitty --class "keybindings" --override "font_size=11" -e ~/.config/hypr/scripts/keybindings.sh &
fi
