# Or use fedora:41 as base image instead of fedora:latest
FROM fedora:latest

# Install dependencies
RUN dnf install -y \
    wget curl git nano openssh-server \
    && dnf clean all

# Create a non-root user for VS Code
RUN useradd -m -s /bin/bash vscode \
    && echo "vscode:vscode" | chpasswd \
    && mkdir -p /home/vscode/.ssh \
    && chown -R vscode:vscode /home/vscode

# Install VS Code Server as root
RUN mkdir -p /tmp/code-server \
    && curl -#fL -o /tmp/code-server/code-server.rpm https://github.com/coder/code-server/releases/download/v4.96.4/code-server-4.96.4-amd64.rpm \
    && rpm -U /tmp/code-server/code-server.rpm \
    && rm -rf /tmp/code-server

# Set up OpenSSH
RUN mkdir -p /run/sshd \
    && ssh-keygen -A \
    && echo "vscode ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set the VS Code Server password correctly for the vscode user
USER vscode
RUN mkdir -p /home/vscode/.config/code-server \
    && mkdir -p /home/vscode/workspace \
    && echo "bind-addr: 0.0.0.0:8080" > /home/vscode/.config/code-server/config.yaml \
    && echo "auth: password" >> /home/vscode/.config/code-server/config.yaml \
    && echo "password: vscode" >> /home/vscode/.config/code-server/config.yaml \
    && chmod 600 /home/vscode/.config/code-server/config.yaml

USER root
# Expose ports
EXPOSE 8080 22

# Start SSH and code-server as vscode user
CMD ["/bin/sh", "-c", "/usr/sbin/sshd && su vscode -c 'code-server --bind-addr 0.0.0.0:8080 --user-data-dir /home/vscode/.config'"]
