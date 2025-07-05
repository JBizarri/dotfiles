#!/bin/bash

LOGFILE="$HOME/.cache/notifications.log"
STATEFILE="$HOME/.cache/notifications.state"
ICON_READ="󰂚"
ICON_UNREAD="󱅫"
ICON_MUTED="󰂛"

get_icon() {
	if pgrep -x dunst >/dev/null && dunstctl is-paused | grep -q true; then
		echo "$ICON_MUTED"
	else
		if [ -f "$STATEFILE" ]; then
			case $(<"$STATEFILE") in
			unread) echo "$ICON_UNREAD" ;;
			*) echo "$ICON_READ" ;;
			esac
		else
			echo "$ICON_READ"
		fi
	fi
}

case "$1" in
left)
	[ ! -f "$LOGFILE" ] && echo "󰂛  No new notifications." | rofi -dmenu -p "Notifications" && exit

	while true; do
		mapfile -t lines < <(tac "$LOGFILE")
		choices=("${lines[@]}" " Clear All")

		selection=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -i -p "Notifications")

		[ -z "$selection" ] && break

		if [[ "$selection" == " Clear All" ]]; then
			rm -f "$LOGFILE"
			echo "read" >"$STATEFILE"
			break
		elif grep -qF -- "$selection" "$LOGFILE"; then
			grep -Fxv -- "$selection" "$LOGFILE" >"$LOGFILE.tmp"

			if [ ! -s "$LOGFILE.tmp" ]; then
				rm -f "$LOGFILE"
				echo "read" >"$STATEFILE"
				break
			else
				mv "$LOGFILE.tmp" "$LOGFILE"
			fi
		fi
	done
	;;

middle)
	if pgrep -x dunst >/dev/null; then
		if dunstctl is-paused | grep -q true; then
			dunstctl set-paused false
		else
			dunstctl set-paused true
		fi
		get_icon
	fi
	;;

*)
	get_icon
	;;
esac
