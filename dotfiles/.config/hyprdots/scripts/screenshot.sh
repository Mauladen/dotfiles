#!/bin/bash

selection=$(printf "Весь экран\nВыделенная область\nАктивный монитор" | rofi -dmenu -i -p "Создание скриншота" -theme ~/.config/rofi/screenshot.rasi)

generate_filename() {
  local dir="$HOME/Изображения"
  mkdir -p "$dir" || { notify-send "Ошибка" "Не удалось создать директорию $dir"; exit 1; }
  echo "$dir/screenshot_$(date +%Y%m%d_%H%M%S).png"
}

send_notification() {
  local file_path="$1"
  notify-send "📸 Скриншот сохранен: " "$file_path" \
    --icon="$file_path" \
    --hint=int:transient:1
}

case "$selection" in
"Весь экран")
  file_path=$(generate_filename)
  grim "$file_path" || { notify-send "Ошибка" "Не удалось создать скриншот"; exit 1; }
  swappy -f "$file_path" -o "$file_path" || { notify-send "Ошибка" "Не удалось отредактировать скриншот"; rm -f "$file_path"; exit 1; }
  ;;
"Выделенная область")
  file_path=$(generate_filename)
  grim -g "$(slurp)" "$file_path" || { notify-send "Ошибка" "Не удалось создать скриншот"; exit 1; }
  swappy -f "$file_path" -o "$file_path" || { notify-send "Ошибка" "Не удалось отредактировать скриншот"; rm -f "$file_path"; exit 1; }
  ;;
"Активный монитор")
  active_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"')
  if [ -n "$active_monitor" ]; then
    file_path=$(generate_filename)
    grim -g "$active_monitor" "$file_path" || { notify-send "Ошибка" "Не удалось создать скриншот"; exit 1; }
    swappy -f "$file_path" -o "$file_path" || { notify-send "Ошибка" "Не удалось отредактировать скриншот"; rm -f "$file_path"; exit 1; }
  else
    notify-send "Ошибка" "Не найден активный монитор"
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
