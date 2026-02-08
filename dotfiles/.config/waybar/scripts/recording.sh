#!/bin/bash

# Скрипт для отображения статуса записи в waybar

STATUS_FILE="/tmp/wf-recorder-status"

if pidof wf-recorder >/dev/null; then
  # Запись активна
  if [ -f "$STATUS_FILE" ]; then
    recording_file=$(cat "$STATUS_FILE")
    tooltip="Нажмите для остановки записи\nФайл: $recording_file"
  else
    tooltip="Нажмите для остановки записи"
  fi

  # Вывод JSON для waybar
  printf '{"text": "⏺ REC", "tooltip": "%s", "class": "recording"}\n' "$tooltip"
else
  # Запись не активна
  echo '{"text": "", "tooltip": "", "class": ""}'
  # Удаляем файл статуса если остался
  rm -f "$STATUS_FILE" 2>/dev/null
fi
