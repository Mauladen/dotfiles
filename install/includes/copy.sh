# Создаем символические ссылки с помощью stow (в subshell, чтобы не менять директорию родительского процесса)
(
  cd ~/dotfiles/dotfiles
  stow -t ~ .
)

echo ":: dotfiles установлены через stow в ~/.config/"
