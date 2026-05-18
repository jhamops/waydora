# Claude Bootstrap — Contexto para futuro Claude

Si llegaste aquí en un chat nuevo (laptop reinstalada, máquina diferente, sesión sin memoria local), este README te pone al día.

## Usuario

**JhamOps** (GitHub: [`jhamops`](https://github.com/jhamops))

Cloud engineer en formación. Hardware actual: MSI laptop con NVIDIA RTX 4050 sobre Fedora 44 (Everything) + Hyprland en estilo Omarchy.

Meta inmediata: examen **AWS SAA-C03** el **26 jun 2026** via Pearson VUE OnVUE. Por eso se planeó dual boot Windows 11 (OnVUE rechaza VMs).

## Cómo colaborar con JhamOps

Leé `memory/feedback_collaboration.md` — pero el resumen es:

- **Explicá el por qué** antes/después de cada acción. No es copia-pega, quiere entender.
- **Las ideas y decisiones son suyas**. La ejecución técnica es la parte mecánica. No te atribuyas el mérito de su visión.
- Cuestiona cuando algo le parece raro. Acepta correcciones. Reconoce cuando entiende.

## Memoria persistente

Los 4 archivos en `memory/` son el "estado mental" de Claude sobre este proyecto:

| Archivo | Qué contiene |
|---|---|
| `MEMORY.md` | Índice — empieza por aquí |
| `user_profile.md` | Perfil de JhamOps: rol, hardware, stack, preferences |
| `project_setup_state.md` | Estado completo del sistema: setup Omarchy, gestión térmica, GitHub, dual boot planeado, pendientes |
| `feedback_collaboration.md` | Cómo prefiere trabajar con Claude |

## Cómo restaurar este contexto en una máquina nueva

```bash
# 1. Clonar waydora (el "cómo" técnico del sistema)
git clone git@github.com:jhamops/waydora.git ~/setup-hyprland

# 2. Restaurar memoria persistente para Claude Code
mkdir -p ~/.claude/projects/-home-JhamOps/memory/
cp ~/setup-hyprland/claude/memory/*.md ~/.claude/projects/-home-JhamOps/memory/

# 3. Reconstruir Fedora desde cero (si es laptop nueva)
cd ~/setup-hyprland
bash phase1-system.sh   # repos, paquetes base
bash phase2-hyprland.sh # Hyprland + look Omarchy
bash phase3-gaming.sh   # Steam, gamemode, gamescope
bash phase4-cleanup.sh
bash install-dotfiles.sh

# 4. SSH a GitHub (si está bloqueado el port 22):
cat >> ~/.ssh/config << 'EOF'

Host github.com
    Hostname ssh.github.com
    Port 443
    User git
EOF
```

## Cosas no obvias que mordieron en sesiones pasadas

- **Gamemode falla silenciosamente** si el usuario no está en grupo `gamemode`. Polkit rule (`/usr/share/polkit-1/rules.d/gamemode.rules`) requiere membresía.
- **Governor `performance` por defecto en Fedora**: con `intel_pstate active`, lleva chasis a 95°C en idle. Cambiar a `powersave` baja ~20°C sin perder rendimiento (turbo sigue activo bajo carga).
- **SSH a `github.com:22` timeout**: red de JhamOps bloquea SSH outbound. Usar `ssh.github.com:443`.
- **OnVUE detecta VMs** y rechaza el examen — no es opción, solo dual boot real.
- **Voicemode + Kokoro fueron probados y removidos**: comían CPU/RAM sostenidamente con beneficio marginal. No reinstalar.

## Sincronizar cambios a memoria

Cuando Claude actualice un `.md` en `~/.claude/projects/-home-JhamOps/memory/`, para subirlo aquí:

```bash
cp ~/.claude/projects/-home-JhamOps/memory/*.md ~/setup-hyprland/claude/memory/
cd ~/setup-hyprland
git add claude/memory/ && git commit -m "Update memory: <qué cambió>" && git push
```
