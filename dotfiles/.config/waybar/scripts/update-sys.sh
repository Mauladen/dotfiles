#!/usr/bin/env bash

# Только для Arch
[ ! -f /etc/arch-release ] && exit 0

# Считаем обновления
AUR=$(yay -Qua 2>/dev/null | wc -l)
OFFICIAL=$(checkupdates 2>/dev/null | wc -l)

case "$1" in
  update)
    ghostty --title="update-sys" -e yay -Suy --noconfirm
    exit 0
    ;;
  *)
    COUNT=$((AUR + OFFICIAL))
    if (( COUNT > 0 )); then
      # Заставляем справа налево знак обновления идти слева-направо
      printf '\u202d %s\n' "$COUNT"
    fi
    exit 0
    ;;
esac
