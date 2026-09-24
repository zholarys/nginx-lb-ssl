#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p certs
if [[ -e certs/selfsigned.key || -e certs/selfsigned.crt ]]; then
    echo "Existing certificate/key found; move both aside before generating a new pair." >&2
    exit 1
fi
umask 077
openssl req -x509 -newkey rsa:2048 -nodes -days 30 \
  -keyout certs/selfsigned.key -out certs/selfsigned.crt \
  -subj '/CN=localhost' -addext 'subjectAltName=DNS:localhost,IP:127.0.0.1'
chmod 644 certs/selfsigned.crt
