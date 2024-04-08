#!/usr/bin/env bash

icon="$HOME/.local/bin/icons/notifications/succes.png"
anim_is_enabled="$(grep "enabled" $HOME/.config/hypr/hyprland.conf | tail -n1 | awk '{print $3}')"
target_file="$HOME/.config/hypr/hyprland.conf"
### Opacity
target_second="$HOME/.config/hypr/rules.conf"
# Alacritty Opacity
target_third="$HOME/.config/alacritty/alacritty.yml"

send_notify() {
	notify-send -u low -i "$icon" "$1"
}

update_swww() {
	local script="$HOME/.config/hypr/scripts/dynamic-walls.sh"
	local binds="$HOME/.config/hypr/binds.conf"

	if [ "$anim_is_enabled" == "yes" ]; then 
		sed -i '5s/^/#/' "$script"
		sed -i '6s/#//' "$script"

		sed -i '82s/^/#/' "$binds"
		sed -i '83s/#//' "$binds"

		kill $(pgrep -a bash | grep walls | awk '{print $1}')
	else
		sed -i '6s/^/#/' "$script"
		sed -i '5s/#//' "$script"

		sed -i '82s/#//' "$binds"
		sed -i '83s/^/#/' "$binds"

		kill $(pgrep -a bash | grep walls | awk '{print $1}')
	fi
		
	nohup $HOME/.config/hypr/scripts/dynamic-walls.sh &> /dev/null &
}

update_waybar() {
	local waybar_config="$HOME/.config/waybar/style.css"

	if [ "$anim_is_enabled" == "yes" ]; then 
		sed -i '/border-radius/s/6/0/' "$waybar_config"
		$HOME/.config/waybar/launch.sh
	else
		sed -i '/border-radius/s/0/6/' "$waybar_config"
		$HOME/.config/waybar/launch.sh
	fi

}

update_dunst() {
	local dunst_config="$HOME/.config/dunst/dunstrc"

	if [ "$anim_is_enabled" == "yes" ]; then 
		sed -i '/corner_radius/s/4/0/' "$dunst_config"
		sed -i '/background/s/28282890/282828/g' "$dunst_config"
	else
		sed -i '/corner_radius/s/0/4/' "$dunst_config"
		sed -i '/background/s/282828/28282890/g' "$dunst_config"
	fi

	killall dunst
	nohup dunst &> /dev/null &
}	

update_rofi() {
	local rofi_config="$HOME/.config/rofi/config.rasi"

	if [ "$anim_is_enabled" == "yes" ]; then 
		sed -i '28s/7/0/' "$rofi_config"
		sed -i '51s/7/0/'  "$rofi_config"
		sed -i '116s/7/0/'  "$rofi_config"
		
		sed -i '30s/^/\/\//' "$rofi_config"
		sed -i '31s/\/\///'  "$rofi_config"

	else
		sed -i '28s/0/7/' "$rofi_config"
		sed -i '51s/0/7/'  "$rofi_config"
		sed -i '116s/0/7/'  "$rofi_config"

		sed -i '30s/\/\///' "$rofi_config"
		sed -i '31s/^/\/\//'  "$rofi_config"
	fi
}

update_waybar
update_rofi
update_dunst
update_swww

# Hyprland reloading itself, but with direct command it happens a much faster
if [ "$anim_is_enabled" == "yes" ]; then 
	sed -i '/enabled/s/yes/no/' "$target_file"
	sed -i '4s/0.85/1/' "$target_second"
	sed -i '56s/0.8/1/' "$target_second"
	sed -i '/opacity/s/0.8/1/' "$target_third"
	sed -i '/rounding/s/4/0/' "$target_file"

	# blur
	sed -i '103s/true/false/' "$target_file"

	hyprctl reload
	send_notify "Animations Disabled"
else
	sed -i '/enabled/s/no/yes/' "$target_file"
	sed -i '4s/1/0.85/' "$target_second"
	sed -i '56s/1/0.8/' "$target_second"
	sed -i '/opacity/s/1/0.8/' "$target_third"
	sed -i '/rounding/s/0/4/' "$target_file"

	# blur
	sed -i '105s/false/true/' "$target_file"

	hyprctl reload
	send_notify "Animations Enabled"
fi

