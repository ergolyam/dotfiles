#!/bin/bash

WS=$(hyprctl activeworkspace -j | jq -r .name)
FLAG_FILE="/tmp/hypr_overview_mode_${WS}"

if [ -f "$FLAG_FILE" ]; then
    rm "$FLAG_FILE"
    notify-send "HyprScroller" "Off overview mode on workspace ${WS}"
    
    OVERVIEW_COUNT=$(ls /tmp/hypr_overview_mode_* 2>/dev/null | wc -l)
    
    if [ "$OVERVIEW_COUNT" -eq 0 ]; then
        hyprctl keyword general:border_size 0
    fi
else
    touch "$FLAG_FILE"
    notify-send "HyprScroller" "On overview mode on workspace ${WS}"
    hyprctl keyword general:border_size 2
fi

hyprctl dispatch scroller:toggleoverview

