#!/bin/bash

containers=$(echo -e "Host\n$(distrobox list | tail -n +2 | awk -F'|' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')")

if [ -z "$containers" ]; then
    echo "No containers available."
    exit 1
fi

selected_container=$(echo "$containers" | fzf --prompt="Select a container or Host: ")

if [ "$selected_container" == "Host" ]; then
    kitty @ set-tab-title "Host"
    exec bash

elif [ -n "$selected_container" ]; then
    kitty @ set-tab-title "$selected_container"
    distrobox enter "$selected_container"
else
    echo "No container selected."
fi

