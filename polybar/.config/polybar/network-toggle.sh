#!/bin/bash

wifi_iface="wlp0s20f3"
eth_iface="enp6s0f1"

color_iface="$1"
color_ip="$2"

wifi_status=$(cat /sys/class/net/$wifi_iface/operstate 2>/dev/null)
eth_status=$(cat /sys/class/net/$eth_iface/operstate 2>/dev/null)

if [[ "$eth_status" == "up" ]]; then
    ip=$(ip -o -4 addr show $eth_iface | awk '{print $4}' | cut -d / -f1)
    echo "%{F$color_iface} $eth_iface: %{F$color_ip}$ip"
elif [[ "$wifi_status" == "up" ]]; then
    ssid=$(iw dev $wifi_iface link | grep SSID | cut -d ' ' -f2-)
    ip=$(ip -o -4 addr show $wifi_iface | awk '{print $4}' | cut -d / -f1)
    echo "%{F$color_iface} $ssid: %{F$color_ip}$ip"
else
    echo "%{F$color_iface}⚠️ %{F$color_ip}disconnected"
fi
