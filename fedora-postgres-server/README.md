# 📦 Pull the Image

You can pull this container from **Quay.io** using:

### **Podman**
```sh
podman pull quay.io/sharishth/fedora-postgres-unofficial
```

### **Docker**
```sh
docker pull quay.io/sharishth/fedora-postgres-unofficial
```

---

# 🛠 Build the Image

To build the image locally, navigate to the **Dockerfile and Entrypoint Path**:

```sh
cd /path/to/DockerFile_and_Entrypoint
podman build -t fedora-postgres-unofficial:latest .
```

<p align="center"><b>OR</b></p>

Specify the Dockerfile path explicitly:

```sh
podman build -t fedora-postgres-unofficial:latest -f /path/to/Dockerfile
```

---

# 🚀 Execution

### **⚠️ Important Notes:**
- Environment variables like **POSTGRES_PASSWORD** and **PGDATA** are required to ensure the container runs correctly.
- You can **skip** the `-v` options and `--userns=keep-id` if you simply want to run the container without persistent storage.
- Host directory should exist before `-v` option is used and podman command is executed by the same user who created the directory.

---

## 📌 Storage Options

### **1️⃣ Persistent Storage (Podman Volume)**
> **Use this if you want PostgreSQL data to persist inside a Podman-managed volume.**
> The container’s installed packages and configurations will remain intact after stopping/restarting.

```sh
podman run -d --name postgres-persist \
  -e POSTGRES_PASSWORD=your_postgre_user_password \
  -e PGDATA=/var/lib/postgresql/data \
  -p 5432:5432 \
  --userns=keep-id \
  -v pg_data:/var/lib/postgresql/data:Z \
  fedora-postgres-unofficial
```

✅ **Why?**
- Podman manages the storage, keeping it isolated from the host.
- Ensures persistence across container restarts.
- Suitable when you don’t need to manually access PostgreSQL files.

---

### **2️⃣ Host Directory as Workspace (Direct Access)**
> **Use this if you only want PostgreSQL data to be stored directly on your host machine.**
> This makes it easier to back up or inspect files from outside the container.

```sh
podman run -d --name postgres-persist \
  -e POSTGRES_PASSWORD=your_postgre_user_password \
  -e PGDATA=/var/lib/postgresql/data \
  -p 5432:5432 \
  --userns=keep-id \
  -v /path/to/your-directory:/var/lib/postgresql/data-host:Z \
  fedora-postgres-unofficial
```

✅ **Why?**
- Allows direct access to PostgreSQL files from the host.
- Easier to create backups or inspect database files.
- Useful when working with other tools that need access to the data.

---

### **3️⃣ Combined Option (Best of Both Worlds)**
> **Use this if you want PostgreSQL to store data in both a Podman volume and a host directory.**
> This setup ensures database persistence inside Podman while also allowing external backups.

```sh
# Optional: Podman automatically creates the volume during "run"
podman volume create pg_data
```

```sh
podman run -d --name postgres-persist \
  -e POSTGRES_PASSWORD=your_postgre_user_password \
  -e PGDATA=/var/lib/postgresql/data \
  -p 5432:5432 \
  --userns=keep-id \
  -v pg_data:/var/lib/postgresql/data:Z \
  -v /path/to/your-directory:/var/lib/postgresql/data-host:Z \
  fedora-postgres-unofficial
```

✅ **Why?**
- **Podman volume (`pg_data`)** → PostgreSQL uses this as its main storage.
- **Host directory (`/home/sharishth/liferay-pg-data`)** → Allows manual backups and external access.
- Provides **data redundancy** and flexibility.

---

# 🎯 Final Notes
- `-v pg_data:/var/lib/postgresql/data:Z` → Stores PostgreSQL data inside a **Podman-managed volume**.
- `-v /home/sharishth/liferay-pg-data:/var/lib/postgresql/data-host:Z` → Saves PostgreSQL data directly on the **host machine**.
- **Both options can be combined** for increased flexibility and backup security.

---

🚀 **You're all set!** Let me know if you need further refinements! 🔥🔥
