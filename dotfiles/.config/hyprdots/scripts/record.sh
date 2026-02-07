#!/bin/bash

if pidof wf-recorder >/dev/null; then
  # Получаем имя файла из процесса wf-recorder
  recording_file=$(ps aux | grep "[w]f-recorder" | grep -o '/.*\.mp4')
  # Останавливаем запись
  killall -s SIGINT wf-recorder
  # Отправляем уведомление с путем к файлу
  notify-send "🎥 Запись сохранена: " "$recording_file" \
    --icon="video-x-generic" \
    --hint=int:transient:1
  exit 0
fi

selection=$(printf "Весь экран\nВыделенная область\nАктивный монитор" | rofi -dmenu -i -p "Меню записи экрана" -theme ~/.config/rofi/record.rasi)

generate_filename() {
  local dir="$HOME/Видео"
  mkdir -p "$dir"
  echo "$dir/screencast_$(date +%Y%m%d_%H%M%S).mp4"
}

send_notification() {
  local file_path="$1"
  notify-send "🎥 Запись начата" "Для остановки записи запустите скрипт повторно" \
    --hint=int:transient:1
}

start_recording() {
  local geometry="$1"
  local output="$2"
  if [ -n "$geometry" ]; then
    wf-recorder -g "$geometry" -f "$output" &
  else
    wf-recorder -f "$output" &
  fi
}

case "$selection" in
"Весь экран")
  file_path=$(generate_filename)
  start_recording "" "$file_path"
  ;;
"Выделенная область")
  file_path=$(generate_filename)
  geometry=$(slurp)
  if [ -z "$geometry" ]; then
    exit 1
  fi
  start_recording "$geometry" "$file_path"
  ;;
"Активный монитор")
  active_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"')
  if [ -n "$active_monitor" ]; then
    file_path=$(generate_filename)
    start_recording "$active_monitor" "$file_path"
  else
    notify-send "Не найден активный монитор"
    exit 1
  fi
  ;;
*)
  exit 1
  ;;
esac

if [ -n "$file_path" ]; then
  send_notification "$file_path"
fi
