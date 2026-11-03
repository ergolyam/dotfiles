#!/usr/bin/env bash
set -euo pipefail
umask 077

: "${XUI_URL:?Не задан XUI_URL}"
: "${XUI_TOKEN:?Не задан XUI_TOKEN}"
: "${TG_BOT_TOKEN:?Не задан TG_BOT_TOKEN}"
: "${TG_CHAT_ID:?Не задан TG_CHAT_ID}"

STATE_FILE="$HOME/.local/state/vpn-expiry/sent.tsv"
DAYS_BEFORE=5

mkdir -p "$(dirname "$STATE_FILE")"
touch "$STATE_FILE"

now=$(date +%s)
from=$((now * 1000 + 1))
to=$(((now + DAYS_BEFORE * 86400) * 1000))

page=1
while true; do
  if ! response=$(curl -fsS --connect-timeout 10 --max-time 30 \
    -H "Authorization: Bearer $XUI_TOKEN" \
    "${XUI_URL%/}/panel/api/clients/list/paged?page=$page&pageSize=200&expiryFrom=$from&expiryTo=$to"); then
    echo "ERROR: Не удалось получить клиентов из 3x-ui API" >&2
    exit 1
  fi

  if ! jq -e '.success == true and (.obj.items | type == "array")' >/dev/null <<< "$response"; then
    echo "Ошибка: 3x-ui API вернул некорректный ответ" >&2
    exit 1
  fi

  count=$(jq '.obj.items | length' <<< "$response")
  echo "OK: 3x-ui API, страница $page, найдено клиентов: $count"

  jq -r '
    .obj.items[]
    | [.email, (.expiryTime | tostring),
       (.comment // "-" | if . == "" then "-" else . end | gsub("[\r\n\t]"; " "))]
    | @tsv
  ' <<< "$response" | while IFS=$'\t' read -r email expiry comment; do
    last=$(awk -F '\t' -v e="$email" '$1 == e { v = $2 } END { print v }' "$STATE_FILE")
    if [[ -n "$last" ]] && (( expiry <= last )); then
      continue
    fi

    days=$(((expiry - now * 1000 + 86400000 - 1) / 86400000))
    case "$days" in
      1) word="день" ;;
      2|3|4) word="дня" ;;
      *) word="дней" ;;
    esac

    message=$(printf 'У <b>%s</b> пользователя через %s %s истекает подписка!\nComment: %s' \
      "$email" "$days" "$word" "$comment")

    tg_response=$(curl -fsS --connect-timeout 10 --max-time 30 \
      --data-urlencode "chat_id=$TG_CHAT_ID" \
      --data-urlencode "parse_mode=HTML" \
      --data-urlencode "text=$message" \
      "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage")

    jq -e '.ok == true' >/dev/null <<< "$tg_response"
    printf '%s\t%s\n' "$email" "$expiry" >> "$STATE_FILE"

    echo "OK: Telegram уведомление отправлено: $email"
  done

  (( count < 200 )) && break
  (( page += 1 ))
done
echo "OK: Проверка подписок завершена"
