#!/bin/bash

LOW_NOTIFICATION_SENT=0
FULL_NOTIFICATION_SENT=0
CRITICAL_CAPACITY=15
FULL_CAPACITY=100

while true; do
    BAT_CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity)
    BAT_STATUS=$(cat /sys/class/power_supply/BAT*/status)

    if [[ $BAT_STATUS == "Discharging" && $BAT_CAPACITY -le $CRITICAL_CAPACITY ]]; then
        if [[ $LOW_NOTIFICATION_SENT -eq 0 ]]; then
            notify-send -u critical "Warning!" "Battery is low: $BAT_CAPACITY%"
            /usr/bin/paplay $HOME/.local/share/other/battery_low.mp3
            LOW_NOTIFICATION_SENT=1
        fi
    elif [[ $BAT_CAPACITY -gt $CRITICAL_CAPACITY ]]; then
        LOW_NOTIFICATION_SENT=0
    fi

    if [[ $BAT_STATUS == "Full" && $BAT_CAPACITY -eq $FULL_CAPACITY ]]; then
        if [[ $FULL_NOTIFICATION_SENT -eq 0 ]]; then
            notify-send -u normal "Battery Full" "Battery is fully charged"
            /usr/bin/paplay $HOME/.local/share/other/battery_full.ogg
            FULL_NOTIFICATION_SENT=1
        fi
    elif [[ $BAT_CAPACITY -lt $FULL_CAPACITY ]]; then
      FULL_NOTIFICATION_SENT=0
    fi

    sleep 300
done
