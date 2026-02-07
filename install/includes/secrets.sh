#!/bin/bash

# Проверяем установлен ли git-crypt
if ! command -v git-crypt &>/dev/null; then
    echo ":: git-crypt не установлен. Не могу восстановить секреты."
    return 0
fi

# Проверяем расшифрован ли репозиторий
if git-crypt status 2>/dev/null | grep -q "not encrypted"; then
    echo ":: Репозиторий не расшифрован. Секреты недоступны."
    echo ":: Выполните 'git-crypt unlock' для расшифровки."
    return 0
fi

echo ":: Восстановление секретов..."

# Восстановление SSH ключей
if [[ -d "secrets/ssh" ]]; then
    mkdir -p ~/.ssh
    echo ":: Восстановление SSH ключей..."
    for file in secrets/ssh/*; do
        if [[ -f "$HOME/.$(basename "$file")" ]]; then
            echo ":: Пропускаю существующий файл: ~/.${file#secrets/ssh/}"
        else
            cp -n "$file" ~/.ssh/
            chmod 600 ~/.ssh/$(basename "$file" | grep -v '\.pub$')
            chmod 644 ~/.ssh/$(basename "$file" | grep '\.pub$')
        fi
    done
    echo ":: SSH ключи восстановлены."
else
    echo ":: Директория secrets/ssh не найдена."
fi

# Восстановление GPG ключей
if [[ -d "secrets/gpg" ]]; then
    mkdir -p ~/.gnupg/private-keys-v1.d
    echo ":: Восстановление GPG ключей..."
    for file in secrets/gpg/*; do
        if [[ -f "$HOME/.gnupg/private-keys-v1.d/$(basename "$file")" ]]; then
            echo ":: Пропускаю существующий файл: ~/.gnupg/$(basename "$file")"
        else
            cp -n "$file" ~/.gnupg/private-keys-v1.d/
            chmod 600 ~/.gnupg/private-keys-v1.d/*
        fi
    done
    echo ":: GPG ключи восстановлены."
else
    echo ":: Директория secrets/gpg не найдена."
fi

# Восстановление Docker credentials
if [[ -d "secrets/docker" ]]; then
    mkdir -p ~/.docker
    echo ":: Восстановление Docker credentials..."
    for file in secrets/docker/*; do
        if [[ -f "$HOME/.$(basename "$file")" ]]; then
            echo ":: Пропускаю существующий файл: ~/.docker/$(basename "$file")"
        else
            cp -n "$file" ~/.docker/
            chmod 600 ~/.docker/*
        fi
    done
    echo ":: Docker credentials восстановлены."
else
    echo ":: Директория secrets/docker не найдена."
fi

echo ":: Восстановление секретов завершено."
