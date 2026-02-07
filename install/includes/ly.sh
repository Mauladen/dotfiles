packages=(
  ly
)

if gum confirm "Хотите настроить ly?"; then
_installPackages "${packages[@]}";
sudo systemctl enable ly@tty2.service
elif [ $? -eq 130 ]; then
  exit 130
else
  echo ":: Настройка ly пропущена"
fi
