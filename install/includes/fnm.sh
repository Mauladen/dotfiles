#!/bin/bash

# Подключаем библиотеку функций
source install/arch/library.sh

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
    fnm install --lts --corepack-enabled
    fnm default lts-latest

    echo ":: Node.js LTS и corepack настроены."
    fnm list
else
    echo ":: Настройка Node.js и corepack пропущена"
fi

