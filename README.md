# RDI Quickstart PostgreSQL

Docker image referenced in the new RDI Quickstart Guide.

## Building the Image
- Clone the repo locally and `cd` into directory `rdi-quickstart-postgres`
- `docker build -t postgres_rdi_ingest:v0.1 .`

## Running a Container
- `docker run -d --rm --name postgres --rm -e POSTGRES_PASSWORD=postgres -p 5432:5432 postgres_rdi_ingest:v0.1`

## Connecting to the Chinook Database
Use a standard database client, such as DBeaver:

![image](https://github.com/Redislabs-Solution-Architects/rdi-quickstart-postgres/assets/116373419/5fb024eb-b5ef-4350-89f4-8682135cc456)

- Host = `localhost`
- Database = `chinook`
- Username/Password = `postgres/postgres` or `chinook/chinook`

You should see 11 tables in the `public` schema of database `chinook`:

<img width="455" alt="image" src="https://github.com/Redislabs-Solution-Architects/rdi-quickstart-postgres/assets/116373419/c4685f71-bb25-4e02-b9ee-09b3a6223b70">

## Downloading/Pulling a Pre-built Image
[Tbd - we can store a saved version of the image (tar file) on S3 or (better) push the image to the redislabs repo on Dockerhub]
