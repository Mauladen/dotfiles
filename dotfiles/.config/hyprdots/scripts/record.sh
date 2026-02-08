#!/bin/bash

STATUS_FILE="/tmp/wf-recorder-status"

# Функция остановки записи
stop_recording() {
  # Получаем имя файла из файла статуса
  if [ -f "$STATUS_FILE" ]; then
    recording_file=$(cat "$STATUS_FILE")
  else
    # Fallback: пытаемся получить из процесса
    recording_file=$(ps aux | grep "[w]f-recorder" | grep -o '/.*\.mp4' | head -1)
  fi

  # Останавливаем запись
  killall -s SIGINT wf-recorder 2>/dev/null

  # Удаляем файл статуса
  rm -f "$STATUS_FILE"

  # Ждем завершения процесса
  sleep 0.5

  # Проверяем, что файл создан
  if [ -n "$recording_file" ] && [ -f "$recording_file" ]; then
    notify-send "🎥 Запись сохранена" "$recording_file" \
      --icon="video-x-generic" \
      --hint=int:transient:1
  else
    notify-send "Ошибка" "Не удалось сохранить запись" \
      --icon="dialog-error" \
      --hint=int:transient:1
  fi
  exit 0
}

# Если запись уже идет - останавливаем
if pidof wf-recorder >/dev/null; then
  stop_recording
fi

selection=$(printf "Весь экран\nВыделенная область\nАктивный монитор" | rofi -dmenu -i -p "Меню записи экрана" -theme ~/.config/rofi/record.rasi)

# Если пользователь отменил выбор
if [ -z "$selection" ]; then
  exit 1
fi

generate_filename() {
  local dir="$HOME/Видео"
  mkdir -p "$dir" || { notify-send "Ошибка" "Не удалось создать директорию $dir"; exit 1; }
  echo "$dir/screencast_$(date +%Y%m%d_%H%M%S).mp4"
}

start_recording() {
  local geometry="$1"
  local output="$2"

  # Сохраняем путь к файлу в статус-файл
  echo "$output" > "$STATUS_FILE"

  if [ -n "$geometry" ]; then
    wf-recorder -g "$geometry" -f "$output" &
  else
    wf-recorder -f "$output" &
  fi

  # Проверяем, что процесс запустился
  sleep 0.5
  if ! pidof wf-recorder >/dev/null; then
    notify-send "Ошибка" "Не удалось начать запись" \
      --icon="dialog-error" \
      --hint=int:transient:1
    rm -f "$STATUS_FILE"
    exit 1
  fi
}

case "$selection" in
"Весь экран")
  file_path=$(generate_filename)
  start_recording "" "$file_path"
  ;;
"Выделенная область")
  geometry=$(slurp)
  if [ -z "$geometry" ]; then
    notify-send "Отменено" "Область не выбрана"
    exit 1
  fi
  file_path=$(generate_filename)
  start_recording "$geometry" "$file_path"
  ;;
"Активный монитор")
  active_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"')
  if [ -z "$active_monitor" ]; then
    notify-send "Ошибка" "Не найден активный монитор"
    exit 1
  fi
  file_path=$(generate_filename)
  start_recording "$active_monitor" "$file_path"
  ;;
*)
  exit 1
  ;;
esac

if [ -n "$file_path" ]; then
  notify-send "🎥 Запись начата" "Нажмите ⏺ REC в waybar для остановки" \
    --hint=int:transient:1
fi
