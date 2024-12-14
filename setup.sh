#!/bin/bash

# -----------------------------------------------------
# Функции для установки
# -----------------------------------------------------

# Проверка установлен ли пакет
_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' означает 'true' в Bash
        return; #true
    fi;
    echo 1; #'1' означает 'false' в Bash
    return; #false
}

# Установка необходимых пакетов
_installPackagesPacman() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            echo "${pkg} уже установлен.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        return;
    fi;
    printf "Пакеты не установлены:\n%s\n" "${toInstall[@]}";
    sudo pacman --noconfirm -S "${toInstall[@]}";
}

# -----------------------------------------------------
# Пакеты
# -----------------------------------------------------

# Необходимые пакеты для установщика на Arch
installer_packages=(
    "git"
)

clear

# Некоторые цвета
GREEN='\033[0;32m'
NONE='\033[0m'

# Заголовок
echo -e "${GREEN}"
cat <<"EOF"
 _  _   __    ___  ____  ____   __   _ u_  __ _   __
/ )( \ / _\  / __)(_  _)(  _ \ /  \ / )  )(  / ) / _\
) __ (/    \( (__   )(   ) __/(  O )\    \ )  ( /    \
\_)(_/\_/\_/ \___) (__) (__)   \__/ (__(_/(__\_)\_/\_/

EOF
echo "для Hyprdots"
echo
echo -e "${NONE}"

echo "Этот скрипт загрузит Hyprdots и начнет установку."
echo

while true; do
    read -p "ХОТИТЕ НАЧАТЬ УСТАНОВКУ СЕЙЧАС? (Да[Yy]/Нет[Nn]): " yn
    case $yn in
        [Yy]* )
            echo "Установка начата."
            echo
        break;;
        [Nn]* )
            echo "Установка отменена."
            exit;
        break;;
        * ) echo "Пожалуйста, ответьте да или нет.";;
    esac
done

# -----------------------------------------------------
# Установка для Arch
# -----------------------------------------------------
_installPackagesPacman "${installer_packages[@]}";

# Перейти в домашнюю директорию
cd ~

# Удалить существующую папку
if [ -d ~/hyprdots ] ;then
    rm -rf ~/hyprdots
    echo ":: Существующая папка hyprdots удалена"
fi

# Клонировать пакеты
git clone --depth 1 https://github.com/Mauladen/hyprdots.git
echo ":: Файлы конфигураций склонированы в домашнюю директорию"

# Перейти в папку
cd hyprdots

# Запустить скрипт
./install.sh
