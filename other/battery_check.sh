#!/bin/bash

LOW_NOTIFICATION_SENT=0
FULL_NOTIFICATION_SENT=0
CRITICAL_CAPACITY=15
FULL_CAPACITY=75

while true; do
    BAT_CAPACITY=$(cat /sys/class/power_supply/BAT*/capacity)
    AC_ONLINE=$(cat /sys/class/power_supply/AC*/online)

    if [[ $AC_ONLINE -eq 0 && $BAT_CAPACITY -le $CRITICAL_CAPACITY ]]; then
        if [[ $LOW_NOTIFICATION_SENT -eq 0 ]]; then
            notify-send -u critical "Warning!" "Battery is low: $BAT_CAPACITY%"
            /usr/bin/paplay $HOME/.local/share/other/battery_low.mp3
            LOW_NOTIFICATION_SENT=1
        fi
    elif [[ $BAT_CAPACITY -gt $CRITICAL_CAPACITY ]]; then
        LOW_NOTIFICATION_SENT=0
    fi

    if [[ $AC_ONLINE -eq 1 && $BAT_CAPACITY -eq $FULL_CAPACITY ]]; then
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
