_isInstalled() {
  package="$1"
  check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
  if [ -n "${check}" ]; then
    echo 0
    return
  fi
  echo 1
  return
}

# Install required packages
_installPackages() {
  toInstall=()
  for pkg; do
    if [[ $(_isInstalled "${pkg}") == 0 ]]; then
      echo ":: ${pkg} уже установлен."
      continue
    fi
    toInstall+=("${pkg}")
  done
  if [[ "${toInstall[@]}" == "" ]]; then
    # echo "All pacman packages are already installed.";
    return
  fi
  echo ":: Установка pacman пакетов..."
  for pkg in "${toInstall[@]}"; do
    sudo pacman -S --noconfirm "${pkg}" || echo ":: Ошибка установки ${pkg}"
  done
}

_installPackagesYay() {
  toInstall=()
  for pkg; do
    if [[ $(_isInstalled "${pkg}") == 0 ]]; then
      echo ":: ${pkg} уже установлен."
      continue
    fi
    toInstall+=("${pkg}")
  done
  if [[ "${toInstall[@]}" == "" ]]; then
    return
  fi
  echo ":: Установка AUR пакетов..."
  for pkg in "${toInstall[@]}"; do
    yay -S --noconfirm "${pkg}" || echo ":: Ошибка установки ${pkg}"
  done
}

# Install Yay
_installYay() {
  if sudo pacman -Qs yay >/dev/null; then
    echo ":: yay уже установлен!"
  else
    echo ":: yay не найден. Ничего страшного, сейчас установлю!"
    _installPackages "base-devel"
    SCRIPT=$(realpath "$0")
    temp_path=$(dirname "$SCRIPT")
    git clone https://aur.archlinux.org/yay-bin.git ~/yay-bin
    cd ~/yay-bin
    makepkg -rsi --noconfirm
    cd $temp_path
    rm -Rf ~/yay-bin/
    echo ":: yay был успешно установлен."
  fi
}
