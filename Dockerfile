FROM ghcr.io/xtls/xray-core:latest

COPY config.json /usr/local/etc/xray/config.json
COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]
