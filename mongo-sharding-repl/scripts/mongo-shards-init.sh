#!/bin/bash

###
# Инициализируем сервер конфигурации
###
docker compose exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate(
  {
    _id : "config_server",
       configsvr: true,
    members: [
      { _id : 0, host : "configSrv:27017" }
    ]
  }
);
exit()
EOF

###
# Инициализируем шард 1
###
docker compose exec -T shard1-1 mongosh --port 27018 <<EOF
rs.initiate(
    {
      _id : "shard1",
      members: [
        { _id : 0, host : "shard1-1:27018" },
        { _id : 1, host : "shard1-2:27019" },
        { _id : 2, host : "shard1-3:27020" }
      ]
    }
);
exit()
EOF

###
# Инициализируем шард 2
###
docker compose exec -T shard2-1 mongosh --port 27021 <<EOF
rs.initiate(
    {
      _id : "shard2",
      members: [
        { _id : 0, host : "shard2-1:27021" },
        { _id : 1, host : "shard2-2:27022" },
        { _id : 2, host : "shard2-3:27023" }
      ]
    }
);
exit()
EOF

###
# Инициализируем роутер
###
docker compose exec -T mongos_router mongosh --port 27030 <<EOF
sh.addShard( "shard1/shard1-1:27018");
sh.addShard( "shard1/shard1-2:27019");
sh.addShard( "shard1/shard1-3:27020");
sh.addShard( "shard2/shard2-1:27021");
sh.addShard( "shard2/shard2-2:27022");
sh.addShard( "shard2/shard2-3:27023");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
exit()
EOF