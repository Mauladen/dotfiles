#!/bin/bash

# Walker меню для записи экрана
# Запускает cmd-screenrecord.sh с нужными флагами

SCRIPT_DIR="$(dirname "$0")"
CMD_RECORD="$SCRIPT_DIR/cmd-screenrecord.sh"

# Ensure elephant is running before launching walker
if ! pgrep -x elephant > /dev/null; then
  setsid elephant &
fi

# Ensure walker service is running
if ! pgrep -f "walker --gapplication-service" > /dev/null; then
  setsid walker --gapplication-service &
fi

# Если запись уже идёт — предлагаем остановить
if pgrep -f "^gpu-screen-recorder" >/dev/null; then
  selection=$(printf "⏹ Остановить запись" | walker --dmenu --width 644 --maxheight 300 --minheight 300)
  case "$selection" in
    "⏹ Остановить запись")
      sh "$CMD_RECORD" --stop-recording
      ;;
  esac
  exit 0
fi

# Меню с опциями записи через walker dmenu
selection=$(printf "🎥 Начать запись\n🎤 С микрофоном\n🔊 С звуком системы\n🎤🔊 С микрофоном и звуком\n📷 С вебкамерой\n🎤📷 С микрофоном и камерой" | walker --dmenu --width 644 --maxheight 300 --minheight 300)

case "$selection" in
  "🎥 Начать запись")
    sh "$CMD_RECORD"
    ;;
  "🎤 С микрофоном")
    sh "$CMD_RECORD" --with-microphone-audio
    ;;
  "🔊 С звуком системы")
    sh "$CMD_RECORD" --with-desktop-audio
    ;;
  "🎤🔊 С микрофоном и звуком")
    sh "$CMD_RECORD" --with-microphone-audio --with-desktop-audio
    ;;
  "📷 С вебкамерой")
    sh "$CMD_RECORD" --with-webcam
    ;;
  "🎤📷 С микрофоном и камерой")
    sh "$CMD_RECORD" --with-microphone-audio --with-webcam
    ;;
  *)
    exit 1
    ;;
esac
