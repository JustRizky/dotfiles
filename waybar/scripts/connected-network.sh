#!/usr/bin/env bash

notify-send -i $HOME/.local/bin/icons/notifications/wifi.png "Connected to $(nmcli | grep "wlo1: connected" | awk '{print $4}')"
