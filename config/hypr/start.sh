#!/usr/bin/env bash

#
hyprpaper &

# init nm applet to control apps via waybar on hyprland
nm-applet --indicator &

# run firefox on startup for convenience
firefox &

# the bar
waybar &
