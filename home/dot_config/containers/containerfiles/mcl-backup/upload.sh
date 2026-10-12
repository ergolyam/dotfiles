#!/bin/sh
set -eu

archive="$(readlink -f /backup/latest.tar.zst)"
sha256="$(sha256sum "${archive}" | cut -d" " -f1)"

exec uv run --offline --locked --script /app/script.py \
	--token "${TG_TOKEN}" \
	--chat_id "${TG_CHAT_ID}" \
	--caption "sha256sum: \`${sha256}\`" \
	< "${archive}"
