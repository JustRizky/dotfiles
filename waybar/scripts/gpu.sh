#!/usr/bin/env bash

fan_rpm_speed=$(sensors | grep 3360 | awk '{print $2}')
gpu_ppt=$(sensors | grep PPT | awk '{print $2}' | sed 's/+//;s/\..*//')
gpu_vram_usage=$(echo $(($(cat /sys/class/drm/card1/device/mem_info_vram_used) / 1024 / 1024)))
gpu_voltage=$(cat /sys/class/drm/card1/device/pp_od_clk_voltage | grep -a mV)

notify-send -i $HOME/.local/bin/icons/notifications/alert.png "${gpu_vram_usage}MB VRAM, $gpu_voltage, ${fan_rpm_speed}RPM, ${gpu_ppt}W PPT"

