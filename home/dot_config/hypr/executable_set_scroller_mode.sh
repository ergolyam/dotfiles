#!/bin/bash

WS=$(hyprctl activeworkspace -j | jq -r .name)
FLAG_FILE="/tmp/hypr_scroller_mode_${WS}"
NOTIF_ID=9999

if [ -f "$FLAG_FILE" ]; then
    hyprctl dispatch scroller:setmode row
    rm "$FLAG_FILE"
    MODE="ROW"
else
    hyprctl dispatch scroller:setmode col
    touch "$FLAG_FILE"
    MODE="COL"
fi

dunstify -r $NOTIF_ID "HyprScroller" "Scroller switched to $MODE on workspace $WS"
