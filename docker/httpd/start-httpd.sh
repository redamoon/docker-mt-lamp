#!/bin/bash
set -euo pipefail

export MT_HOME=/var/www/local/cgi-bin/mt
/usr/local/bin/sync-theme-static.sh

# cgi / psgi の HTTPS。証明書は psgi-nginx と同じ docker/nginx/certs（未生成だと 443 の vhost が起動しない）
if [ -e /etc/httpd/modules/mod_ssl.so ]; then
  if [ ! -f /etc/httpd/certs/localhost.crt ] || [ ! -f /etc/httpd/certs/localhost.key ]; then
    echo "localhost 用の証明書がありません。ホストで ./docker/nginx/gen-local-cert.sh を実行してください。" >&2
    exit 1
  fi
fi

exec /usr/sbin/httpd -D FOREGROUND
