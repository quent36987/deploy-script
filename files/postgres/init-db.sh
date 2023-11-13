#!/bin/sh
set -e

PG_DATA_PATH="/var/lib/postgresql/data"
SEED_PATH="/seed-bdd"

find /seed-bdd -name .gitkeep -exec rm {} \;

if [ ! -f "$PG_DATA_PATH/PG_VERSION" ]; then
    echo "Initialising database from seed..."
    cp -R "$SEED_PATH/"* "$PG_DATA_PATH/"
    ls "$PG_DATA_PATH/"
fi

# Exécuter le processus PostgreSQL normalement après l'initialisation
exec docker-entrypoint.sh postgres
