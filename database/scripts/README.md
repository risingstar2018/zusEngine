Shell scripts for PostgreSQL connections

* `db-drop.sh` - drops zuswallet DB if it exists
* `db-init.sh` - creates and initializes zuswallet DB
* `db-console.sh` - connects to the the database using the PSQL console

These scripts assume the following environment variables are set up

* PGUSER
* PGPASSWORD
* PGHOST
* PGPORT
