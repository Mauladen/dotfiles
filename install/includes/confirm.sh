echo "Этот скрипт установит конфигурацию mauladen/dotfiles."
echo
if gum confirm "ХОТИТЕ НАЧАТЬ СЕЙЧАС?"; then
  echo
  echo ":: Установка Hyprland и необходимых пакетов"
  echo
elif [ $? -eq 130 ]; then
  echo ":: Установка отменена"
  exit 130
else
  echo
  echo ":: Установка отменена"
  exit
fi
