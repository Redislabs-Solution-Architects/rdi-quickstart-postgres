FROM postgres:13-bullseye

RUN echo "en_US ISO-8859-1" >> /etc/locale.gen && \
    locale-gen

COPY scripts/init_docker-postgres.sh /docker-entrypoint-initdb.d/

USER postgres

COPY scripts/chinook_create.sql /var/lib/postgresql/
COPY scripts/Chinook_PostgreSql.sql /var/lib/postgresql/

RUN export LANG=en_US.iso88591 && \
    initdb --encoding=latin1 --lc-collate=en_US.iso88591 --lc-ctype=en_US.iso88591

ENV LANG=en_US.iso88591
