#!/bin/bash

# Get the target workspace from the argument
target_workspace=$1

# Check if a target workspace was provided
if [ -z "$target_workspace" ]; then
    exit 1
fi

# Get the current active workspace
current_workspace=$(hyprctl activewindow -j | jq '.workspace.id')

if [ -z "$current_workspace" ]; then
    exit 1
fi

# Get all window addresses in the current workspace
window_addresses=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_workspace) | .address")

# Move each window to the target workspace
for address in $window_addresses; do
    hyprctl dispatch movetoworkspacesilent "$target_workspace,address:$address"
done

# Switch to the target workspace
hyprctl dispatch workspace "$target_workspace"
