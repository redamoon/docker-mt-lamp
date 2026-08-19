#!/bin/bash
set -euo pipefail

export MT_HOME=/var/www/local/cgi-bin/mt
export PERL5LIB="${MT_HOME}/lib:${MT_HOME}/extlib:${PERL5LIB:-}"
cd "${MT_HOME}"

# 本番寄り骨格。プラグイン差し替え後はコンテナ再起動が必要
exec starman \
  --listen :5001 \
  --workers "${STARMAN_WORKERS:-2}" \
  mt.psgi
