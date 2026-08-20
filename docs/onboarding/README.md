# 実行モード別オンボーディング

Compose profile（実行モード）ごとの開発環境セットアップと使い方です。共通手順の全体像は [AGENTS.md](../../AGENTS.md) を参照してください。

| モード | 概要 | ガイド |
|--------|------|--------|
| `cgi` | Apache CGI（デフォルト・まずここ） | [cgi.md](./cgi.md) |
| `psgi-dev` | plackup（開発用 PSGI） | [psgi-dev.md](./psgi-dev.md) |
| `psgi` | Apache リバースプロキシ + Starman（骨格） | [psgi.md](./psgi.md) |
| `psgi-nginx` | nginx リバースプロキシ + Starman | [psgi-nginx.md](./psgi-nginx.md) |

## 共通の前提（全モード）

1. `.env.sample` を `.env` にコピーする
2. `mt-settings/` の該当 `mt-config` に DB 情報を入れる
3. Movable Type 本体 zip を `docker/mt-data` に置く
4. 詳細は [AGENTS.md の Setup](../../AGENTS.md#setup)

`psgi` と `psgi-nginx` は同じ `WEB_PORT` を使うため **同時起動しません**。切替時は先に `./d-down.sh` してください。
