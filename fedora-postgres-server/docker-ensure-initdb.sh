#!/usr/bin/env bash
set -Eeuo pipefail

# Ensure compatibility with Fedora-based container and Podman
export LANG=en_US.utf8

# Verify required environment variables
: "${PGDATA:?Environment variable PGDATA is not set}"
: "${POSTGRES_PASSWORD:?Environment variable POSTGRES_PASSWORD is not set}"

# Check if PostgreSQL has already been initialized
if [ -s "$PGDATA/PG_VERSION" ]; then
    DATABASE_ALREADY_EXISTS="true"
else
    DATABASE_ALREADY_EXISTS=""
fi

# Ensure PGDATA directory exists with correct permissions
mkdir -p "$PGDATA"
chown -R postgres:postgres "$PGDATA"
chmod 700 "$PGDATA"

# Only initialize database if it doesn't exist
if [ -z "$DATABASE_ALREADY_EXISTS" ]; then
    echo "Initializing PostgreSQL database..."
    
    initdb --username=postgres --pwfile=<(echo "$POSTGRES_PASSWORD") --auth=md5 "$PGDATA"

    # Configure PostgreSQL to accept connections from all IPs
    echo "listen_addresses='*'" >> "$PGDATA/postgresql.conf"
    
    # Allow local and password-based connections
    cat > "$PGDATA/pg_hba.conf" <<EOF
local   all             all                                     trust
host    all             all             0.0.0.0/0               md5
host    all             all             ::/0                    md5
EOF

    echo "Database initialization complete."
else
    echo "Database already initialized. Skipping initdb."
fi
