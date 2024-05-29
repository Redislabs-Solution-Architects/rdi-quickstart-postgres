# RDI Quickstart PostgreSQL

Docker image referenced in the new RDI Quickstart Guide.

## Building the Image
- Clone the repo locally and `cd` into directory `rdi-quickstart-postgres`
- `docker build -t postgres_rdi_ingest:v0.1 .`

## Running a Container
If Debezium Server is running in a container on the same host, both containers must use a common network.
- `docker run -d --rm --name postgres --rm -e POSTGRES_PASSWORD=<postgres_password> -p 5432:5432 postgres_rdi_ingest:v0.1`

where `<postgres_password>` is a secure password of your choice.

## Running with Docker Compose
An alternative to building and running the container explicitly is to use  Docker Compose:
- Clone the repo locally and `cd` into directory `rdi-quickstart-postgres`
- Copy file `env` to `.env`
- add a complex password for user `postgres`
- `docker compose up -d`

> Note that PostgreSQL databases are a prime target for hackers. When deploying the container on a Cloud VM, you must ensure that only your IP is allowed in the firewall rule that opens port 5432.

## Connecting to the Chinook Database
Use a standard database client, such as DBeaver:

![image](https://github.com/Redislabs-Solution-Architects/rdi-quickstart-postgres/assets/116373419/e6f98546-a815-41bb-8f23-43fd6955e973)

- Host = `localhost`
- Database = `chinook`
- Username/Password = `postgres/<postgres_password>`

where `<postgres_password>` is the value of `POSTGRES_PASSWORD` in file `.env` (Docker Compose) or the password you specified when building the image.

You should see 11 tables in the `public` schema of database `chinook`:

<img width="455" alt="image" src="https://github.com/Redislabs-Solution-Architects/rdi-quickstart-postgres/assets/116373419/c4685f71-bb25-4e02-b9ee-09b3a6223b70">

## Generating Load on the Database
A script for simulating load on the PostgreSQL database is included. This adds new records to table `track`.

To run the script, ensure that file `env` has been copied to `.env`, then execute these commands:
```bash
cd scripts
python -m venv load
source ./load/bin/activate
pip install -r generate-load-requirements.txt
python generate_load.py &
```

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
