---
name: project-setup-state
description: "Estado completo del sistema al 2026-05-18 — térmico, GitHub, dual boot Windows planeado"
metadata:
  node_type: memory
  type: project
  originSessionId: c6b60482-1b7d-4880-b7c4-09785527404f
---

Sistema completamente configurado al 2026-05-18.

**GitHub (2026-05-18):**
- Repo waydora pushed a https://github.com/jhamops/waydora (público). Username GitHub: `jhamops`.
- SSH a GitHub configurado vía `ssh.github.com:443` en `~/.ssh/config` — la red bloquea SSH port 22. Si futuro Claude prueba `ssh git@github.com:22` y falla, NO es problema de auth: es el firewall/ISP.
- SSH key local: `~/.ssh/id_ed25519` (ed25519).

**Dual boot Windows 11 planeado (2026-05-18):**
- Motivo: examen SAA-C03 vía Pearson VUE OnVUE (26 jun 2026) requiere Windows — OnVUE detecta VMs y rechaza, no hay alternativa.
- Plan: 100 GB para Windows en NVMe Micron 512GB (377 GB libres, btrfs). Shrink btrfs primero, instalar Win11, reparar GRUB desde USB Fedora Everything.
- Disco: GPT + UEFI + Secure Boot OFF (setup ideal). ESP de 600M compartido.
- Backup pre-particionado: pendiente subir tars a Drive (waydora ya en GitHub).

**Gestión térmica (2026-05-17):**
- Governor `powersave` persistente vía `/etc/systemd/system/cpu-powersave.service` (enabled). Idle baja de 95°C a ~70°C. Con `intel_pstate active`, `powersave` escala a turbo bajo carga.
- Usuario `JhamOps` en grupo `gamemode` — sin esto gamemode falla silencioso al cambiar governor (polkit rule en `/usr/share/polkit-1/rules.d/gamemode.rules` requiere el grupo).
- Dota 2 launch options en Steam: `SDL_AUDIODRIVER=pulse gamemoderun %command% -novid +snd_mute_losefocus 0`. Replicar `gamemoderun %command%` en futuros juegos (Lies of P, RE9).
- Flujo: idle → powersave; gamemoderun activa performance al jugar; al salir vuelve a powersave solo.

**Voicemode removido (2026-05-17):**
- Se probó voicemode oficial + Kokoro TTS + scripts caseros (voice-daemon.py, voice-session.sh para estudio AWS por voz con Alt+Z). Borrado completo: paquete uv, ~/.voicemode, plugin Claude, scripts en ~/.local/bin/, autostart y keybind de Hyprland. Liberados ~7.6 GB. No reinstalar — comía RAM/CPU sostenidamente con beneficio marginal.

**Repo waydora:** `~/setup-hyprland/` — GitHub: https://github.com/JhamOps/waydora (pendiente push inicial)

**Todo completado (sistema):**
- WiFi, audio, micrófono DMIC funcionando
- Hyprland 0.55.0 estable, config modular, documentado
- GNOME removido, SDDM habilitado
- Gaming: Steam, gamemode, gamescope, mangohud, Vulkan
- Waydroid 1.6.2 + GAPPS + libhoudini + 7DS Grand Cross corriendo
- Docker CE 29.5.0 instalado y activo
- Screenshots con notificaciones, cheat sheet SUPER+/
- vm.swappiness=10 persistente en /etc/sysctl.d/99-swappiness.conf

**Aplicaciones instaladas:**
- Antigravity (Google editor, repo RPM en /etc/yum.repos.d/antigravity.repo)
- Obsidian 1.12.7 — extraído en ~/Applications/squashfs-root/ (necesita --disable-gpu por NVIDIA)
- Anki — instalado desde tar.zst oficial
- fzf 0.70.0 instalado
- swww instalado (wallpaper daemon con transiciones)
- wob instalado (no se usa activamente, reemplazado por mako OSD)
- awscli instalado (pendiente configurar con cuenta AWS real)
- LocalStack configurado en ~/localstack/docker-compose.yml (alias: lsup/lsdown/aws-local)

**Wallpaper rotativo:**
- swww-daemon + wallpaper-cycle.sh (cada 30 min, en autostart.conf)
- Imágenes en ~/Pictures/Wallpapers/ (fist.jpg, second.png, thirnd.jpg)
- Comando manual: wallpaper-next.sh
- Scripts en ~/.local/bin/

**SDDM theme picker:**
- sddm-theme-picker en ~/.local/bin/ — usa fzf con preview kitty icat
- Tema actual: pixel_sakura_static
- 10 temas disponibles en /usr/share/sddm/themes/sddm-astronaut-theme/

**Volume OSD (estilo Apple/moderno):**
- Usa mako con notify-send + hint int:value para barra de progreso
- app-name=volume tiene estilo separado: top-center, border-radius=20, sin borde
- Keybindings actualizados en keybindings.conf (notify-send -a volume)
- Mako config: anchor=top-center, border-radius=16, sin borde, Tokyo Night

**Entorno de estudio SAA-C03:**
- Vault Obsidian: ~/Documents/SAA-Study/
- Notas creadas: EC2, EC2 Auto Scaling, ELB, EBS, EFS, Instance Store, Security Groups, IAM, CloudWatch
- Anki deck: ~/Documents/SAA-Study/anki-import.txt (87 tarjetas, separador tab) — pendiente reimportar
- Study Plan: ~/Documents/SAA-Study/00-Templates/Study Plan.md (actualizado con plan Cantrill 6 semanas)
- Curso: Adrian Cantrill SAA-C03 (9% completado al 2026-05-15)
- Práctica: Tutorials Dojo SAA-C03 (Jon Bonso) — pendiente comprar ($11.99 oferta vence ~May 18)
- Examen SAA: 26 de junio de 2026 (se puede aplazar hasta 24h antes sin costo via Pearson VUE)
- Meta a largo plazo: CloudOps — ruta SAA → SysOps → DevOps Professional

**Plan de estudio SAA (6 semanas):**
- Sem 1 (May 15-21): Fundamentals + IAM + inicio S3
- Sem 2 (May 22-28): S3 completo + VPC Basics
- Sem 3 (May 29-Jun 4): EC2 + Advanced EC2 + Route53
- Sem 4 (Jun 5-11): RDS + HA&Scaling + Serverless
- Sem 5 (Jun 12-18): CloudFront + Advanced VPC + Hybrid + Security + CFN + DynamoDB + ML
- Sem 6 (Jun 19-25): Solo Tutorials Dojo — si +75% consistente → va el 26, sino aplazar
- Rutina: 90 min Cantrill + 15 min Anki diario

**Pendiente:**
- Reimportar Anki deck correctamente (usar anki-import.txt con tab separator)
- Comprar Tutorials Dojo antes del ~May 18 (oferta $11.99)
- Proton-GE (cuando compre Lies of P o RE9)
- awscli configurar con cuenta AWS real
- Notas Obsidian pendientes: S3, VPC, RDS, Lambda, SQS, SNS, Route53, DynamoDB, CloudFront
- lazygit, zoxide (productividad terminal)
