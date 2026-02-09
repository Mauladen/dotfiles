#!/bin/bash

# Rofi меню для записи экрана
# Запускает cmd-screenrecord.sh с нужными флагами

SCRIPT_DIR="$(dirname "$0")"
CMD_RECORD="$SCRIPT_DIR/cmd-screenrecord.sh"

# Если запись уже идёт — предлагаем остановить
if pgrep -f "^gpu-screen-recorder" >/dev/null; then
  selection=$(printf "⏹ Остановить запись" | rofi -dmenu -i -p "Запись экрана" -theme ~/.config/rofi/record.rasi)
  case "$selection" in
    "⏹ Остановить запись")
     sh "$CMD_RECORD" --stop-recording
      ;;
  esac
  exit 0
fi

# Меню с опциями записи (gpu-screen-recorder сам покажет выбор области через portal)
selection=$(printf "🎥 Начать запись\n🎤 С микрофоном\n🔊 С звуком системы\n🎤🔊 С микрофоном и звуком\n📷 С вебкамерой\n🎤📷 С микрофоном и камерой" | rofi -dmenu -i -p "Меню записи экрана" -theme ~/.config/rofi/record.rasi)

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
