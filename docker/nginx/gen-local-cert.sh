#!/usr/bin/env bash
set -euo pipefail

# ローカル参照用の自己署名証明書（SAN=localhost）。秘密鍵は git に含めない。
# cgi / psgi / psgi-nginx が同じ証明書を読む（パスは nginx 配下だが Apache も volume でマウントする）。
ROOT="$(cd "$(dirname "$0")" && pwd)"
CERT_DIR="${ROOT}/certs"
mkdir -p "${CERT_DIR}"

CONF="$(mktemp)"
trap 'rm -f "${CONF}"' EXIT

cat > "${CONF}" <<'EOF'
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[req_distinguished_name]
CN = localhost

[v3_req]
subjectAltName = DNS:localhost,IP:127.0.0.1
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
EOF

openssl req -x509 -nodes -newkey rsa:2048 -days 365 \
  -keyout "${CERT_DIR}/localhost.key" \
  -out "${CERT_DIR}/localhost.crt" \
  -config "${CONF}"

chmod 600 "${CERT_DIR}/localhost.key"
chmod 644 "${CERT_DIR}/localhost.crt"

echo "created ${CERT_DIR}/localhost.crt"
echo "created ${CERT_DIR}/localhost.key"
