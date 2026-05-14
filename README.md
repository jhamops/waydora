# Hyprland / Omarchy-style Setup — Fedora 44 + NVIDIA RTX 4050

Adapted from [Omarchy](https://github.com/basecamp/omarchy) (Arch-based) to **Fedora 44** using only DNF + RPM Fusion.  
Maintains full RHCSA/LPIC-1 compatibility: SELinux enforcing, firewalld active, systemd-native.

> Tested on: MSI Cyborg 15 A13VE · Intel 13th Gen · NVIDIA RTX 4050 · Fedora 44 · Kernel 7.0.6

---

## Quick Start (fresh install)

```bash
git clone https://github.com/YOUR_USER/YOUR_REPO.git ~/setup-hyprland
cd ~/setup-hyprland

# Step 1 — Base system + NVIDIA drivers (requires reboot)
bash phase1-system.sh
sudo reboot

# Step 2 — Hyprland stack (run after reboot, still in GNOME)
bash phase2-hyprland.sh
bash install-dotfiles.sh
# Edit monitors.conf for your resolution, then log into Hyprland from SDDM

# Step 3 — Gaming (run inside Hyprland)
bash phase3-gaming.sh

# Step 4 — Remove GNOME (DESTRUCTIVE — only when Hyprland is stable)
bash phase4-cleanup.sh
sudo reboot
```

---

## What's Included

| Component       | Choice                              |
|-----------------|-------------------------------------|
| WM              | Hyprland 0.55.0                     |
| Status bar      | Waybar                              |
| Notifications   | Mako                                |
| Launcher        | Wofi                                |
| Lock screen     | Hyprlock + Hypridle                 |
| Display manager | SDDM                                |
| Terminal        | Kitty                               |
| Shell           | Fish + Starship                     |
| Editor          | Neovim                              |
| Browser         | Chromium                            |
| Theme           | Tokyo Night                         |
| Font            | JetBrains Mono Nerd Font            |
| Icons           | Papirus-Dark                        |
| Audio           | PipeWire + WirePlumber              |
| Gaming          | Steam + Proton-GE + Gamemode        |
| Android         | Waydroid (LineageOS + GAPPS)        |

---

## Aesthetic (Omarchy Tokyo Night)

| Element    | Value                                   |
|------------|-----------------------------------------|
| Border     | 2px · active: cyan→green 45° gradient  |
| Rounding   | 0px (sharp corners — Omarchy default)  |
| Gaps       | inner 5px / outer 10px                 |
| Blur       | size 2, passes 2, brightness 0.6       |
| Opacity    | terminals 0.92 active / 0.85 inactive  |
| Animations | windows slide overshot, workspaces off |

---

## Workspaces

| # | Name      | Default Apps                    | Key     |
|---|-----------|---------------------------------|---------|
| 1 | Browser   | Chromium, Firefox, AWS study    | SUPER+1 |
| 2 | Docs      | Obsidian, Evince, LibreOffice   | SUPER+2 |
| 3 | Terminal  | Kitty (opens on current WS)     | SUPER+3 |
| 4 | Comms     | Signal, Telegram, Discord       | SUPER+4 |
| 5 | Media     | MPV, Spotify, VLC, OBS          | SUPER+5 |
| 6 | Gaming    | Steam, Dota2, Proton games      | SUPER+6 |

---

## Keybindings

### Session
| Keybind           | Action              |
|-------------------|---------------------|
| SUPER + SHIFT + Q | Exit Hyprland       |
| SUPER + L         | Lock screen         |
| SUPER + SHIFT + R | Reload config       |
| SUPER + /         | Keybindings cheat sheet (toggle) |

### Apps
| Keybind              | Action                  |
|----------------------|-------------------------|
| SUPER + ENTER        | Terminal (Kitty)        |
| SUPER + ALT + ENTER  | Terminal + Tmux         |
| SUPER + SHIFT+ENTER  | Browser (Chromium)      |
| SUPER + SHIFT + F    | File manager (Nautilus) |
| SUPER + SHIFT + N    | Neovim                  |
| SUPER + SHIFT + M    | Music (cmus)            |
| SUPER + D            | App launcher (Wofi)     |
| SUPER + V            | Clipboard history       |

### Screenshots
| Keybind          | Action                          |
|------------------|---------------------------------|
| Print            | Full screen → ~/Pictures        |
| SHIFT + Print    | Area selection → ~/Pictures     |
| SUPER + SHIFT+S  | Area selection → clipboard      |
| CTRL + Print     | Area selection → clipboard      |

### Window Management
| Keybind              | Action                    |
|----------------------|---------------------------|
| SUPER + Q            | Close window              |
| SUPER + F            | Fullscreen                |
| SUPER + ALT + F      | Fullscreen (no gaps)      |
| SUPER + SHIFT+SPACE  | Toggle floating           |
| SUPER + T            | Toggle split layout       |
| SUPER + P            | Pseudo-tiling             |

### Focus
| Keybind          | Action        |
|------------------|---------------|
| SUPER + H / ←   | Focus left    |
| SUPER + J / ↓   | Focus down    |
| SUPER + K / ↑   | Focus up      |
| SUPER + → (arrow) | Focus right |

### Move Windows
| Keybind              | Action             |
|----------------------|--------------------|
| SUPER + SHIFT + H/J/K/L | Move window   |
| SUPER + click left   | Drag window        |
| SUPER + click right  | Resize window      |

### Resize
| Keybind            | Action           |
|--------------------|------------------|
| SUPER + CTRL + H   | Shrink left      |
| SUPER + CTRL + L   | Expand right     |
| SUPER + CTRL + K   | Shrink up        |
| SUPER + CTRL + J   | Expand down      |

### Workspaces
| Keybind               | Action                       |
|-----------------------|------------------------------|
| SUPER + 1…6           | Go to workspace              |
| SUPER + SHIFT + 1…6   | Move window to workspace     |
| SUPER + ALT + 1…6     | Move window (silent)         |
| SUPER + TAB           | Next workspace               |
| SUPER + SHIFT + TAB   | Previous workspace           |
| SUPER + scroll        | Navigate workspaces          |

---

## NVIDIA RTX 4050 — Wayland Notes

### Kernel parameters (set by phase1)
```
nvidia_drm.modeset=1
nvidia_drm.fbdev=1
nvidia.NVreg_PreserveVideoMemoryAllocations=1
```

### Environment variables (env.conf)
```ini
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = LIBVA_DRIVER_NAME,nvidia
env = NVD_BACKEND,direct
env = ELECTRON_OZONE_PLATFORM_HINT,auto
env = MOZ_ENABLE_WAYLAND,1
env = SDL_VIDEODRIVER,wayland
```

### Verify Wayland is working
```bash
glxinfo | grep "direct rendering"   # should say Yes
nvidia-smi                          # GPU active
vainfo                              # VA-API codec support
```

### Cursor invisible after boot?
Uncomment in `env.conf`:
```ini
# cursor { no_hardware_cursors = true }
```

---

## Audio / Microphone

**Hardware:** MSI Cyborg 15 — SOF HDA DSP (`sof-hda-dsp`)  
**Stack:** PipeWire 1.6.4 + WirePlumber

### Microphone fix (applied automatically via dotfiles)
The internal DMIC (Digital Microphone) needs ALSA capture enabled and WirePlumber default set:

```bash
# Enable ALSA capture (run once after install)
amixer -c1 sset 'Capture' 80% cap
amixer -c1 sset 'Dmic0' cap

# Set default mic in WirePlumber (find ID with: wpctl status)
wpctl set-default <DMIC_ID>
```

The `dotfiles/wireplumber/wireplumber.conf.d/50-default-mic.conf` persists the default mic across reboots.

---

## Gaming

### Dota 2 (Native Linux)
Steam launch options:
```
DXVK_ASYNC=1 gamemoderun %command%
```

### Lies of P / RE9 (Proton-GE)
1. Steam → Properties → Compatibility → Force: **GE-Proton9-27**
2. Launch options:
```
PROTON_USE_WINED3D=0 MANGOHUD=1 gamemoderun %command%
```

### Install / Update Proton-GE
```bash
PROTON_GE_VER="9-27"
PROTON_DIR="$HOME/.steam/steam/compatibilitytools.d"
mkdir -p "$PROTON_DIR"
wget -O /tmp/ge-proton.tar.gz \
  "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton${PROTON_GE_VER}/GE-Proton${PROTON_GE_VER}.tar.gz"
tar -xf /tmp/ge-proton.tar.gz -C "$PROTON_DIR"
rm /tmp/ge-proton.tar.gz
```

---

## Waydroid (Android on Linux)

Run Android apps natively using Linux containers. Used for mobile games (e.g. 7DS Grand Cross).

### Install
```bash
sudo dnf install -y waydroid waydroid-selinux
sudo waydroid init -c https://ota.waydro.id/system -v https://ota.waydro.id/vendor -r lineage -s GAPPS
sudo systemctl start waydroid-container
waydroid show-full-ui
```

### ARM translation (required for most mobile games)
Many Android games use ARM libraries. Install libhoudini for x86_64 translation:
```bash
cd /tmp && git clone https://github.com/casualsnek/waydroid_script
cd waydroid_script
sudo pip install InquirerPy tqdm requests --break-system-packages
sudo python3 main.py install libhoudini
```

### Google Play certification
```bash
# 1. Get Android ID
sudo waydroid shell
sqlite3 /data/data/com.google.android.gsf/databases/gservices.db \
  "select * from main where name = 'android_id';"

# 2. Register at:
# https://www.google.com/android/uncertified/?id=<YOUR_ANDROID_ID>

# 3. Wait 5-10 minutes, then sign into Play Store
```

### Start/Stop Waydroid
```bash
# Start
sudo systemctl start waydroid-container && waydroid show-full-ui

# Stop
waydroid session stop
sudo systemctl stop waydroid-container
```

---

## Dotfile Structure

```
dotfiles/
├── hypr/
│   ├── hyprland.conf          ← main config, sources all others
│   ├── env.conf               ← NVIDIA + Wayland environment vars
│   ├── monitors.conf          ← EDIT THIS for your display/resolution
│   ├── looknfeel.conf         ← Tokyo Night visuals, animations
│   ├── autostart.conf         ← programs launched at Hyprland start
│   ├── keybindings.conf       ← all keybinds
│   ├── windowrules.conf       ← workspace assignments + float rules
│   └── scripts/
│       ├── keybindings.sh     ← cheat sheet content (SUPER+/)
│       └── toggle-keybindings.sh ← opens cheat sheet (no duplicates)
├── waybar/
│   ├── config.jsonc
│   └── style.css
├── wireplumber/
│   └── wireplumber.conf.d/
│       └── 50-default-mic.conf ← sets DMIC as default microphone
├── mako/config                ← notification daemon
├── kitty/kitty.conf           ← terminal emulator
├── fish/config.fish           ← shell config
└── starship/starship.toml     ← prompt
```

---

## SELinux + Firewalld (RHCSA Compatible)

SELinux stays in **enforcing** mode. If you hit AVC denials:
```bash
# Diagnose
sudo ausearch -m AVC -ts today | audit2why

# Fix without disabling SELinux
sudo ausearch -m AVC -ts today | audit2allow -M local-hyprland
sudo semodule -i local-hyprland.pp
```

Firewalld stays active. No ports need opening for a desktop setup.

---

## Hyprlock (Lock Screen)

Create `~/.config/hypr/hyprlock.conf`:
```ini
background {
  color = rgba(26, 27, 38, 1.0)
}
input-field {
  size = 300 50
  outline_thickness = 2
  outer_color = rgb(7aa2f7)
  inner_color = rgb(1a1b26)
  font_color = rgb(c0caf5)
}
```

---

## Troubleshooting

### WiFi not working after install
```bash
sudo dnf install -y NetworkManager-wifi wpa_supplicant
sudo systemctl restart NetworkManager
```

### Microphone not capturing
```bash
# Check if ALSA capture is enabled
amixer -c1 sget 'Capture'
amixer -c1 sget 'Dmic0'

# Enable if showing [off]
amixer -c1 sset 'Capture' 80% cap
amixer -c1 sset 'Dmic0' cap

# Set correct PipeWire source
wpctl status   # find DMIC ID
wpctl set-default <ID>
```

### Hyprland config errors
```bash
# Check logs
cat /run/user/1000/hypr/*/hyprland.log | grep -v "DEBUG from aquamarine\|libinput\|drm:"

# Check for keybind conflicts
hyprctl -j binds | python3 -c "
import json,sys
binds=json.load(sys.stdin)
seen={}
for b in binds:
    key=(b['modmask'],b['key'])
    if key in seen: print(f'CONFLICT: {seen[key][\"dispatcher\"]} vs {b[\"dispatcher\"]} on {b[\"key\"]}')
    seen[key]=b
"

# Check active window class (for windowrules)
hyprctl activewindow | grep class
```

### Waydroid not starting
```bash
# Check binder support
ls /dev/binder || grep -i binder /proc/filesystems

# Restart container
sudo systemctl restart waydroid-container
waydroid show-full-ui
```
