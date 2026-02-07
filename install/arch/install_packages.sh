# -----------------------------------------------------
# Установка пакетов
# -----------------------------------------------------

packages=(
  # Wayland support & libraries
  qt5-wayland              # Qt5 Wayland platform plugin
  qt6-wayland              # Qt6 Wayland platform plugin
  gtk4                     # GTK4 library
  wl-clipboard             # Command-line copy/paste utilities for Wayland

  # Audio (PipeWire stack)
  pipewire                 # Low-latency audio/video server
  pipewire-alsa            # PipeWire ALSA plugin
  pipewire-audio           # PipeWire audio daemon
  pipewire-jack            # PipeWire JACK plugin
  pipewire-pulse           # PipeWire PulseAudio replacement
  wireplumber              # Session manager for PipeWire

  # Network & Bluetooth
  networkmanager           # Network management daemon
  network-manager-applet   # NetworkManager panel applet
  bluez                    # Bluetooth daemon
  bluez-utils              # Bluetooth utilities
  blueman                  # Bluetooth manager GUI

  # Shell
  zsh                      # Z shell

  # Window Manager & Desktop Environment
  hyprland                 # Dynamic tiling Wayland compositor
  hypridle                 # Idle manager for Hyprland
  waybar                   # Wayland bar for Hyprland and Sway
  rofi-wayland             # Application launcher for Wayland
  hyprlock                 # Screen locker for Hyprland

  # Terminal
  ghostty                  # Modern terminal emulator

  # Notifications & Desktop integration
  swaync                   # Notification center for Wayland
  xdg-desktop-portal-hyprland # XDG desktop portal for Hyprland
  xdg-desktop-portal-gtk   # XDG desktop portal for GTK

  # Wallpaper & visual effects
  swww                     # Efficient animated wallpaper daemon for Wayland

  # System information & monitoring
  fastfetch                # Neofetch-like tool, faster and more accurate
  btop                     # Resource monitor

  # Screen capture & screenshots
  grim                     # Screenshot utility for Wayland
  slurp                    # Selection tool for grim
  swappy                   # Snapshot editing tool
  wf-recorder              # Screen recorder for Wayland
  imagemagick              # Image manipulation toolset

  # Audio control
  pamixer                  # PulseAudio command-line mixer
  pavucontrol              # PulseAudio volume control GUI

  # File manager
  thunar                   # Modern file manager for Xfce
  gvfs                     # GNOME Virtual File System (backend for thunar)
  thunar-archive-plugin    # Archive plugin for Thunar
  file-roller              # Archive manager for GNOME

  # Fonts
  ttf-jetbrains-mono       # JetBrains Mono font
  ttf-jetbrains-mono-nerd  # JetBrains Mono with Nerd Font icons
  noto-fonts-emoji        # Google Noto color emoji font

  # Themes & appearance
  tela-circle-icon-theme-dracula # Dracula icon theme
  nwg-look                 # GTK3 settings editor for Wayland
  kvantum                  # SVG-based theme engine for Qt
  adw-gtk-theme            # Adwaita theme for GTK3 and GTK4

  # Applications
  telegram-desktop         # Telegram messenger
  qbittorrent              # BitTorrent client
  obsidian                 # Note-taking application
  zed                      # Code editor by Zed Industries

  # Shell utilities
  eza                      # Modern replacement for ls
  dex                      # Tool to execute applications from XDG desktop entries
  tmux                     # Terminal multiplexer
  fzf                      # Command-line fuzzy finder
  zoxide                   # Smart cd command
  atuin                    # Shell history manager
  bat                      # cat clone with syntax highlighting

  # System utilities
  hyprpolkitagent          # Polkit agent for Hyprland
  pacman-contrib           # Helper scripts for pacman
)

packages_aur=(
  # Themes & appearance
  bibata-cursor-theme-bin  # Modern cursor theme

  # Hyprland ecosystem
  hyprland-preview-share-picker-git # Utility for sharing windows in Hyprland

  # Development tools
  fnm-bin                  # Fast Node Manager

  # Applications
  vkteams-bin              # VK Teams messenger
  google-chrome            # Google Chrome browser
  claude-code              # TODO: verify - Claude Code AI assistant
  openai-codex-bin         # TODO: verify - OpenAI Codex integration

  # System utilities
  hunspell-ru              # Russian spell checker for Hunspell
  throne-bin               # TODO: verify - throne application
  wlogout                  # Logout menu for Wayland
)

_installPackages "${packages[@]}"
_installPackagesYay "${packages_aur[@]}"
