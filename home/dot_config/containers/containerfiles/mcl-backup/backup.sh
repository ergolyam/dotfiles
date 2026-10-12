#!/bin/sh
set -eu

rm -f /backup/mineclonia-*.tar.zst /backup/latest.tar.zst

ts=$(date "+%Y-%m-%d_%H-%M-%S")
name="mineclonia-${ts}.tar.zst"
tar --zstd -cf "/backup/${name}" -C /data mcl-data mcl-db
ln -sfn "${name}" /backup/latest.tar.zst
