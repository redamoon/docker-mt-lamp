# 明示的な MySQL データリセット。公開ファイル (www/html) は残します。
# 実行: ./d-reset-db.sh --yes
if [ "$1" != "--yes" ]; then
  echo "This deletes MySQL data in ./db-data."
  echo "Published files in ./www/html are kept."
  echo "Run: ./d-reset-db.sh --yes"
  exit 1
fi
docker compose down
rm -rf ./db-data
mkdir -p db-data
docker compose up -d
