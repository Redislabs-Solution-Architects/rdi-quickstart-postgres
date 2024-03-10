#!/bin/bash

set -e

psql -U postgres postgres -f ~/chinook_create.sql
psql -U chinook chinook -f ~/Chinook_PostgreSql.sql
