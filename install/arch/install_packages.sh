# -----------------------------------------------------
# Установка пакетов
# -----------------------------------------------------

packages=(
  # Поддержка Wayland и библиотеки
  qt5-wayland              # Плагин платформы Wayland для Qt5
  qt6-wayland              # Плагин платформы Wayland для Qt6
  gtk4                     # Библиотека GTK4
  wl-clipboard             # Утилиты командной строки для копирования/вставки в Wayland

  # Аудио (стек PipeWire)
  pipewire                 # Аудио/видео сервер с низкой задержкой
  pipewire-alsa            # Плагин ALSA для PipeWire
  pipewire-audio           # Аудио демон PipeWire
  pipewire-jack            # Плагин JACK для PipeWire
  pipewire-pulse           # Замена PulseAudio для PipeWire
  wireplumber              # Менеджер сессий для PipeWire

  # Сеть и Bluetooth
  networkmanager           # Демон управления сетью
  network-manager-applet   # Апплет NetworkManager для панели
  bluez                    # Демон Bluetooth
  bluez-utils              # Утилиты Bluetooth
  blueman                  # Графический менеджер Bluetooth

  # Оболочка
  zsh                      # Оболочка Z shell

  # Оконный менеджер и окружение рабочего стола
  hyprland                 # Динамический тайлинговый композитор Wayland
  hypridle                 # Менеджер бездействия для Hyprland
  waybar                   # Панель задач для Wayland (Hyprland, Sway)
  rofi-wayland             # Запуск приложений для Wayland
  hyprlock                 # Блокировщик экрана для Hyprland

  # Терминал
  ghostty                  # Современный эмулятор терминала

  # Уведомления и интеграция рабочего стола
  swaync                   # Центр уведомлений для Wayland
  xdg-desktop-portal-hyprland # XDG портал для Hyprland
  xdg-desktop-portal-gtk   # XDG портал для GTK

  # Обои и визуальные эффекты
  swww                     # Демон анимированных обоев для Wayland

  # Системная информация и мониторинг
  fastfetch                # Утилита вроде neofetch, но быстрее
  btop                     # Мониторинг ресурсов системы

  # Захват экрана и скриншоты
  grim                     # Утилита скриншотов для Wayland
  slurp                    # Инструмент выделения для grim
  satty                    # Редактор скриншотов
  gpu-screen-recorder      # Запись экрана
  imagemagick              # Набор инструментов для работы с изображениями

  # Управление аудио
  pamixer                  # Микшер PulseAudio для командной строки
  pavucontrol              # Графическое управление громкостью PulseAudio

  # Файловый менеджер
  thunar                   # Современный файловый менеджер из Xfce
  gvfs                     # Виртуальная файловая система GNOME (backend для thunar)
  thunar-archive-plugin    # Плагин архивов для Thunar
  file-roller              # Менеджер архивов из GNOME

  # Шрифты
  ttf-jetbrains-mono       # Шрифт JetBrains Mono
  ttf-jetbrains-mono-nerd  # JetBrains Mono с иконками Nerd Font
  noto-fonts-emoji        # Цветные эмодзи шрифты Noto от Google

  # Темы и оформление
  tela-circle-icon-theme-dracula # Dracula иконки
  nwg-look                 # Редактор настроек GTK3 для Wayland
  kvantum                  # Движок тем на основе SVG для Qt
  adw-gtk-theme            # Тема Adwaita для GTK3 и GTK4

  # Приложения
  telegram-desktop         # Мессенджер Telegram
  qbittorrent              # BitTorrent клиент
  obsidian                 # Приложение для заметок
  zed                      # Редактор кода от Zed Industries

  # Утилиты оболочки
  eza                      # Современная замена для ls
  dex                      # Инструмент для запуска приложений из .desktop файлов
  tmux                     # Мультиплексор терминала
  fzf                      # Нечёткий поиск для командной строки
  zoxide                   # Умная команда cd
  atuin                    # Менеджер истории оболочки
  bat                      # Клон cat с подсветкой синтаксиса

  # Системные утилиты
  hyprpolkitagent          # Polkit агент для Hyprland
  pacman-contrib           # Вспомогательные скрипты для pacman
)

packages_aur=(
  # Темы и оформление
  bibata-cursor-theme-bin  # Современная тема курсоров

  # Экосистема Hyprland
  hyprland-preview-share-picker-git # Утилита для шаринга окон в Hyprland

  # Приложения
  vkteams-bin              # Мессенджер VK Teams
  google-chrome            # Браузер Google Chrome
  claude-code              # Агентный ИИ-инструмент для программирования в терминале от Anthropic
  openai-codex-bin         # ИИ-агент для программирования от OpenAI, запускается локально в терминале

  # Системные утилиты
  hunspell-ru              # Русская проверка орфографии для Hunspell
  throne-bin               # VPN клиент
  wlogout                  # Меню выхода из системы для Wayland
  wayfreeze-git            # Tool to freeze the screen of a Wayland compositor
)

_installPackages "${packages[@]}"
_installPackagesYay "${packages_aur[@]}"
