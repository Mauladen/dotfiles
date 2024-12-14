packages=(
  sddm
  qt5-graphicaleffects
  qt5-quickcontrols2
  qt5-svg
)

echo -e "${GREEN}"
cat <<"EOF"
 ____  ____  ____  _  _
/ ___)(    \(    \( \/ )
\___ \ ) D ( ) D (/ \/ \
(____/(____/(____/\_)(_/
EOF
echo -e "${NONE}"
echo
if gum confirm "Хотите настроить sddm?"; then
_installPackages "${packages[@]}";
sudo systemctl enable sddm
sudo cp -R install/sddm/sdt /usr/share/sddm/themes/
sudo chown -R $USER:$USER /usr/share/sddm/themes/sdt
sudo mkdir -p /etc/sddm.conf.d
echo -e "[Theme]\nCurrent=sdt" | sudo tee -a /etc/sddm.conf.d/10-theme.conf > /dev/null
sudo cp -f ~/.config/hyprdots/wallpapers/wallpaper.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
elif [ $? -eq 130 ]; then
  exit 130
else
  echo ":: Настройка sddm пропущена"
fi
