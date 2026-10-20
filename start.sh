#!/bin/sh
set -eu

if [ -z "${PORT:-}" ]; then
  echo "Railway PORT environment variable is missing" >&2
  exit 1
fi

sed -i "s/__RAILWAY_PORT__/${PORT}/" /usr/local/etc/xray/config.json
exec xray run -config /usr/local/etc/xray/config.json
