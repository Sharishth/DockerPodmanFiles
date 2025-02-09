#!/usr/bin/env bash
set -Eeo pipefail

# Ensure compatibility with Fedora-based container and Podman
export LANG=en_US.utf8

# Verify required environment variables
: "${PGDATA:?Environment variable PGDATA is not set}"
: "${POSTGRES_PASSWORD:?Environment variable POSTGRES_PASSWORD is not set}"

# Ensure PostgreSQL data directory exists
mkdir -p "$PGDATA"
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Run the initialization script if it exists
if [ -f "/usr/local/bin/docker-ensure-initdb.sh" ]; then
    /usr/local/bin/docker-ensure-initdb.sh
fi

# Check if we are running as root (which should NOT be the case)
if [ "$(id -u)" = "0" ]; then
    echo "Switching to postgres user..."
    exec runuser -u postgres -- "$@"
else
    echo "Already running as postgres, starting PostgreSQL..."
    exec "$@"
fi
