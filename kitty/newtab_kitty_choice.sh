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

distrobox_containers=$(echo -e "Host\n$(distrobox list | tail -n +2 | awk -F'|' '{print $2 " (Distrobox)"}' | sed 's/^[ \t]*//;s/[ \t]*$//')")

if [ -n "$sessions" ]; then
    containers=$(echo -e "$distrobox_containers\n$sessions")
fi

if [ -z "$containers" ]; then
    echo "No containers or sessions available."
    exit 1
fi

selected_container=$(echo -e "$containers" | fzf --prompt="Select a session: " \
    --height=40% --layout=reverse --border --info=inline --padding=5% --margin=5% --info=hidden)

if [ "$selected_container" == "Host" ]; then
    kitty @ set-tab-title "Host"
    exec "$SHELL"
elif [[ "$selected_container" && "$selected_container" != "Host" ]]; then
    if [ -f "$session_file" ] && grep -q "\"$selected_container\"" "$session_file"; then
        command=$(awk -v session="$selected_container" -F'\"' '$2 == session { for(i=4;i<=NF;i++) printf("%s ", $i); print "" }' "$session_file" | tr -d '\n')
        kitty @ set-tab-title "$selected_container"
        eval "$command"
    else
        kitty @ set-tab-title "$(echo "$selected_container" | sed 's/ * (Distrobox)$//')"
        distrobox enter "$(echo "$selected_container" | sed 's/ * (Distrobox)$//')"
    fi
else
    echo "No container or session selected."
fi

