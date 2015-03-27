#!/bin/bash

DB_CONFIG=/etc/puppetdb/conf.d/database.ini

HOST=db
PORT=${DB_PORT_5432_TCP_PORT:-5432}
USER=${DB_ENV_POSTGRES_USER:-"postgres"}
PASS=${DB_ENV_POSTGRES_PASSWORD:-"password"}

cat > $DB_CONFIG << EOF
[database]
classname = org.postgresql.Driver
subprotocol = postgresql
subname = //${HOST}:${PORT}/puppetdb
username = ${USER}
password = ${PASS}
gc-interval = 60
log-slow-statements = 10
report-ttl = 5d
syntax_pgs = true
conn-keep-alive = 45
node-ttl = 5d
conn-lifetime = 0
node-purge-ttl = 7d
conn-max-age = 60
EOF
