#!/usr/bin/env bash

date=$(date +"%A, the %d of %B")

notify-send -i $HOME/.local/bin/icons/notifications/calendar.png "$date"
