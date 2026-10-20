FROM ghcr.io/xtls/xray-core:latest AS xray

# The official Xray image is distroless, so use Alpine for the shell-based
# startup script and copy in the official, statically linked Xray binary.
FROM alpine:3.22

RUN apk add --no-cache ca-certificates

COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY config.json /usr/local/etc/xray/config.json
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
