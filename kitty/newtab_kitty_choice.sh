#!/bin/bash

session_file="$HOME/sessions.conf"
sessions=""

if [ -f "$session_file" ]; then
    while IFS= read -r line; do
        if [[ $line =~ ^\"(.*)\"\ \"(.*)\"$ ]]; then
            name="${BASH_REMATCH[1]}"
            command="${BASH_REMATCH[2]}"
            sessions+="$name\n"
        fi
    done < "$session_file"
fi

containers=$(echo -e "Host\n$(distrobox list | tail -n +2 | awk -F'|' '{print $2}' | sed 's/^[ \t]*//;s/[ \t]*$//')")

if [ -n "$sessions" ]; then
    containers=$(echo -e "$containers\n$sessions")
fi

if [ -z "$containers" ]; then
    echo "No containers or sessions available."
    exit 1
fi

selected_container=$(echo -e "$containers" | fzf --prompt="Select a session: ")

if [ "$selected_container" == "Host" ]; then
    kitty @ set-tab-title "Host"
    exec bash
elif [[ "$selected_container" && "$selected_container" != "Host" ]]; then
    if [ -f "$session_file" ] && grep -q "\"$selected_container\"" "$session_file"; then
        command=$(grep "\"$selected_container\"" "$session_file" | sed -E 's/.*"([^"]+)"/\1/')
        kitty @ set-tab-title "$selected_container"
        eval "$command"
    else
        kitty @ set-tab-title "$selected_container"
        distrobox enter "$selected_container"
    fi
else
    echo "No container or session selected."
fi

