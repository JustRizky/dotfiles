#!/usr/bin/env bash

killall -q waybar
while pgrep -u $UID -x waybar >/dev/null; do sleep 0.1; done
nohup waybar &> /dev/null &
