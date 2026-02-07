packages=(
  docker
  docker-compose
)

if gum confirm "Хотите настроить docker?"; then
  _installPackages "${packages[@]}"
  sudo systemctl enable docker.service
  sudo usermod -aG docker $USER
elif [ $? -eq 130 ]; then
  exit 130
else
  echo ":: Настройка docker пропущена"
fi
