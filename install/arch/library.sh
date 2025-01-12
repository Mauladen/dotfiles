# Check if package is installed
_isInstalled() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

# Install required packages
_installPackages() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo "${pkg} уже установлен.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All pacman packages are already installed.";
        return;
    fi;
    printf "Пакет не найден :\n%s\n" "${toInstall[@]}";
    sudo pacman -S --noconfirm "${toInstall[@]}";
}

_installPackagesYay() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalled "${pkg}") == 0 ]]; then
            echo ":: ${pkg} уже установлен.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    if [[ "${toInstall[@]}" == "" ]] ; then
        return;
    fi;
    printf "Пакет не найден :\n%s\n" "${toInstall[@]}";
    yay -S --noconfirm "${toInstall[@]}";
}

# Install Yay
_installYay() {
    if sudo pacman -Qs yay > /dev/null ; then
        echo "yay уже установлен!"
    else
        echo "yay не найден. Ничего страшного, сейчас установлю!"
        _installPackagesPacman "base-devel"
        SCRIPT=$(realpath "$0")
        temp_path=$(dirname "$SCRIPT")
        git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
        cd ~/yay-bin
        makepkg -rsi --noconfirm
        cd $temp_path
        rm -Rf ~/yay-bin/
        echo "yay был успешно установлен."
    fi
}

