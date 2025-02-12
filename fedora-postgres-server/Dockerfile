FROM fedora:latest

# Set environment variables
ENV PGDATA=/var/lib/postgresql/data

# Update system and install dependencies
RUN dnf install -y --setopt=install_weak_deps=False \
    postgresql-server \
    postgresql-contrib \
    sudo \
    less \
    glibc-langpack-en \
    && dnf clean all

# Ensure PostgreSQL user exists before setting permissions
RUN id -u postgres &>/dev/null || useradd -r -m -d /var/lib/postgresql -s /bin/bash postgres

# Setup PostgreSQL directories with correct permissions
RUN install --verbose --directory --owner postgres --group postgres --mode 3777 /var/run/postgresql && \
    install --verbose --directory --owner postgres --group postgres --mode 0700 "$PGDATA"

# Copy entrypoint scripts and manually set permissions
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY docker-ensure-initdb.sh /usr/local/bin/docker-ensure-initdb.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh /usr/local/bin/docker-ensure-initdb.sh

# Set PostgreSQL user for runtime operations
USER postgres

# Expose PostgreSQL port
EXPOSE 5432

# Define PostgreSQL shutdown behavior
STOPSIGNAL SIGINT

# Set entrypoint script to handle initialization and startup
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["postgres"]
