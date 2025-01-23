#!/bin/bash

NOTIFICATION_SENT=0
CRITICAL_CAPACITY=15

while true; do
    BAT_CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity)
    BAT_STATUS=$(cat /sys/class/power_supply/BAT*/status)

    if [[ $BAT_STATUS == "Discharging" && $BAT_CAPACITY -le $CRITICAL_CAPACITY ]]; then
        if [[ $NOTIFICATION_SENT -eq 0 ]]; then
            notify-send -u critical "Warning!" "Battery is low: $BAT_CAPACITY%"
            /usr/bin/paplay $HOME/.config/dunst/battery_low.mp3
            NOTIFICATION_SENT=1
        fi
    elif [[ $BAT_CAPACITY -gt $CRITICAL_CAPACITY ]]; then
        NOTIFICATION_SENT=0
    fi
    sleep 300
done
