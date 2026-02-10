#!/bin/bash

# Запускает лаунчер приложений Walker, предварительно убеждаясь, что его провайдер данных (elephant) уже запущен.

# Убеждаемся, что elephant запущен перед стартом walker
if ! pgrep -x elephant > /dev/null; then
  setsid elephant &
fi

# Убеждаемся, что сервис walker запущен
if ! pgrep -f "walker --gapplication-service" > /dev/null; then
  setsid walker --gapplication-service &
fi

exec walker --width 644 --maxheight 300 --minheight 300 "$@"
