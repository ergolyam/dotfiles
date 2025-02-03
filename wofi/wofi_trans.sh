#!/bin/bash

HISTORY_DIR="$HOME/.local/share/wofi_trans"
TARGET_LANG="en"
TRANS="toolbox run -c arch trans"

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --lang) TARGET_LANG="$2"; shift ;;
    esac
    shift
done

HISTORY_FILE="$HISTORY_DIR/history_$TARGET_LANG"
mkdir -p "$HISTORY_DIR"
touch "$HISTORY_FILE"

translate_text() {
    local input_text="$1"
    [[ -z "$input_text" ]] && return

    input_text=$(echo "$input_text" | tr '\n' ' ')

    local translated_text
    translated_text=$($TRANS -brief ":$TARGET_LANG" "$input_text")

    echo "$input_text → $translated_text" | cat - "$HISTORY_FILE" > "$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"

    echo -n "$translated_text" | wl-copy

    exec "$0" --lang "$TARGET_LANG"
}

switch_language() {
    local new_lang="$1"
    TARGET_LANG="$new_lang"
    HISTORY_FILE="$HISTORY_DIR/history_$TARGET_LANG"
    touch "$HISTORY_FILE"
}

check_and_switch_language() {
    local input="$1"
    if [[ "$input" =~ ^:([a-zA-Z]{2,3})\s*(.*) ]]; then
        local lang="${BASH_REMATCH[1]}"
        local text="${BASH_REMATCH[2]}"
        switch_language "$lang"
        if [[ -n "$text" ]]; then
            translate_text "$text"
        fi
        return 0
    fi
    return 1
}

SELECTED=$(wofi --dmenu --cache-file /dev/null --prompt "Translate ($TARGET_LANG):" < "$HISTORY_FILE")

[[ -z "$SELECTED" ]] && exit 0

if check_and_switch_language "$SELECTED"; then
    exit 0
fi

if [[ "$SELECTED" == *"→"* ]]; then
    TRANSLATION=$(echo "$SELECTED" | awk -F '→ ' '{print $2}')
    echo -n "$TRANSLATION" | wl-copy
    exit 0
fi

translate_text "$SELECTED"

