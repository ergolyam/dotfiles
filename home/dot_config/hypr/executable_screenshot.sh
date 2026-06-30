#!/bin/bash

send_notification() {
    ACTION=$(notify-send "Screenshot" "$1" --action=y="Open to pinta")
    if [[ $ACTION == "y" ]]; then
        open_in_pinta
    fi
}

open_in_pinta() {
    TMP_PATH="$HOME/.var/app/com.github.PintaProject.Pinta/cache/tmp/tmp.png"
    wl-paste > $TMP_PATH
    flatpak run com.github.PintaProject.Pinta $TMP_PATH
}

get_selected_area() {
    slurp -d
}

get_active_window() {
    hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}

screenshot_fullscreen() {
    grim - | wl-copy
    send_notification "The screenshot of the fullscreen is sent to the clipboard."
}

screenshot_selected_area() {
    grim -g "$(get_selected_area)" - | wl-copy
    send_notification "The screenshot of a selected screen area is sent to the clipboard."
}

screenshot_active_window() {
    grim -g "$(get_active_window)" - | wl-copy
    send_notification "The screenshot of the active tile is sent to the clipboard."
}

show_help() {
    echo "Usage: $0 [option]"
    echo ""
    echo "Options:"
    echo "  -f, --fullscreen   Take a screenshot of the entire screen"
    echo "  -s, --select       Take a screenshot of a selected area"
    echo "  -w, --window       Take a screenshot of the active window"
    echo "  -h, --help         Show this help message"
}

case "$1" in
    -f|--fullscreen)
        screenshot_fullscreen
        ;;
    -s|--select)
        screenshot_selected_area
        ;;
    -w|--window)
        screenshot_active_window
        ;;
    -h|--help|*)
        show_help
        ;;
esac
