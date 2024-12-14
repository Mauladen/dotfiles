#!/usr/bin/env bash

killall waybar
pkill waybar
hyprctl reload

sleep 0.5

waybar
