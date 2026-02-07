#!/bin/bash

# Проверка установлен ли fnm
if ! command -v fnm &>/dev/null; then
    echo ":: fnm не установлен. Пропускаю настройку."
    exit 0
fi

packages=(
  fnm-bin
)

echo -e "${GREEN}"
cat <<"EOF"
 _  _  ____  ____  _  _    ____  __    __ _  ____  ____
( \/ )(  __)(  _ \( \( )  (  _ \(  )  (  / )(  __)(  __)
 )  /  ) _)  ) __/ )  (    ) __/ )(__)\    \ ) _)  ) _)
(__/  (____)(__)  (_)\_)  (__) (____)(__\_/(____)(____)
EOF
echo -e "${NONE}"
echo
if gum confirm "Хотите настроить fnm?"; then
    echo ":: Установка последней LTS версии Node.js, включение corepack и настройка по умолчанию..."
    fnm install --lts
    fnm exec lts-latest -- corepack enable
    fnm default lts-latest

    echo ":: Node.js LTS и corepack настроены."
    fnm list
else
    echo ":: Настройка fnm пропущена"
fi
