#!/bin/bash

# Запускает и останавливает запись экрана, которая по умолчанию сохраняется в ~/Videos.
# Альтернативный путь можно задать через переменную XDG_VIDEOS_DIR.

OUTPUT_DIR="${XDG_VIDEOS_DIR:-$HOME/Videos}"

if [[ ! -d "$OUTPUT_DIR" ]]; then
  notify-send "Каталог для записи экрана не существует: $OUTPUT_DIR" -u critical -t 3000
  exit 1
fi

DESKTOP_AUDIO="false"
MICROPHONE_AUDIO="false"
WEBCAM="false"
WEBCAM_DEVICE=""
STOP_RECORDING="false"

for arg in "$@"; do
  case "$arg" in
    --with-desktop-audio) DESKTOP_AUDIO="true" ;;
    --with-microphone-audio) MICROPHONE_AUDIO="true" ;;
    --with-webcam) WEBCAM="true" ;;
    --webcam-device=*) WEBCAM_DEVICE="${arg#*=}" ;;
    --stop-recording) STOP_RECORDING="true"
  esac
done

cleanup_webcam() {
  pkill -f "WebcamOverlay" 2>/dev/null
}

start_webcam_overlay() {
  cleanup_webcam

  # Автоматически определяем первую доступную веб-камеру, если устройство не указано
  if [[ -z "$WEBCAM_DEVICE" ]]; then
    WEBCAM_DEVICE=$(v4l2-ctl --list-devices 2>/dev/null | grep -m1 "^\s*/dev/video" | tr -d '\t')
    if [[ -z "$WEBCAM_DEVICE" ]]; then
      notify-send "Устройства веб-камеры не найдены" -u critical -t 3000
      return 1
    fi
  fi

  # Получаем масштаб монитора
  local scale=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .scale')

  # Целевая ширина (база 360px, масштабируется под монитор)
  local target_width=$(awk "BEGIN {printf \"%.0f\", 360 * $scale}")

  # Пробуем предпочтительные разрешения 16:9 по порядку и берем первое доступное
  local preferred_resolutions=("640x360" "1280x720" "1920x1080")
  local video_size_arg=""
  local available_formats=$(v4l2-ctl --list-formats-ext -d "$WEBCAM_DEVICE" 2>/dev/null)

  for resolution in "${preferred_resolutions[@]}"; do
    if echo "$available_formats" | grep -q "$resolution"; then
      video_size_arg="-video_size $resolution"
      break
    fi
  done

  ffplay -f v4l2 $video_size_arg -framerate 30 "$WEBCAM_DEVICE" \
    -vf "scale=${target_width}:-1" \
    -window_title "WebcamOverlay" \
    -noborder \
    -fflags nobuffer -flags low_delay \
    -probesize 32 -analyzeduration 0 \
    -loglevel quiet &
  sleep 1
}

start_screenrecording() {
  local filename="$OUTPUT_DIR/screenrecording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"
  local audio_devices=""
  local audio_args=""

  [[ "$DESKTOP_AUDIO" == "true" ]] && audio_devices+="default_output"

  if [[ "$MICROPHONE_AUDIO" == "true" ]]; then
    # Объединяем аудиодорожки в одну: отдельные дорожки во многих плеерах проигрываются по одной
    [[ -n "$audio_devices" ]] && audio_devices+="|"
    audio_devices+="default_input"
  fi

  [[ -n "$audio_devices" ]] && audio_args+="-a $audio_devices"

  gpu-screen-recorder -w portal -f 60 -fallback-cpu-encoding yes -o "$filename" $audio_args -ac aac &
  toggle_screenrecording_indicator
}

stop_screenrecording() {
  pkill -SIGINT -f "^gpu-screen-recorder"  # SIGINT нужен для корректного сохранения видео

  # Ждем завершения максимум 5 секунд перед принудительным завершением
  local count=0
  while pgrep -f "^gpu-screen-recorder" >/dev/null && [ $count -lt 50 ]; do
    sleep 0.1
    count=$((count + 1))
  done

  if pgrep -f "^gpu-screen-recorder" >/dev/null; then
    pkill -9 -f "^gpu-screen-recorder"
    cleanup_webcam
    notify-send "Ошибка записи экрана" "Процесс записи пришлось завершить принудительно. Видео может быть повреждено." -u critical -t 5000
  else
    cleanup_webcam
    notify-send "Запись экрана сохранена в $OUTPUT_DIR" -t 2000
  fi
  toggle_screenrecording_indicator
}

toggle_screenrecording_indicator() {
  pkill -RTMIN+8 waybar
}

screenrecording_active() {
  pgrep -f "^gpu-screen-recorder" >/dev/null || pgrep -f "WebcamOverlay" >/dev/null
}

if screenrecording_active; then
  if pgrep -f "WebcamOverlay" >/dev/null && ! pgrep -f "^gpu-screen-recorder" >/dev/null; then
    cleanup_webcam
  else
    stop_screenrecording
  fi
elif [[ "$STOP_RECORDING" == "false" ]]; then
  [[ "$WEBCAM" == "true" ]] && start_webcam_overlay

  start_screenrecording || cleanup_webcam
else
  exit 1
fi
