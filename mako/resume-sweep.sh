#!/usr/bin/env bash
set -euo pipefail

LOCKFILE="${XDG_RUNTIME_DIR:-/tmp}/mako-resume-sweep.lock"
exec 9>"$LOCKFILE" || true
flock -n 9 || exit 0

makoctl mode -r idle || true

mapfile -t IDS < <(makoctl list | awk '/^Notification [0-9]+:/{gsub(":","",$2); print $2}')

((${#IDS[@]}==0)) && exit 0

sleep 5

for id in "${IDS[@]}"; do
  makoctl dismiss -n "$id" 2>/dev/null || true
done

