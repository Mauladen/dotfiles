packages=(
  docker
  docker-compose
)

echo -e "${GREEN}"
cat <<"EOF"
 ____   __    ___  __ _  ____  ____
(    \ /  \  / __)(  / )(  __)(  _ \
 ) D ((  O )( (__  )  (  ) _)  )   /
(____/ \__/  \___)(__\_)(____)(__\_)
EOF
echo
echo -e "${NONE}"
echo
if gum confirm "Хотите настроить docker?"; then
  _installPackages "${packages[@]}"
  sudo systemctl enable docker.service
  sudo usermod -aG docker $USER
elif [ $? -eq 130 ]; then
  exit 130
else
  echo ":: Настройка docker пропущена"
fi
