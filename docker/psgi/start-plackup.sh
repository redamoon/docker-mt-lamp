#!/bin/bash
set -euo pipefail

export MT_HOME=/var/www/local/cgi-bin/mt
export PERL5LIB="${MT_HOME}/lib:${MT_HOME}/extlib:${PERL5LIB:-}"
cd "${MT_HOME}"

# 開発用: mt 本体と bind mount した開発プラグインの変更でリロードする
exec plackup \
  -I lib \
  -I extlib \
  -s HTTP::Server::PSGI \
  -p 5000 \
  -r \
  -R /var/www/local/mt-dev-plugins \
  mt.psgi
