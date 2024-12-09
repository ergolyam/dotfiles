#!/bin/bash

WS=$(hyprctl activeworkspace -j | jq -r .name)

FLAG_FILE="/tmp/hypr_scroller_mode_${WS}"

if [ -f "$FLAG_FILE" ]; then
    MODE="COL"
else
    MODE="ROW"
fi

echo "{\"text\": \"$MODE\"}"

