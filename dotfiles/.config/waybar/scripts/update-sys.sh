#!/usr/bin/env bash

# If the operating system is not Arch Linux, exit the script successfully
if [ ! -f /etc/arch-release ]; then
    exit 0
fi

# Calculate updates for each service
AUR=$(yay -Qua | wc -l)
OFFICIAL=$(pacman -Qu | wc -l)

# Case/switch for each service updates
case $1 in
    aur) echo " $AUR";;
    official) echo " $OFFICIAL";;
esac

# If the parameter is "update", update all services
if [ "$1" = "update" ]; then
    ghostty --title="update-sys" -e yay -Syu
fi

# If there aren't any parameters, return the total number of updates
if [ "$1" = "" ]; then
    # Calculate total number of updates
    COUNT=$((OFFICIAL+AUR))
    # If there are updates, the script will output the following:   Updates
    # If there are no updates, the script will output nothing.

    if [[ "$COUNT" = "0" ]]
    then
        echo ""
    else
        # This Update symbol is RTL. So &#x202d; is left-to-right override.
        echo " $COUNT"
    fi
    exit 0
fi
