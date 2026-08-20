# オンボーディング: `psgi-nginx`（nginx + Starman）

nginx をリバースプロキシ、Starman をアプリサーバーにするモードです。静的ファイルは nginx、動的な `/cgi-bin/mt/` は Starman へ渡します。

> **注意:** CGI 全体を nginx 化する話ではありません。PSGI（Starman）の手前だけ nginx です。詳しくは [#23](https://github.com/redamoon/docker-mt-lamp/issues/23)。

## このモードの特徴

- 手前: nginx（HTTP / HTTPS、公開 HTML と `mt-static` を配信）
- 奥: Starman（`/cgi-bin/mt/` のみ）
- 管理画面 URL は cgi と同じく `/cgi-bin/mt/mt.cgi`
- `WEB_PORT` を使うため **`psgi` と同時起動不可**

## 前提

共通セットアップは [AGENTS.md の Setup](../../AGENTS.md#setup) を完了してください。

- 設定ファイル: `mt-settings/mt-config.cgi.psgi-nginx`
- Compose profile: `psgi-nginx`
- 任意: `.env` の `STARMAN_WORKERS`（デフォルト `2`）

## セットアップ手順

1. `.env` を用意する

```bash
cp .env.sample .env
```

```dotenv
COMPOSE_PROFILES=psgi-nginx
WEB_PORT=10000:80
HTTPS_PORT=10443:443
STARMAN_WORKERS=2
```

2. `mt-settings/mt-config.cgi.psgi-nginx` に DB 情報を入れる  
   使うスキームに合わせて `CGIPath` / `StaticWebPath` を調整してください  
   （HTTP: `http://localhost:10000/cgi-bin/mt/`、HTTPS: `https://localhost:10443/cgi-bin/mt/`）

3. MT zip を `docker/mt-data` に配置する

4. 証明書を生成する（必須。未生成だと 443 の vhost が読めず起動失敗）

```bash
./docker/nginx/gen-local-cert.sh
```

5. 他モードを止めてビルド・起動する

```bash
./d-down.sh
COMPOSE_PROFILES=psgi-nginx ./d-build.sh
COMPOSE_PROFILES=psgi-nginx ./d-up.sh
```

## 起動・停止・リロード

```bash
./d-up.sh
./d-down.sh
```

プラグイン差し替え後は Starman 再起動が必要です。

```bash
docker compose restart psgi-app-nginx
```

## URL

| 画面 | HTTP | HTTPS |
|------|------|-------|
| 公開サイト | http://localhost:10000/ | https://localhost:10443/ |
| 管理画面 | http://localhost:10000/cgi-bin/mt/mt.cgi | https://localhost:10443/cgi-bin/mt/mt.cgi |
| Data API | http://localhost:10000/cgi-bin/mt/mt-data-api.cgi | https://localhost:10443/cgi-bin/mt/mt-data-api.cgi |
| mt-static | http://localhost:10000/cgi-bin/mt/mt-static/ | https://localhost:10443/cgi-bin/mt/mt-static/ |

公開 HTML（`www/html`）と `mt-static` は nginx が返し、`/cgi-bin/mt/` だけ Starman へ渡します。

## プラグイン開発

配置先: `mt-settings/plugins/<PluginName>/`  
常駐のため、差し替え後は `docker compose restart psgi-app-nginx` を想定してください。

## よくあるつまずき

- `psgi` とポート衝突 → どちらか一方だけ（先に `./d-down.sh`）
- 証明書未生成で起動失敗 → `./docker/nginx/gen-local-cert.sh`
- HTTPS の CSS ずれ → `mt-config.cgi.psgi-nginx` のパスを HTTPS に合わせる
- 「nginx に CGI 全体を載せたい」→ このモードの対象外（別 Issue / 別ブランチの話）

## 関連

- 索引: [docs/onboarding/README.md](./README.md)
- 全体手順: [AGENTS.md](../../AGENTS.md)
- 他モード: [cgi](./cgi.md) / [psgi-dev](./psgi-dev.md) / [psgi](./psgi.md)
- Issue: [#23](https://github.com/redamoon/docker-mt-lamp/issues/23)
