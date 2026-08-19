#!/bin/bash
set -euo pipefail

export MT_HOME=/var/www/local/cgi-bin/mt
export PERL5LIB="${MT_HOME}/lib:${MT_HOME}/extlib:${PERL5LIB:-}"
cd "${MT_HOME}"

/usr/local/bin/sync-theme-static.sh

# psgi-nginx: nginx が読む共有 volume へ mt-static を渡す（未設定なら何もしない）
if [ -n "${SHARE_MT_STATIC:-}" ]; then
  mkdir -p "${SHARE_MT_STATIC}"
  cp -a "${MT_HOME}/mt-static/." "${SHARE_MT_STATIC}/"
fi

# 本番寄り骨格。プラグイン差し替え後はコンテナ再起動が必要
exec starman \
  --listen :5001 \
  --workers "${STARMAN_WORKERS:-2}" \
  mt.psgi
