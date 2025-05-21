#!/bin/bash
wget https://github.com/RedisGrafana/grafana-redis-datasource/releases/download/v2.2.0/redis-datasource-2.2.0.zip
wget https://github.com/RedisGrafana/grafana-redis-app/releases/download/v2.2.1/redis-app-2.2.1.zip
wget https://github.com/RedisGrafana/grafana-redis-explorer/releases/download/v2.1.1/redis-explorer-app-2.1.1.zip
wget https://github.com/Altinity/clickhouse-grafana/releases/download/v3.0.0/vertamedia-clickhouse-datasource-3.0.0.zip
mkdir -p plugins
unzip redis-datasource-2.2.0.zip -d plugins
unzip redis-app-2.2.1.zip -d plugins
unzip redis-explorer-app-2.1.1.zip -d plugins
unzip vertamedia-clickhouse-datasource-3.0.0.zip -d plugins
# shellcheck disable=SC2035
rm -rf *.zip
