#!/bin/bash

OPTIONS="Reboot\nShutdown\nSuspend\nLog off\nCancel"

CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -p "Power Menu" -theme dracula)

case "$CHOICE" in
    "Reboot")
        systemctl reboot
        ;;
    "Shutdown")
        systemctl poweroff
        ;;
    "Suspend")
        systemctl suspend
        ;;
    "Log off")
        i3-msg exit
        ;;
    "Cancel")
        exit 0
        ;;
    *)
        exit 1
        ;;
esac
