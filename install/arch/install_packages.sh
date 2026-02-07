# -----------------------------------------------------
# Установка пакетов
# -----------------------------------------------------

packages=(
  qt5-wayland
  qt6-wayland
  gtk4
  wl-clipboard
  cliphist
  pipewire
  pipewire-alsa
  pipewire-audio
  pipewire-jack
  pipewire-pulse
  wireplumber
  networkmanager
  network-manager-applet
  bluez
  bluez-utils
  blueman
  zsh
  hyprland
  hypridle
  waybar
  rofi-wayland
  hyprlock
  ghostty
  swaync
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  swww
  fastfetch
  swappy
  grim
  slurp
  btop
  imagemagick
  pamixer
  pavucontrol
  thunar
  gvfs
  thunar-archive-plugin
  file-roller
  ttf-jetbrains-mono
  ttf-jetbrains-mono-nerd
  noto-fonts-emoji
  tela-circle-icon-theme-dracula
  nwg-look
  kvantum
  telegram-desktop
  qbittorrent
  obsidian
  eza
  dex
  wf-recorder
  hyprpolkitagent
  pacman-contrib
  tmux
  fzf
  zoxide
  atuin
  zed
  adw-gtk-theme
  bat
)

packages_aur=(
  bibata-cursor-theme-bin
  hyprland-preview-share-picker-git
  fnm-bin
  vkteams-bin
  hunspell-ru
  throne-bin
  google-chrome
  claude-code
  openai-codex-bin
  wlogout
)

_installPackages "${packages[@]}"
_installPackagesYay "${packages_aur[@]}"
