# Local development environment

Movable Type のローカル開発環境です。人間向けの入口はこの README、環境構築の詳細はエージェント／オンボーディング用資料に分離しています。

| 資料 | 対象 | 内容 |
|------|------|------|
| [README.md](./README.md)（本ページ） | 人間 | 概要・URL・各資料への遷移 |
| [AGENTS.md](./AGENTS.md) | 人間 / AI エージェント | 環境構築・起動・切替・運用手順 |
| [CLAUDE.md](./CLAUDE.md) | Claude Code | `@AGENTS.md` への入口 |

セットアップから始める場合は **[AGENTS.md](./AGENTS.md)** を開いてください。

## Stack

- Docker
- Rocky Linux 9
- Apache
- Nginx（`psgi-nginx` のみ。Starman の手前）
- MySQL 5.7
- Perl
- Movable Type
- Swagger
- Redocly

## URLs

| 起動アプリケーション | URL |
|----------------|------|
| Movable Type（cgi・デフォルト） | http://localhost:10000/cgi-bin/mt/mt.cgi |
| Movable Type（cgi・HTTPS） | https://localhost:10443/cgi-bin/mt/mt.cgi |
| 公開サイト（cgi / psgi / psgi-nginx） | http://localhost:10000/ |
| 公開サイト（cgi / psgi / psgi-nginx・HTTPS） | https://localhost:10443/ |
| Movable Type（psgi-dev） | http://localhost:5001/mt.cgi |
| 公開サイト（psgi-dev） | http://localhost:5001/ |
| Movable Type（psgi・骨格） | http://localhost:10000/cgi-bin/mt/mt.cgi |
| Movable Type（psgi・HTTPS） | https://localhost:10443/cgi-bin/mt/mt.cgi |
| Movable Type（psgi-nginx） | http://localhost:10000/cgi-bin/mt/mt.cgi |
| Movable Type（psgi-nginx・HTTPS） | https://localhost:10443/cgi-bin/mt/mt.cgi |
| Swagger Editor | http://localhost:8001 |
| Swagger UI | http://localhost:8002 |
| Redocly Redoc | http://localhost:8003 |

モード切替・管理画面一覧・証明書・プラグイン配置などは [AGENTS.md](./AGENTS.md) を参照してください。

## Quick start

詳細は [AGENTS.md の Setup](./AGENTS.md#setup) 以降にあります。最短の流れだけここに置きます。

```bash
cp .env.sample .env
# MT zip を docker/mt-data に配置し、mt-settings/mt-config.cgi を編集
./d-build.sh
./d-up.sh
```

HTTPS を使う場合は、起動前に `./docker/nginx/gen-local-cert.sh` が必要です。

## Related

- ドキュメント分離の方針: [#38](https://github.com/redamoon/docker-mt-lamp/issues/38)
