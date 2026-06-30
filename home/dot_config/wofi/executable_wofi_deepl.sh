#!/bin/bash

DEEPL_API_URL="https://api-free.deepl.com/v2/translate"
HISTORY_DIR="$HOME/.local/share/wofi_deepl"
TARGET_LANG="en"

DEEPL_API_KEY_FILE="$HOME/.deepl_api"
if [[ -f "$DEEPL_API_KEY_FILE" ]]; then
    DEEPL_API_KEY="$(<"$DEEPL_API_KEY_FILE")"
else
    echo "Не найден файл с API-ключом: $DEEPL_API_KEY_FILE"
    exit 1
fi

to_upper_lang() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

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

    local lang_up
    lang_up=$(to_upper_lang "$TARGET_LANG")

    local translated_text
    translated_text=$(
        curl -s -X POST "$DEEPL_API_URL" \
            -H "Authorization: DeepL-Auth-Key $DEEPL_API_KEY" \
            --data-urlencode "text=$input_text" \
            -d "target_lang=$lang_up" \
        | jq -r '.translations[0].text'
    )

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
    if [[ "$input" =~ ^:([a-zA-Z]{2,3})\s*$ ]]; then
        local lang="${BASH_REMATCH[1]}"
        switch_language "$lang"
        exec "$0" --lang "$TARGET_LANG"
        return 0
    elif [[ "$input" =~ ^:([a-zA-Z]{2,3})\s*(.*) ]]; then
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

