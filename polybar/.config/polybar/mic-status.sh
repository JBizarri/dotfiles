#!/bin/bash

icon_color="$1"
text_color="$2"
muted_color="$3"

icon_muted=""
icon_active=""

print_status() {
	volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}' | head -n1)
	mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')

	if [ "$mute" = "yes" ]; then
		echo "%{T2}%{F$icon_color}$icon_muted%{O6}%{T1}%{F$muted_color}muted%{F-}"
	else
		echo "%{T2}%{F$icon_color}$icon_active%{O4}%{T1}%{F$text_color}$volume%{F-}"
	fi
}

print_status

pactl subscribe | while read -r line; do
	if echo "$line" | grep --quiet "source"; then
		print_status
	fi
done
