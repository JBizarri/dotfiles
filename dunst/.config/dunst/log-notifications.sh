#!/bin/bash

LOGFILE="$HOME/.cache/notifications.log"
STATEFILE="$HOME/.cache/notifications.state"
MAX_LINES=100

blacklist_apps=("brightnessctl")

is_blacklisted() {
	local target="$1"
	for a in "${blacklist_apps[@]}"; do
		if [[ "$a" == "$target" ]]; then
			return 0
		fi
	done
	return 1
}

if is_blacklisted "$DUNST_APP_NAME"; then
	exit 0
fi

echo "unread" >"$STATEFILE"

BODY="${DUNST_BODY:-[No message body]}"
echo "$(date '+%H:%M') - $DUNST_SUMMARY: $BODY" >>"$LOGFILE"
tail -n $MAX_LINES "$LOGFILE" >"$LOGFILE.tmp" && mv "$LOGFILE.tmp" "$LOGFILE"
