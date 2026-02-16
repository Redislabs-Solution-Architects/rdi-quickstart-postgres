FROM postgres:17

COPY scripts/init_docker-postgres.sh /docker-entrypoint-initdb.d/

USER postgres

COPY scripts/chinook_create.sql /var/lib/postgresql/
COPY scripts/Chinook_PostgreSql.sql /var/lib/postgresql/
COPY scripts/create_debezium_user.sql /var/lib/postgresql/

ENV LANG=en_US.UTF8
