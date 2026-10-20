#!/bin/sh
set -eu

: "${PORT:?Railway must provide PORT}"
: "${UUID:?Set UUID in Railway Variables}"
: "${WS_PATH:?Set WS_PATH in Railway Variables}"

case "$PORT" in
  ''|*[!0-9]*) echo "PORT must be numeric" >&2; exit 1 ;;
esac

case "$UUID" in
  *[!0-9a-fA-F-]*) echo "UUID may contain only hexadecimal characters and hyphens" >&2; exit 1 ;;
esac
if [ "${#UUID}" -ne 36 ]; then
  echo "UUID must be a 36-character UUID" >&2
  exit 1
fi

case "$WS_PATH" in
  /*) ;;
  *) echo "WS_PATH must begin with /" >&2; exit 1 ;;
esac
case "$WS_PATH" in
  *[!A-Za-z0-9_./-]*) echo "WS_PATH may contain only letters, numbers, _, -, ., and /" >&2; exit 1 ;;
esac

# Values are restricted above so they are safe to substitute into JSON via sed.
sed -i "s|__RAILWAY_PORT__|$PORT|g; s|__CLIENT_UUID__|$UUID|g; s|__WS_PATH__|$WS_PATH|g" /usr/local/etc/xray/config.json

exec /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
