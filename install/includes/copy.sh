# Переходим в домашнюю директорию
cd ~

# Создаем символические ссылки с помощью stow
cd ~/dotfiles/dotfiles
stow -t ~ .

echo ":: dotfiles установлены через stow в ~/.config/"
