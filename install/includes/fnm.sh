#!/bin/bash

# Подключаем библиотеку функций
source install/arch/library.sh

echo -e "${GREEN}"
cat <<"EOF"
 _  _  ____  ____  _  _    ____  __    __ _  ____  ____
( \/ )(  __)(  _ \( \( )  (  _ \(  )  (  / )(  __)(  __)
 )  /  ) _)  ) __/ )  (    ) __/ )(__)\    \ ) _)  ) _)
(__/  (____)(__)  (_)\_)  (__) (____)(__\_/(____)(____)
EOF
echo -e "${NONE}"
echo

# Проверяем установлен ли fnm
if ! command -v fnm &>/dev/null; then
    if gum confirm "fnm не установлен. Установить сейчас?"; then
        echo ":: Установка fnm через yay..."
        _installPackagesYay "fnm-bin"

        # Проверяем успешность установки
        if ! command -v fnm &>/dev/null; then
            echo ":: Ошибка: fnm не был установлен." >&2
            exit 1
        fi
    else
        echo ":: Установка fnm пропущена. Пропускаю настройку."
        exit 0
    fi
fi

if gum confirm "Хотите настроить Node.js LTS и corepack?"; then
    echo ":: Установка последней LTS версии Node.js, включение corepack и настройка по умолчанию..."
    fnm install --lts
    fnm exec lts-latest -- corepack enable
    fnm default lts-latest

    echo ":: Node.js LTS и corepack настроены."
    fnm list
else
    echo ":: Настройка Node.js и corepack пропущена"
fi

