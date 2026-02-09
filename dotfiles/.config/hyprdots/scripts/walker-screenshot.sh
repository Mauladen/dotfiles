#!/bin/bash

# Walker меню для скриншотов
# Запускает cmd-screenshot.sh с нужными параметрами

SCRIPT_DIR="$(dirname "$0")"
CMD_SCREENSHOT="$SCRIPT_DIR/cmd-screenshot.sh"

# Ensure elephant is running before launching walker
if ! pgrep -x elephant > /dev/null; then
  setsid elephant &
fi

# Ensure walker service is running
if ! pgrep -f "walker --gapplication-service" > /dev/null; then
  setsid walker --gapplication-service &
fi

# Меню с опциями скриншота через walker dmenu
selection=$(printf "🖼 Весь экран\n🖱 Выделить область\n🪟 Выбрать окно\n📋 Весь экран в буфер\n📋🖱 Область в буфер" | walker --dmenu --width 644 --maxheight 300 --minheight 300)

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
