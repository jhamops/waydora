#!/usr/bin/env bash
# Shows keybindings cheat sheet in a floating kitty window

cat << 'EOF'
╔══════════════════════════════════════════════════════════╗
║              HYPRLAND KEYBINDINGS — CHEAT SHEET          ║
╠══════════════════════════════════════════════════════════╣
║  SESIÓN                                                  ║
║  SUPER + SHIFT + Q    Salir de Hyprland                  ║
║  SUPER + L            Bloquear pantalla                  ║
║  SUPER + SHIFT + R    Recargar config                    ║
║  SUPER + /            Este cheat sheet                   ║
╠══════════════════════════════════════════════════════════╣
║  APPS                                                    ║
║  SUPER + ENTER        Terminal (Kitty)                   ║
║  SUPER + ALT + ENTER  Terminal con Tmux                  ║
║  SUPER + SHIFT+ENTER  Navegador (Chromium)               ║
║  SUPER + SHIFT + F    Gestor de archivos                 ║
║  SUPER + SHIFT + N    Neovim                             ║
║  SUPER + SHIFT + M    Música (cmus)                      ║
║  SUPER + D            Lanzador de apps (Wofi)            ║
║  SUPER + V            Historial portapapeles             ║
╠══════════════════════════════════════════════════════════╣
║  CAPTURAS                                                ║
║  Print                Pantalla completa → archivo        ║
║  SHIFT + Print        Selección → archivo                ║
║  CTRL + Print         Selección → portapapeles           ║
╠══════════════════════════════════════════════════════════╣
║  VENTANAS                                                ║
║  SUPER + Q            Cerrar ventana                     ║
║  SUPER + F            Pantalla completa                  ║
║  SUPER + ALT + F      Pantalla completa (sin barra)      ║
║  SUPER + SHIFT+SPACE  Flotante / tiling                  ║
║  SUPER + T            Dividir ventana (togglesplit)      ║
║  SUPER + P            Pseudo-tiling                      ║
╠══════════════════════════════════════════════════════════╣
║  FOCO (vim + flechas)                                    ║
║  SUPER + H / ←        Foco izquierda                    ║
║  SUPER + J / ↓        Foco abajo                        ║
║  SUPER + K / ↑        Foco arriba                       ║
║  SUPER + L / →  [ver nota]  Foco derecha (solo flechas) ║
╠══════════════════════════════════════════════════════════╣
║  MOVER VENTANAS                                          ║
║  SUPER + SHIFT + H    Mover ventana izquierda            ║
║  SUPER + SHIFT + J    Mover ventana abajo                ║
║  SUPER + SHIFT + K    Mover ventana arriba               ║
║  SUPER + SHIFT + L    Mover ventana derecha              ║
║  SUPER + click izq    Arrastrar ventana                  ║
║  SUPER + click der    Redimensionar con mouse            ║
╠══════════════════════════════════════════════════════════╣
║  REDIMENSIONAR                                           ║
║  SUPER + CTRL + H     Encoger izquierda                  ║
║  SUPER + CTRL + L     Expandir derecha                   ║
║  SUPER + CTRL + K     Encoger arriba                     ║
║  SUPER + CTRL + J     Expandir abajo                     ║
╠══════════════════════════════════════════════════════════╣
║  WORKSPACES                                              ║
║  SUPER + 1…6          Ir al workspace                   ║
║  SUPER + SHIFT + 1…6  Mover ventana al workspace        ║
║  SUPER + ALT + 1…6    Mover ventana (sin seguirla)      ║
║  SUPER + TAB          Workspace siguiente                ║
║  SUPER + SHIFT + TAB  Workspace anterior                 ║
║  SUPER + scroll       Navegar workspaces                 ║
╠══════════════════════════════════════════════════════════╣
║  LAYOUT DE WORKSPACES                                    ║
║  1 Browser/AWS   2 Docs        3 Terminal                ║
║  4 Comunicación  5 Multimedia  6 Gaming                  ║
╠══════════════════════════════════════════════════════════╣
║  MEDIA / BRILLO (teclas Fn del laptop)                   ║
║  Vol+ / Vol-          Volumen ±5%                        ║
║  Mute                 Silenciar                          ║
║  Play/Prev/Next       Controlar reproducción             ║
║  Brillo+ / Brillo-    Brillo de pantalla                 ║
╚══════════════════════════════════════════════════════════╝

  Presiona Q para cerrar
EOF

read -n1 -r
