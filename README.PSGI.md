# Movable Type PSGI Implementation for Docker-MT-LAMP

このドキュメントでは、Docker-MT-LAMPでMovable TypeをPSGI環境で実行する方法について説明します。

## 概要

PSGI（Perl Web Server Gateway Interface）は、Perlウェブアプリケーションとウェブサーバーとの間の標準インターフェースです。PSGIを使用することで、Movable Typeのパフォーマンスと拡張性が向上します。

## 実装内容

このPRでは、以下の変更を行いました：

1. PSGI用のDockerfileの追加（`docker/psgi/Dockerfile.psgi`）
2. PSGI起動スクリプトの追加（`docker/psgi/start-psgi.sh`）
3. PSGI用のMovable Type設定ファイルの追加（`mt-settings/mt-config.cgi.psgi`）
4. PSGI対応のDocker Compose設定ファイルの追加（`docker-compose.psgi.yml`）

## 使用方法

### PSGIサービスの起動

```bash
docker compose -f docker-compose.psgi.yml up -d
```

これにより、通常のApacheベースのMovable Typeと並行して、ポート5002でPSGIサーバー（Starman）が起動します。

### アクセス方法

- PSGI版Movable Type: http://localhost:5002/
- 従来のCGI版Movable Type: http://localhost:11000/cgi-bin/mt/

## PSGI設定の詳細

### mt-config.cgi.psgi

PSGI用の設定ファイルには、以下のPSGI固有の設定が含まれています：

```
PSGIStreaming 1
PSGIServeStatic 1
```

- `PSGIStreaming`: 大きなレスポンスをストリーミングで返すことを有効にします
- `PSGIServeStatic`: 静的ファイルをPSGIサーバーから直接提供することを有効にします

## 利点

- パフォーマンスの向上: PSGIはCGIよりも高速で、リクエスト間でPerlインタプリタを再起動する必要がありません
- スケーラビリティの向上: 複数のワーカープロセスで並行処理が可能
- 柔軟性: さまざまなPSGIサーバー（Starman, Plack, uWSGI等）と互換性があります

## 注意点

- データベース設定は従来のCGI版と共有されます
- 本番環境では、NginxなどのWebサーバーをリバースプロキシとして使用することをお勧めします
