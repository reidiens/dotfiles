#!/bin/bash

pgrep hyprpaper > /dev/null	
res=$?

if [ $res -eq 1 ]; then
	hyprpaper &>/dev/null & disown;
	sleep 0.75
fi

dir=~/Pictures/screensavers
monitor="$(hyprctl monitors | grep Monitor | awk '{print $2}')"

function main {
	if [ -d "$dir" ]; then
		wp=$(ls $dir/* | shuf -n 1)
		# hyprctl hyprpaper unload all
		# hyprctl hyprpaper preload $wp
		hyprctl hyprpaper wallpaper "$monitor, $wp"
	fi

	sleep 15m
	main
}
	
main
