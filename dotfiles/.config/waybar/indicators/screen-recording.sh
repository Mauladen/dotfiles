#!/bin/bash

if pgrep -f "^gpu-screen-recorder" >/dev/null; then
  echo '{"text": "󰻂", "tooltip": "Остановить запись", "class": "active"}'
else
  echo '{"text": ""}'
fi