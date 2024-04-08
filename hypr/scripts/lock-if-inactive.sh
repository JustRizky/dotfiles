#!/usr/bin/env bash

# swayidle -w timeout 600 'bash -c ~/.config/swaylock/lock-session.sh &'

sway-audio-idle-inhibit -w timeout 600 'bash -c ~/.config/swaylock/lock-session.sh &'
