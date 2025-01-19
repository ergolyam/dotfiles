#!/bin/bash

session_file="$HOME/sessions.conf"
sessions=""
TERM=xterm-256color

if [ -f "$session_file" ]; then
    while IFS= read -r line; do
        if [[ $line =~ ^\"(.*)\"\ \"(.*)\"$ ]]; then
            name="${BASH_REMATCH[1]}"
            command="${BASH_REMATCH[2]}"
            sessions+="$name\n"
        fi
    done < "$session_file"
fi

distrobox_containers=$(distrobox list | tail -n +2 | awk -F'|' '{print $2 " (Distrobox)"}' | sed 's/^[ \t]*//;s/[ \t]*$//')
toolbox_containers=$(toolbox list --containers | tail -n +2 | awk '{printf "%-21s (Toolbox)\n", $2}')

if [ -n "$sessions" ]; then
    containers=$(echo -e "Host\n$toolbox_containers\n$distrobox_containers\n$sessions")
fi

if [ -z "$containers" ]; then
    echo "No containers or sessions available."
    exit 1
fi

selected_container=$(echo -e "$containers" | fzf --prompt="Select a session: " \
    --height=100% --layout=reverse --border --info=inline --padding=5% --margin=5% --info=hidden)

if [ "$selected_container" == "Host" ]; then
    kitty @ set-tab-title "Host"
    exec "$SHELL"
elif [[ "$selected_container" && "$selected_container" != "Host" ]]; then
    if [ -f "$session_file" ] && grep -q "\"$selected_container\"" "$session_file"; then
        command=$(awk -v session="$selected_container" -F'\"' '$2 == session { for(i=4;i<=NF;i++) printf("%s ", $i); print "" }' "$session_file" | tr -d '\n')
        kitty @ set-tab-title "$selected_container"
        eval "$command"
    elif [[ "$selected_container" == *"(Distrobox)" ]]; then
        container_name=$(echo "$selected_container" | sed 's/ * (Distrobox)$//')
        kitty @ set-tab-title "$container_name"
        distrobox enter "$container_name"
    elif [[ "$selected_container" == *"(Distrobox-Root)" ]]; then
        container_name=$(echo "$selected_container" | sed 's/ * (Distrobox-Root)$//')
        kitty @ set-tab-title "$container_name"
        distrobox enter --root "$container_name"
    elif [[ "$selected_container" == *"(Toolbox)" ]]; then
        container_name=$(echo "$selected_container" | sed 's/ * (Toolbox)$//')
        kitty @ set-tab-title "$container_name"
        toolbox enter "$container_name"
    fi
else
    echo "No container or session selected."
fi

