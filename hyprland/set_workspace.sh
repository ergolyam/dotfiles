#!/bin/bash
current_ws=$(hyprctl monitors -j | jq '.[0].activeWorkspace.id')
total_ws=10

if [ "$1" == "next" ]; then
    next_ws=$(( (current_ws % total_ws) + 1 ))
elif [ "$1" == "prev" ]; then
    next_ws=$(( (current_ws + total_ws - 2) % total_ws + 1 ))
else
    echo "Use 'next' or 'previous' as an argument."
    exit 1
fi

hyprctl dispatch workspace $next_ws

