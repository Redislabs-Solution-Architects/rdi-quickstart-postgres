# RDI Quickstart PostgreSQL

Docker image referenced in the new RDI Quickstart Guide.

## Building the Image
- Clone the repo locally and `cd` into directory `rdi-quickstart-postgres`
- `docker build -t postgres_rdi_ingest:v0.1 .`

## Running a Container
If Debezium Server is running in a container on the same host, both containers must use a common network:
- `docker network create postgres`
- `docker run -d --rm --name postgres --network postgres --rm -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres_rdi_ingest:v0.1`

## Connecting to the Chinook Database
Use a standard database client, such as DBeaver:

![image](https://github.com/Redislabs-Solution-Architects/rdi-quickstart-postgres/assets/116373419/e6f98546-a815-41bb-8f23-43fd6955e973)

- Host = `localhost`
- Database = `chinook`
- Username/Password = `postgres/postgres`

You should see 11 tables in the `public` schema of database `chinook`:

<img width="455" alt="image" src="https://github.com/Redislabs-Solution-Architects/rdi-quickstart-postgres/assets/116373419/c4685f71-bb25-4e02-b9ee-09b3a6223b70">

## Debezium Server Configuration
The following settings specific to PostgreSQL must be included in `application.properties` for Debezium Server:
```
debezium.source.connector.class=io.debezium.connector.postgresql.PostgresConnector
debezium.source.plugin.name=pgoutput
debezium.source.offset.storage=io.debezium.server.redis.RedisOffsetBackingStore
debezium.source.topic.prefix=chinook
debezium.source.database.dbname=chinook
#If running Debezium Server as a container on the same host as PostgreSQL, hostname is 'postgres'
debezium.source.database.hostname=postgres
debezium.source.database.port=5432
debezium.source.database.user=dbzuser
debezium.source.database.password=dbz
debezium.source.publication.autocreate.mode=filtered
```
Sample command line for running Debezium Server as a container:

```docker run -it --rm --name debezium --network postgres -v $PWD/conf:/debezium/conf debezium/server:2.5.0.Final```

## Downloading/Pulling a Pre-built Image
[Tbd - we can store a saved version of the image (tar file) on S3 or (better) push the image to the redislabs repo on Dockerhub]
