# Xray VLESS + WebSocket for Railway

This repository runs Xray behind Railway's public HTTPS networking. Railway terminates TLS; Xray listens on Railway's internal `PORT` using plain WebSocket. The actual UUID and WebSocket path are read from Railway Variables, not stored in Git.

## Deploy

1. In Railway, create a new project/service from the GitHub repository `xiaolai778/xray-railway`.
2. Railway should build from the included Dockerfile.
3. Open the service's Variables tab and add:
   - `UUID`: a newly generated UUID, such as one generated locally with PowerShell `[guid]::NewGuid()`.
   - `WS_PATH`: a private path that starts with a slash, such as `/a-random-path-7Kp9`.
4. Railway supplies `PORT` automatically; do not set it yourself unless Railway's UI specifically requires it.
5. In Settings → Networking, generate a Railway domain or attach your own domain.
6. Wait for the deployment to start successfully and check the deploy logs.

Never paste your UUID into a public source file. Keep the UUID and WS_PATH private and do not share them publicly.

## Client settings

- Protocol: VLESS
- Address: generated Railway domain (hostname only)
- Port: 443
- UUID: value of Railway variable `UUID`
- Encryption: none
- Transport: WebSocket
- Path: value of Railway variable `WS_PATH`
- TLS: enabled
- SNI/server name: same hostname

Xray uses `security: none` intentionally because TLS is terminated by Railway's public HTTPS endpoint. Do not configure Xray certificates for this setup.

## Troubleshooting

- If the deploy exits immediately, check that `UUID` is a valid 36-character UUID and `WS_PATH` starts with `/`.
- If the domain is reachable but the client cannot connect, verify the domain, TLS, SNI and WebSocket path match exactly.
- Platform policies, availability, and service limits may change.
