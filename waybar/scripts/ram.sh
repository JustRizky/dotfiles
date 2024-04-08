#!/usr/bin/env bash

current_ram=$(free --mebi --si  | grep Mem | awk '{print $3}')
total_ram=$(free --mebi --si  | grep Mem | awk '{print $2}')

notify-send -i $HOME/.local/bin/icons/notifications/alert.png "${current_ram}MiB / ${total_ram}MiB"
