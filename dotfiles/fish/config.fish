# Fish shell config — Omarchy-style
# Prompt: Starship | tools: zoxide, fzf, fastfetch

if status is-interactive
    # ── Starship prompt ────────────────────────────────────────────────────────
    starship init fish | source

    # ── Zoxide (smart cd) ──────────────────────────────────────────────────────
    zoxide init fish | source

    # ── FZF keybindings ────────────────────────────────────────────────────────
    fzf --fish 2>/dev/null | source

    # ── Environment ────────────────────────────────────────────────────────────
    set -gx EDITOR nvim
    set -gx VISUAL nvim
    set -gx TERMINAL kitty
    set -gx BROWSER chromium-browser
    set -gx PAGER less
    set -gx MANPAGER "nvim +Man!"
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
    set -gx FZF_DEFAULT_OPTS '--color=bg+:#283457,bg:#1a1b26,spinner:#7dcfff,hl:#7aa2f7 \
      --color=fg:#c0caf5,header:#7aa2f7,info:#7dcfff,pointer:#7aa2f7 \
      --color=marker:#9ece6a,fg+:#c0caf5,prompt:#7aa2f7,hl+:#7aa2f7'

    # ── PATH additions ─────────────────────────────────────────────────────────
    fish_add_path ~/.local/bin
    fish_add_path ~/.cargo/bin

    # ── Aliases ────────────────────────────────────────────────────────────────
    # System
    alias ll='ls -la --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -lh --color=auto'
    alias grep='grep --color=auto'
    alias df='df -h'
    alias du='du -h'
    alias free='free -h'
    alias ip='ip --color=auto'

    # Safety
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'

    # Navigation (zoxide handles most of this)
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ~='cd ~'

    # Editor
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'

    # Git (lazygit available)
    alias g='git'
    alias gs='git status'
    alias lg='lazygit'

    # Hyprland
    alias hypr-reload='hyprctl reload'
    alias hypr-info='hyprctl monitors && hyprctl workspaces'

    # DNF (Fedora)
    alias install='sudo dnf install -y'
    alias update='sudo dnf upgrade -y'
    alias search='dnf search'
    alias remove='sudo dnf remove -y'
    alias autoremove='sudo dnf autoremove -y'

    # systemd (RHCSA study)
    alias sc='systemctl'
    alias jc='journalctl'
    alias scu='systemctl --user'

    # NVIDIA quick check
    alias gpu='nvidia-smi --query-gpu=name,driver_version,temperature.gpu,utilization.gpu --format=csv,noheader'

    # ── Greeting ───────────────────────────────────────────────────────────────
    if type -q fastfetch
        fastfetch --logo-type small
    end
end
