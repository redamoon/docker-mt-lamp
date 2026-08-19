#!/bin/bash
set -euo pipefail

export MT_HOME=/var/www/local/cgi-bin/mt
export PERL5LIB="${MT_HOME}/lib:${MT_HOME}/extlib:${PERL5LIB:-}"
cd "${MT_HOME}"

# 開発用: 公開 HTML も返し、mt 本体と開発プラグインの変更でリロードする
exec plackup \
  -I lib \
  -I extlib \
  -s HTTP::Server::PSGI \
  -p 5001 \
  -r \
  -R /var/www/local/mt-dev-plugins \
  mt-dev.psgi
