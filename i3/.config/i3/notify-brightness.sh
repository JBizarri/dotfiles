#!/bin/bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)

percent=$((brightness * 100 / max_brightness))

notify-send \
	-h string:x-dunst-stack-tag:brightness_notif \
	-h int:value:"$percent" \
	-h string:hlcolor:#00ffc8 \
	-u low \
	-a "brightnessctl" \
	"󰃠  Brightness: $percent%" ""
