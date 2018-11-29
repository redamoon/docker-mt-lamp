# Local development environment

- Docker
- CeontOS 7
- Apache
- MySQL 5.7
- Perl
- Movable Type

## Directory structure

```
- ./
  - .env 環境変数
  - .gitignore 除外ファイルの設定
  - README.md ドキュメント
  - docker-compose.yml
  - setup-mt7.sh
```

## docker-compose command

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
