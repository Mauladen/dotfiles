echo "Рекомендуется перезагрузка системы."
if gum confirm "Хотите перезагрузить систему сейчас?" ;then
    gum spin --spinner dot --title "Перезагрузка..." -- sleep 3
    systemctl reboot
elif [ $? -eq 130 ]; then
    exit 130
else
    echo ":: Перезагрузка пропущена"
fi
