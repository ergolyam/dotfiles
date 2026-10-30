#!/bin/ash
set -eu

out="/tmp/${NAME}-$(date +%F-%H%M%S).db"

sqlite3 /backup/x-ui.db ".backup ${out}"

sum="$(sha256sum ${out} | awk '{print $1}')"
text="#${NAME//-/_} v${XUI_VERSION:-unknown}
sha256sum: \`${sum}\`"

set -- --token "${TG_TOKEN}" --chat_id "${TG_CHAT_ID}" --caption "${text}"

if [ -n "${PROXY:-}" ]; then
    set -- "$@" --proxy "${PROXY}"
fi

exec uv run --offline --locked --script /app/script.py "$@" < "${out}"

