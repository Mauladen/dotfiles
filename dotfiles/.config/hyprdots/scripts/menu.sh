#!/bin/bash

# Запускает меню или принимает параметр для перехода сразу в подменю.

# Устанавливается в true при прямом переходе в подменю, чтобы можно было сразу выйти
BACK_TO_EXIT=false

back_to() {
  local parent_menu="$1"

  if [[ "$BACK_TO_EXIT" == "true" ]]; then
    exit 0
  elif [[ -n "$parent_menu" ]]; then
    "$parent_menu"
  else
    show_main_menu
  fi
}

menu() {
  local prompt="$1"
  local options="$2"
  local extra="$3"
  local preselect="$4"

  read -r -a args <<<"$extra"

  if [[ -n "$preselect" ]]; then
    local index
    index=$(echo -e "$options" | grep -nxF "$preselect" | cut -d: -f1)
    if [[ -n "$index" ]]; then
      args+=("-c" "$index")
    fi
  fi

  echo -e "$options" | sh ~/.config/hyprdots/scripts/launch-walker.sh --dmenu --width 295 --minheight 1 --maxheight 630 -p "$prompt…" "${args[@]}" 2>/dev/null
}

show_screenshot_menu() {
  case $(menu "Скриншот" "  Снимок с редактированием\n  Сразу в буфер обмена") in
  *"Снимок с редактированием") sh ~/.config/hyprdots/scripts/cmd-screenshot.sh smart ;;
  *"Сразу в буфер обмена") sh ~/.config/hyprdots/scripts/cmd-screenshot.sh smart clipboard ;;
  *) show_main_menu ;;
  esac
}

get_webcam_list() {
  v4l2-ctl --list-devices 2>/dev/null | while IFS= read -r line; do
    if [[ "$line" != $'\t'* && -n "$line" ]]; then
      local name="$line"
      IFS= read -r device || break
      device=$(echo "$device" | tr -d '\t' | head -1)
      [[ -n "$device" ]] && echo "$device  $name"
    fi
  done
}

show_webcam_select_menu() {
  local devices=$(get_webcam_list)
  local count=$(echo "$devices" | grep -c . 2>/dev/null || echo 0)

  if [[ -z "$devices" || "$count" -eq 0 ]]; then
    notify-send "Устройства веб-камеры не найдены" -u critical -t 3000
    return 1
  fi

  if [[ "$count" -eq 1 ]]; then
    echo "$devices" | awk '{print $1}'
  else
    menu "Выберите веб-камеру" "$devices" | awk '{print $1}'
  fi
}

show_screenrecord_menu() {
  sh ~/.config/hyprdots/scripts/cmd-screenrecord.sh --stop-recording && exit 0

  case $(menu "Запись экрана" "  С системным звуком\n  С системным звуком + микрофоном\n  С системным звуком + микрофоном + веб-камерой") in
  *"С системным звуком") sh ~/.config/hyprdots/scripts/cmd-screenrecord.sh --with-desktop-audio ;;
  *"С системным звуком + микрофоном") sh ~/.config/hyprdots/scripts/cmd-screenrecord.sh --with-desktop-audio --with-microphone-audio ;;
  *"С системным звуком + микрофоном + веб-камерой")
    local device=$(show_webcam_select_menu) || { back_to show_main_menu; return; }
    sh ~/.config/hyprdots/scripts/cmd-screenrecord.sh --with-desktop-audio --with-microphone-audio --with-webcam --webcam-device="$device"
    ;;
  *) back_to show_main_menu ;;
  esac
}


show_main_menu() {
  go_to_menu "$(menu "Перейти" "󰀻  Приложения\n  Скриншот\n  Запись экрана")"
}

go_to_menu() {
  case "${1,,}" in
  *apps* | *приложения*) walker -p "Запустить…" ;;
  *screenshot* | *скриншот*) show_screenshot_menu ;;
  *screenrecord* | *запись\ экрана*) show_screenrecord_menu ;;
  esac
}

if [[ -n "$1" ]]; then
  BACK_TO_EXIT=true
  go_to_menu "$1"
else
  show_main_menu
fi
