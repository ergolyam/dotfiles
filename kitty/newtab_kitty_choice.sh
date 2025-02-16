#!/bin/bash

session_file="$HOME/sessions.conf"
declare -a containers=("Host")
TERM=xterm-256color
distrobox_root_mode=0

GRAY='\e[1;90m'
RED='\e[31m'
RESET='\e[0m'

if command -v toolbox >/dev/null 2>&1; then
    toolbox_containers=$(toolbox list --containers | tail -n +2 | awk '{printf "%-21s (Toolbox)\n", $2}')
    if [ -n "$toolbox_containers" ]; then
        while IFS= read -r line; do
            containers+=("$line")
        done <<< "$toolbox_containers"
    fi
else
    containers+=("${RED}Toolbox is not installed${RESET}")
fi

if command -v distrobox >/dev/null 2>&1; then
    distrobox_containers=$(distrobox list | tail -n +2 | awk -F'|' '{print $2 " (Distrobox)"}' | sed '/^\s*$/d' | sed 's/^[ \t]*//;s/[ \t]*$//')
    if [ -n "$distrobox_containers" ]; then
        while IFS= read -r line; do
            containers+=("$line")
        done <<< "$distrobox_containers"
    fi
else
    containers+=("${RED}Distrobox is not installed${RESET}")
fi

if [ -f "$session_file" ]; then
    while IFS= read -r line; do
        if [[ $line =~ ^\"([^\"]+)\"\ \"([^\"]+)\"$ ]]; then
            name="${BASH_REMATCH[1]}"
            containers+=("$name")
        fi
    done < "$session_file"
fi

if [ "$distrobox_root_mode" -eq 0 ] && command -v distrobox >/dev/null 2>&1; then
    containers+=("${GRAY}Activate Distrobox Root Mode${RESET}")
fi

while true; do
    selected_container=$(printf '%b\n' "${containers[@]}" | fzf --ansi --prompt="Select a session: " --height=100% --layout=reverse --border --info=inline --padding=5% --margin=5% --info=hidden)
    selected_container=$(echo "$selected_container" | sed 's/\x1b\[[0-9;]*m//g')
    
    if [ "$selected_container" == "Host" ]; then
        kitty @ set-tab-title "Host"
        exec "$SHELL"
    elif [ "$selected_container" == "Toolbox is not installed" ]; then
        echo "Toolbox is not installed."
        exit 0
    elif [ "$selected_container" == "Distrobox is not installed" ]; then
        echo "Distrobox is not installed."
        exit 0
    elif [ "$selected_container" == "Activate Distrobox Root Mode" ]; then
        if sudo -v; then
            distrobox_root_containers=$(distrobox list --root | tail -n +2 | awk -F'|' '{print $2 " (Distrobox-Root)"}' | sed '/^\s*$/d' | sed 's/^[ \t]*//;s/[ \t]*$//')
            if [ -n "$distrobox_root_containers" ]; then
                while IFS= read -r line; do
                    containers+=("$line")
                done <<< "$distrobox_root_containers"
                filtered_containers=()
                for item in "${containers[@]}"; do
                    if [[ "$item" != "${GRAY}Activate Distrobox Root Mode${RESET}" ]]; then
                        filtered_containers+=("$item")
                    fi
                done
                containers=("${filtered_containers[@]}")
                distrobox_root_mode=1
                echo "Distrobox Root Mode activated."
            else
                echo "No Distrobox-Root containers found."
            fi
        else
            echo "Failed to activate Distrobox Root Mode."
        fi
    elif [[ "$selected_container" == *" (Distrobox)" ]]; then
        container_name=$(echo "$selected_container" | sed 's/ * (Distrobox)$//')
        kitty @ set-tab-title "$container_name"
        distrobox enter "$container_name" -- env container_hostname=$container_name \
        /bin/sh -c 'if [ -n "$SHELL" ] && command -v "$SHELL" >/dev/null 2>&1; then
                      exec "$SHELL"
                    elif command -v bash >/dev/null 2>&1; then
                      exec bash
                    else
                      exec sh
                    fi'
        exit 0
    elif [[ "$selected_container" == *" (Distrobox-Root)" ]]; then
        container_name=$(echo "$selected_container" | sed 's/ * (Distrobox-Root)$//')
        kitty @ set-tab-title "$container_name"
        distrobox enter --root "$container_name" -- env container_hostname=$container_name \
        /bin/sh -c 'if [ -n "$SHELL" ] && command -v "$SHELL" >/dev/null 2>&1; then
                      exec "$SHELL"
                    elif command -v bash >/dev/null 2>&1; then
                      exec bash
                    else
                      exec sh
                    fi'
        exit 0
    elif [[ "$selected_container" == *" (Toolbox)" ]]; then
        container_name=$(echo "$selected_container" | sed 's/ * (Toolbox)$//')
        kitty @ set-tab-title "$container_name"
        toolbox run -c "$container_name" env container_hostname=$container_name \
        /bin/sh -c 'if [ -n "$SHELL" ] && command -v "$SHELL" >/dev/null 2>&1; then
                      exec "$SHELL"
                    elif command -v bash >/dev/null 2>&1; then
                      exec bash
                    else
                      exec sh
                    fi'
        exit 0
    elif [ -n "$selected_container" ]; then
        if grep -q "^\"$selected_container\" " "$session_file" 2>/dev/null; then
            command=$(awk -v session="$selected_container" -F'"' '$2 == session { for(i=4;i<=NF;i++) printf("%s ", $i); print "" }' "$session_file" | tr -d '\n')
            kitty @ set-tab-title "$selected_container"
            eval "$command"
            exit 0
        else
            echo "No container or session selected."
            exit 0
        fi
    else
        echo "No container or session selected."
        exit 0
    fi
done

