#!/bin/bash

wifi_iface="wlp0s20f3"
eth_iface="enp6s0f1"

icon_color="$1"
text_color="$2"

wifi_status=$(cat /sys/class/net/$wifi_iface/operstate 2>/dev/null)
eth_status=$(cat /sys/class/net/$eth_iface/operstate 2>/dev/null)

if [[ "$eth_status" == "up" ]]; then
	echo "%{F$icon_color} %{F$text_color}$eth_iface"
elif [[ "$wifi_status" == "up" ]]; then
	ssid=$(iw dev $wifi_iface link | grep SSID | cut -d ' ' -f2-)
	wifi_strength=$(iw dev $wifi_iface link | awk '/signal/ { 
	dbm = $2
	    percent = 2 * (dbm + 100)
	    if (percent > 100) percent = 100
	    if (percent < 0) percent = 0
	    print percent
	}')

	if (( wifi_strength <= 20 )); then
	    icon="󰤯"
	elif (( wifi_strength <= 40 )); then
	    icon="󰤟"
	elif (( wifi_strength <= 60 )); then
	    icon="󰤢"
	elif (( wifi_strength <= 80 )); then
	    icon="󰤥"
	else
	    icon="󰤨"
	fi
	echo "%{T2}%{F$icon_color}$icon%{O4}%{T1}%{F$text_color}$ssid"
else
	echo "%{T2}%{F$icon_color}%{O4}%{T1}%{F$text_color}disconnected"
fi
