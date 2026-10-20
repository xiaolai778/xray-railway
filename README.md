# Xray VLESS + WebSocket for Railway

This repository runs Xray behind Railway's public HTTPS networking. Railway terminates TLS; Xray listens on the internal `$PORT` using plain WebSocket.

## Required edits before deploying

Edit `config.json` and replace:

- `REPLACE_WITH_YOUR_UUID` with a UUID generated for your client.
- `REPLACE_WITH_YOUR_PATH` with a private WebSocket path, including the leading slash (example: `/a-random-path`).

Do not commit actual secrets to a public repository. Because this repository is public, change the placeholders before use and keep the UUID/path private. For stronger privacy, change the repository to private after setup.

## Deploy on Railway

1. In Railway, create a new project/service from the GitHub repository `xiaolai778/xray-railway`.
2. Railway should build from the included Dockerfile.
3. In service Settings → Networking, generate a Railway domain (or attach your own domain).
4. Wait for the deployment to be healthy.

## Client settings

- Protocol: VLESS
- Address: generated Railway domain (hostname only)
- Port: 443
- UUID: same value as `config.json`
- Encryption: none
- Transport: WebSocket
- Path: same value as `config.json`
- TLS: enabled
- SNI/server name: same hostname

Xray uses `security: none` intentionally because TLS is terminated by Railway's public HTTPS endpoint. Do not configure Xray certificates for this setup.

## Notes

This setup assumes Railway's public networking forwards WebSocket traffic to the service port. The generated hostname and deployment logs should be checked after the first deploy. Platform policies, availability, and service limits may change.
