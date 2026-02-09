#!/bin/bash

# Rofi меню для скриншотов
# Запускает cmd-screenshot.sh с нужными параметрами

SCRIPT_DIR="$(dirname "$0")"
CMD_SCREENSHOT="$SCRIPT_DIR/cmd-screenshot.sh"

# Меню с опциями скриншота
selection=$(printf "🖼 Весь экран\n🖱 Выделить область\n🪟 Выбрать окно\n📋 Весь экран в буфер\n📋🖱 Область в буфер" | rofi -dmenu -i -p "Меню скриншота" -theme ~/.config/rofi/screenshot.rasi)

case "$selection" in
  "🖼 Весь экран")
    sh "$CMD_SCREENSHOT" fullscreen
    ;;
  "🖱 Выделить область")
    sh "$CMD_SCREENSHOT" region
    ;;
  "🪟 Выбрать окно")
    sh "$CMD_SCREENSHOT" windows
    ;;
  "📋 Весь экран в буфер")
    sh "$CMD_SCREENSHOT" fullscreen clip
    ;;
  "📋🖱 Область в буфер")
    sh "$CMD_SCREENSHOT" region clip
    ;;
  *)
    exit 1
    ;;
esac
