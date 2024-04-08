#!/usr/bin/env bash

while true; do
	sleep 30m
#	swww img $(find /run/media/shved/Trash/Wallpapers/Dark/gruvbox/ -type f | shuf -n1) --transition-fps 144 --transition-type wipe  --transition-duration 3 --transition-angle 45 --transition-step 10 --transition-bezier 0.76,0,0.24,1
	swww img $(find /run/media/shved/Trash/Wallpapers/Dark/gruvbox/ -type f | shuf -n1) --transition-type none
done
