# 🚀 DockerPodmanFiles  

[![Docker Compatible](https://img.shields.io/badge/Docker-Compatible-blue?logo=docker)](https://www.docker.com/)
[![Podman Compatible](https://img.shields.io/badge/Podman-Compatible-purple?logo=redhat)](https://podman.io/)
[![MIT License](https://img.shields.io/github/license/yourusername/DockerPodmanFiles)](LICENSE)

A collection of useful **Dockerfiles** and **Containerfiles** that can be built with **Podman** or **Docker** to create images tailored for specific use cases.  

---

## 📂 Repository Structure  

Each folder follows the naming convention:  


| Folder Name  | Description |
|----------------------------------|-------------|
| `fedora-postgres-server` | PostgreSQL database container based on Fedora. |
| `fedora-vscode-server`   | VS Code server container running on Fedora. |
| `fedora-<new-application>-unofficial` | Template for additional use cases. |

Each folder contains:  

- `Dockerfile` – The main container configuration file.  
- `README.md` – Instructions for pulling, building, and deploying the image.  

---

## 🛠 Usage  

You can build and run any of the provided images using **Podman** or **Docker**.

### 🔹 **Building an Image**  
```sh
podman build -t my-image -f path/to/Dockerfile .
# OR
docker build -t my-image -f path/to/Dockerfile .
# OR 
# refer to README in folder
```

### 🔹 Running a Container

Please refer to README's.

```sh
podman run --rm -it my-image
# OR
docker run --rm -it my-image
```

### 🔹 Pulling a Prebuilt Image (if available)

```sh
podman pull registry.example.com/my-image
# OR
docker pull registry.example.com/my-image
```

### 🔹 Deploying the Container (Example: PostgreSQL)

```sh
podman run -d -p 5432:5432 --name postgres-fedora -e POSTGRES_PASSWORD=your_secure_password fedora-postgres-unofficial
```

## 🎯 Why Use This Repository?

- [x] Preconfigured Images – Saves time by providing ready-to-use Dockerfiles.
- [x] Podman & Docker Compatible – Works seamlessly with both container runtimes.
- [x] Modular & Extendable – Easily customizable for different projects.
- [x] Best Practices – Secure and optimized configurations.

## 📢 Contributing

Contributions are welcome! Open an issue or pull request if you:

- Found a bug or have an improvement suggestion.
- Want to add a new Dockerfile for a specific use case.
- Need documentation improvements.