#!/bin/sh
set -eu

out="/tmp/${NAME}-$(date +%F-%H%M%S).db"

sqlite3 /backup/x-ui.db ".backup ${out}"

sum="$(sha256sum ${out} | awk '{print $1}')"
text="#${NAME//-/_} sha256sum: \`${sum}\`"

exec uv run --offline --locked --script /app/script.py \
	--token "${TG_TOKEN}" \
	--chat_id "${TG_CHAT_ID}" \
	--caption "${text}" \
	< "${out}"
