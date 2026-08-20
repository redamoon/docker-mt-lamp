# オンボーディング: `cgi`（Apache CGI）

デフォルトの実行モードです。通常のローカル開発はここから始めてください。

## このモードの特徴

- Apache が CGI として Movable Type を実行する
- リクエストごとにプロセスが立ち上がるため、プラグイン差し替えは次のリクエストで反映されやすい
- HTTP（`WEB_PORT`）と HTTPS（`HTTPS_PORT`）の両方に対応

## 前提

共通セットアップは [AGENTS.md の Setup](../../AGENTS.md#setup) を完了してください。

- 設定ファイル: `mt-settings/mt-config.cgi`
- Compose profile: `cgi`

## セットアップ手順

1. `.env` を用意する

```bash
cp .env.sample .env
```

2. `.env` で次を確認する

```dotenv
COMPOSE_PROFILES=cgi
WEB_PORT=10000:80
HTTPS_PORT=10443:443
```

3. `mt-settings/mt-config.cgi` に DB 情報を入れる

4. MT zip を `docker/mt-data` に配置する

5. HTTPS を使う場合は証明書を生成する（未生成だと 443 で起動失敗）

```bash
./docker/nginx/gen-local-cert.sh
```

Apache 側で HTTPS を使う初回は `mod_ssl` のためイメージ再ビルドが必要です。

```bash
./d-build.sh
./d-up.sh
```

HTTPS なしで HTTP のみなら、証明書生成後でも HTTP だけで使えます。証明書未生成のまま HTTPS ポート付きで起動すると失敗します。

## 起動・停止

```bash
./d-build.sh   # 初回、または Dockerfile / MT zip 変更時
./d-up.sh
./d-down.sh    # 停止（DB・www/html は残る）
```

## URL

| 画面 | HTTP | HTTPS |
|------|------|-------|
| 公開サイト | http://localhost:10000/ | https://localhost:10443/ |
| 管理画面 | http://localhost:10000/cgi-bin/mt/mt.cgi | https://localhost:10443/cgi-bin/mt/mt.cgi |
| 環境チェック | http://localhost:10000/cgi-bin/mt/mt-check.cgi | https://localhost:10443/cgi-bin/mt/mt-check.cgi |
| Data API | http://localhost:10000/cgi-bin/mt/mt-data-api.cgi | https://localhost:10443/cgi-bin/mt/mt-data-api.cgi |
| mt-static | http://localhost:10000/cgi-bin/mt/mt-static/ | https://localhost:10443/cgi-bin/mt/mt-static/ |

`CGIPath` は相対 `/cgi-bin/mt/` なので、アクセスした Host（HTTP / HTTPS）に追従しやすいです。自己署名のため HTTPS ではブラウザ警告が出ます。

## プラグイン開発

配置先:

```
mt-settings/plugins/<PluginName>/
```

CGI モードではファイル差し替え後、**次のリクエストで新しいコードが使われます**（再ビルド不要）。管理画面の一覧が古い場合はブラウザ再読込か `./d-up.sh` で足りることが多いです。

詳細は [AGENTS.md のプラグイン開発](../../AGENTS.md#プラグイン開発)。

## よくあるつまずき

- HTTPS 起動失敗 → `./docker/nginx/gen-local-cert.sh` のあと `./d-build.sh`
- 公開ページの CSS がおかしい → 管理画面のサイト URL と実際のアクセス URL（`http://localhost:10000/` など）を合わせ、必要なら再構築
- Swagger から Data API を叩く → `mt-config.cgi` に `DataAPICORSAllowOrigin http://localhost:8002/`

## 関連

- 索引: [docs/onboarding/README.md](./README.md)
- 全体手順: [AGENTS.md](../../AGENTS.md)
- 他モード: [psgi-dev](./psgi-dev.md) / [psgi](./psgi.md) / [psgi-nginx](./psgi-nginx.md)
