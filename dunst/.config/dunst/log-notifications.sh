#!/bin/bash

LOGFILE="$HOME/.cache/notifications.log"
STATEFILE="$HOME/.cache/notifications.state"
MAX_LINES=100

echo "unread" >"$STATEFILE"

BODY="${DUNST_BODY:-[No message body]}"
echo "$(date '+%H:%M') - $DUNST_SUMMARY: $BODY" >>"$LOGFILE"
tail -n $MAX_LINES "$LOGFILE" >"$LOGFILE.tmp" && mv "$LOGFILE.tmp" "$LOGFILE"
