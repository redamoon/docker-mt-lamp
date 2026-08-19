#!/bin/bash
set -euo pipefail

# テーマ適用時に MT が mt-static/support/theme_static/<id> へコピーするファイルを、
# コンテナ起動のたびに themes/<id>/static から揃える（再作成後の 404 回避）。
MT_HOME="${MT_HOME:-/var/www/local/cgi-bin/mt}"
dest="${MT_HOME}/mt-static/support/theme_static"
mkdir -p "${dest}"

shopt -s nullglob
for static_dir in "${MT_HOME}"/themes/*/static; do
  theme_id="$(basename "$(dirname "${static_dir}")")"
  mkdir -p "${dest}/${theme_id}"
  cp -a "${static_dir}/." "${dest}/${theme_id}/"
done
