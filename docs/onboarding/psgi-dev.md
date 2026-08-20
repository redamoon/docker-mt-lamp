# オンボーディング: `psgi-dev`（plackup）

開発用の PSGI モードです。管理画面と公開 HTML を同一ポートで確認したいときに使います。

## このモードの特徴

- plackup でアプリサーバー直公開（Apache / nginx の手前なし）
- 管理画面 URL は **`/mt.cgi`**（`/cgi-bin/mt/` ではない）
- **HTTP のみ**（このガイドでは HTTPS 対象外）
- ポートは `.env` の `APP_PORT`（デフォルト `5001`）。macOS の AirPlay が 5000 を使うため

## 前提

共通セットアップは [AGENTS.md の Setup](../../AGENTS.md#setup) を完了してください。

- 設定ファイル: `mt-settings/mt-config.cgi.psgi-dev`
- Compose profile: `psgi-dev`

## セットアップ手順

1. `.env` を用意し、profile を切り替える

```bash
cp .env.sample .env
```

```dotenv
COMPOSE_PROFILES=psgi-dev
APP_PORT=5001
```

2. `mt-settings/mt-config.cgi.psgi-dev` に DB 情報と `CGIPath` を合わせる  
   （sample 想定: `http://localhost:5001/`）

3. MT zip を `docker/mt-data` に配置する

4. 他モードが動いている場合は先に停止する

```bash
./d-down.sh
```

5. 初回は PSGI イメージをビルドして起動する

```bash
COMPOSE_PROFILES=psgi-dev ./d-build.sh
COMPOSE_PROFILES=psgi-dev ./d-up.sh
```

`.env` に `COMPOSE_PROFILES=psgi-dev` を書いていれば `./d-build.sh` / `./d-up.sh` だけで足ります。

## 起動・停止・リロード

```bash
./d-up.sh
./d-down.sh
```

プラグイン差し替え後、plackup のファイル監視でリロードを試みます。効かない場合:

```bash
docker compose restart web-psgi-dev
```

## URL

| 画面 | URL |
|------|-----|
| 公開サイト | http://localhost:5001/ |
| 管理画面 | http://localhost:5001/mt.cgi |
| インストールウィザード | http://localhost:5001/mt-wizard.cgi |
| 環境チェック | http://localhost:5001/mt-check.cgi |
| Data API | http://localhost:5001/mt-data-api.cgi |
| mt-static | http://localhost:5001/mt-static/ |

`/mt` は `Not Found` です。必ず `mt.cgi` を開いてください。

## 見た目（CSS）の確認

生成済み HTML のリンクは **MT のサイト URL（DB 側）** に従います。cgi で出したサイトは `http://localhost:10000/` のままが多いです。

`psgi-dev` で見た目まで確認するなら:

1. 管理画面でサイト URL を `http://localhost:5001/` にする
2. 再構築する

テーマ静的ファイルは起動時に `themes/<id>/static` から同期されます。

## プラグイン開発

配置先は他モードと同じく `mt-settings/plugins/<PluginName>/` です。  
プロセス常駐のため、差し替え後はリロード／`docker compose restart web-psgi-dev` を想定してください。

## よくあるつまずき

- ポート 5000 が使えない → `APP_PORT=5001` を確認
- 管理画面 404 → `/mt` ではなく `/mt.cgi`
- CSS が壊れる → サイト URL を `http://localhost:5001/` にして再構築
- 他モードと同時に起動できない／ポート衝突 → 先に `./d-down.sh`

## 関連

- 索引: [docs/onboarding/README.md](./README.md)
- 全体手順: [AGENTS.md](../../AGENTS.md)
- 他モード: [cgi](./cgi.md) / [psgi](./psgi.md) / [psgi-nginx](./psgi-nginx.md)
