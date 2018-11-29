# Local development environment

- Docker
- CeontOS 7
- Apache
- MySQL 5.7
- Perl
- PHP 7.2.9
- Movable Type

## Directory structure

```
- ./
  - .env 環境変数
  - .gitignore 除外ファイルの設定
  - README.md ドキュメント
  - docker-compose.yml
  - setup-mt7.sh（セットアップ用のコマンド作成予定）
  - docker/
    - Dockerfile  // Dockerfile サーバのセットアップインストールなど記述
    - httpd/
      - virtualhost.conf  // VirtualHostの設定
    - mt-data/  MT本体を格納するディレクトリ
  - mt-settings/
    - mt-static/
      - mtml/ テーマで使用する静的ファイル
      - plugins/ プラグインで使用する静的ファイル
    - mt-config.cgi Movable Typeの設定ファイル
  - mtml/ テーマ本体（開発用テーマなど同梱）
  - sql/ DBのsqlデータ保存先
  - www/
    - html/  Movable Typeでファイルが出力されるドキュメントルート
    - logs/  Apacheのログ出力先
```

## Setup

1. .env.sampleを.envにリネーム
2. .env環境変数を設定
3. mt-settings/mt-config.cgiで設定したDB情報を入力
4. Movable Type本体のディレクトリ名をMT-7.0にしてzipにする
5. docker/mt-data 配下にMovable Typeをzipで配置

## docker-compose command

dockerで使用するコマンド一覧になります。<br>
起動やビルドやSSHログインなどは以下は参照してください。

### Start

```
docker-compose up -d
```

### Stop

```
docker-compose stop -d
```

### Shutdown

```
docker-compose down
```

### Start & Build Command

```
docker-compose up -d --build
```

### Login SSH Web

```
docker exec -it コンテナ名 /bin/bash
```

### Login MySQL

```
docker exec -it コンテナ名 /bin/bash
```
