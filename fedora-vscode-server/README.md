# Pull Image

```command```

# Execution

## Build Image

``` podman build -t fedora-vscode-unofficial:latest . ```

## Deploy

```podman run -d --name vscode-container -p 8080:8080 -p 2222:22 fedora-vscode-unofficial:latest```

On your browser visit:
- <u>localhost:8080</u>
- Login with password : **vscode**

For Remote Development on Visual Studio Code IDE, refer:
- [ Remote Development using SSH ](https://code.visualstudio.com/docs/remote/ssh)

## More deployment options

You may deploy in following ways, as per your use case.

*Note: You may expose extra ports when developing and testing front-end, back-end applications or API.*

### 1️⃣ Persistence Storage (Named Volume)

To ensure VS Code settings, extensions, and workspace data persist across container restarts, use a Podman volume:

<pre>
<code>
podman volume create vscode-data
podman run -d --name vscode-container \
  -p 8080:8080 -p 2222:22 \
  -v vscode-data:/home/vscode \
  fedora-vscode-unofficial:latest
</code>
</pre>

✅ What This Does:

- Creates a persistent Podman volume (vscode-data).
- Mounts it at /home/vscode, preserving user settings and workspace files.
- Survives container restarts and removals.

✅ Why?

- Stores all user data, including VS Code settings, installed extensions, and files.
- Ensures persistence even after the container is removed.
- No need to manually manage permissions.

### 2️⃣ Sharing a Host Directory as a Workspace Folder

If you want to use a folder from the host machine as the workspace inside the container, run:

<pre>
<code>
podman run -d --name vscode-container \
  -p 8080:8080 -p 2222:22 \
  --userns=keep-id \
  -v ~/my-projects:/home/vscode/workspace:Z \
  fedora-vscode-unofficial:latest
</code>
</pre>

*Note: Make sure host directory exists.*

✅ What This Does:

- Mounts ~/my-projects from the host machine to /home/vscode/workspace inside the container.
- Any files created/modified in the container will reflect on the host system.
- Ideal for working on existing projects without copying files.

✅ Why?

- Mounts the host directory (~/my-projects) into the container’s /home/vscode/workspace.
- Uses --userns=keep-id to match the user ID inside the container with your host user.
- The :Z flag ensures correct permissions on SELinux-enabled systems.

### 3️⃣ Combine Both (Persistence + Host Directory)

For full persistence and host directory access, use:

<pre>
<code>
podman volume create vscode-data
podman run -d --name vscode-container \
  -p 8080:8080 -p 2222:22 \
  --userns=keep-id \
  -v vscode-data:/home/vscode \
  -v ~/my-projects:/home/vscode/workspace:Z \
  fedora-vscode-unofficial:latest
</code>
</pre>

*Note: Make sure host directory exists.*


✅ What This Does:

- Preserves VS Code settings, installed extensions, and user config (vscode-data).
- Shares ```~/my-projects``` from the host machine as the workspace inside ```/home/vscode/workspace```.
- Provides a flexible, persistent, and portable development environment.

✅ Why?

- Keeps VS Code settings, extensions, and user data persistent (vscode-data).
- Allows seamless workspace access using the host directory.
- Fixes potential permission issues using --userns=keep-id.