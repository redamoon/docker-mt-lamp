# オンボーディング: `psgi`（Apache + Starman）

Apache をリバースプロキシ、Starman をアプリサーバーにする本番寄り骨格です。**未検証の構成**なので、ブラウザ到達の確認は先に [psgi-dev](./psgi-dev.md) を推奨します。

## このモードの特徴

- 手前: Apache（HTTP / HTTPS）
- 奥: Starman（PSGI・プロセス常駐）
- 管理画面 URL は cgi と同じく `/cgi-bin/mt/mt.cgi`
- `WEB_PORT` を使うため **`psgi-nginx` と同時起動不可**

## 前提

共通セットアップは [AGENTS.md の Setup](../../AGENTS.md#setup) を完了してください。

- 設定ファイル: `mt-settings/mt-config.cgi.psgi`
- Compose profile: `psgi`
- 任意: `.env` の `STARMAN_WORKERS`（デフォルト `2`）

## セットアップ手順

1. `.env` を用意する

```bash
cp .env.sample .env
```

```dotenv
COMPOSE_PROFILES=psgi
WEB_PORT=10000:80
HTTPS_PORT=10443:443
STARMAN_WORKERS=2
```

2. `mt-settings/mt-config.cgi.psgi` に DB 情報を入れる  
   sample の `CGIPath` は `http://localhost:10000/cgi-bin/mt/` 想定です。  
   HTTPS で CSS を揃えるときは `https://localhost:10443/cgi-bin/mt/` に合わせてください。

3. MT zip を `docker/mt-data` に配置する

4. HTTPS 用証明書を生成する

```bash
./docker/nginx/gen-local-cert.sh
```

5. 他モードを止めてビルド・起動する

```bash
./d-down.sh
COMPOSE_PROFILES=psgi ./d-build.sh
COMPOSE_PROFILES=psgi ./d-up.sh
```

## 起動・停止・リロード

```bash
./d-up.sh
./d-down.sh
```

プラグイン差し替え後は Starman 再起動が必要です。

```bash
docker compose restart psgi-app
```

## URL

| 画面 | HTTP | HTTPS |
|------|------|-------|
| 公開サイト | http://localhost:10000/ | https://localhost:10443/ |
| 管理画面 | http://localhost:10000/cgi-bin/mt/mt.cgi | https://localhost:10443/cgi-bin/mt/mt.cgi |
| Data API | http://localhost:10000/cgi-bin/mt/mt-data-api.cgi | https://localhost:10443/cgi-bin/mt/mt-data-api.cgi |
| mt-static | http://localhost:10000/cgi-bin/mt/mt-static/ | https://localhost:10443/cgi-bin/mt/mt-static/ |

## プラグイン開発

配置先: `mt-settings/plugins/<PluginName>/`  
常駐のため、差し替え後は `docker compose restart psgi-app` を想定してください。

## よくあるつまずき

- `psgi-nginx` とポート衝突 → どちらか一方だけ起動（先に `./d-down.sh`）
- HTTPS の CSS ずれ → `mt-config.cgi.psgi` の `CGIPath` を HTTPS に合わせる
- 起動や到達が不安定 → まず [psgi-dev](./psgi-dev.md) で確認してから戻る
- 証明書未生成 → `./docker/nginx/gen-local-cert.sh` のあと必要なら `./d-build.sh`

## 関連

- 索引: [docs/onboarding/README.md](./README.md)
- 全体手順: [AGENTS.md](../../AGENTS.md)
- 他モード: [cgi](./cgi.md) / [psgi-dev](./psgi-dev.md) / [psgi-nginx](./psgi-nginx.md)
- 関連 Issue: [#23](https://github.com/redamoon/docker-mt-lamp/issues/23)（nginx 手前は別モード）
