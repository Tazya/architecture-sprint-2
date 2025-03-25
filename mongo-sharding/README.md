# Задание № 2. pymongo-api sharded mongo

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Инициализируем шардированную монгу
```shell
./scripts/mongo-shards-init.sh
```

Заполняем mongodb данными

```shell
./scripts/mongo-seed.sh
```

Проверка количества документов
```shell
docker compose exec -it mongos_router mongosh --port 27020
 > use somedb;
 > db.helloDoc.countDocuments();
 > exit();
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs