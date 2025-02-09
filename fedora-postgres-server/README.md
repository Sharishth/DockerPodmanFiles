# Execution
podman build -t fedora-postgres-unofficial:latest .
podman run -d -p 5432:5432 --name postgres-fedora -e POSTGRES_PASSWORD=your_secure_password fedora-postgres-unofficial