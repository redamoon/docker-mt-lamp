# Local development environment

- Docker
- CeontOS 7
- Apache
- MySQL 5.7
- Perl
- PHP 7.2.9
- Movable Type

## Directory structure

<<<<<<< HEAD
```
- ./
  - .env 環境変数
  - .gitignore 除外ファイルの設定
  - README.md ドキュメント
  - docker-compose.yml
  - setup-mt7.sh
```

=======
>>>>>>> a11bd2a8d411d0a152461975f9a8895aecf3288e
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
docker exec -it web-apache /bin/bash
```

### Login MySQL

```
docker exec -it web-db /bin/bash
```