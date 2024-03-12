#!/bin/bash

set -e

PGDATA=/var/lib/postgresql/data

echo "wal_level = logical" >> $PGDATA/postgresql.conf

psql -U postgres postgres -f ~/chinook_create.sql
psql -U postgres chinook -f ~/Chinook_PostgreSql.sql
psql -U postgres chinook -f ~/create_debezium_user.sql
