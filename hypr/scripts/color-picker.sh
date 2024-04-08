#!/usr/bin/env bash

color_picker="$(hyprpicker)"
image="/tmp/${color_picker}".png

echo "$color_picker" | tr -d "\n" | wl-copy
convert -size 64x64 xc:"$color_picker" "$image"
notify-send -u low -r 69 -i "$image" "${color_picker} copied to clipboard"
