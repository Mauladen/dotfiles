# Переходим в домашнюю директорию
cd ~

# Создаем символические ссылки с помощью stow
cd ~/hyprdots
stow -t ~ .

echo ":: hyprdots установлены через stow в ~/.config/"
