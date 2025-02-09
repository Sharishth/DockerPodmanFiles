# Execution

podman build -t fedora-postgres-unofficial:latest .
podman run -d -p 5432:5432 --name postgres-fedora -e POSTGRES_PASSWORD=your_secure_password fedora-postgres-unofficial

# Pull Image

Pull this container with the following Podman command:

```podman pull quay.io/sharishth/fedora-postgres-unofficial```

Pull this container with the following Docker command:

```Pull this container with the following Docker command:```