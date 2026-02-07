SERVICES=(
  "NetworkManager"
  "bluetooth"
)

for service in "${SERVICES[@]}"; do
  echo "Запуск службы $service..."
  sudo systemctl enable --now "$service.service"
  sleep 2
done
