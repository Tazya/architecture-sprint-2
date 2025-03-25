# pymongo-api

## Как запустить

1. Перейдите в директорию с реализованными шардированными репликами mongo и кэшем redis   

```shell
cd sharding-repl-cache
```

2. Запустите mongodb и приложение   

```shell
docker compose up -d
```
Ожидайте некоторое время ~20 секунд, пока поднимутся все контейнеры

3. Инициализируем настройки шардирования

```shell
./scripts/mongo-shards-init.sh
```

4. Наполняем данными    

```shell
./scripts/mongo-seed.sh
```

## Как проверить

Откройте в браузере http://localhost:8080

### Проверка кэша

Дважды откройте в браузере http://localhost:8080/helloDoc/users
Второй запрос должен быть значительно быстрее первого


## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://localhost:8080/docs

# Схема сервиса

Схема сервиса расположена в файле `./sprint2_complete_scheme.drawio`