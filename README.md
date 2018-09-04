# Local development environment

- Docker
- CeontOS 7
- Apache
- MySQL 5.7
- Perl
- PHP 7.2.9
- Movable Type

## Directory structure

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