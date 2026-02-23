# Base image with CUDA 12 development headers
FROM nvidia/cuda:12.8.0-devel-ubuntu22.04

# Avoid interaction with apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install common system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    sudo \
    build-essential \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user 'vscode' with sudo access
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Install 'uv' globally (available to all users)
ENV UV_INSTALL_DIR=/usr/local/bin
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Set UV environment variables
ENV UV_CACHE_DIR=/home/$USERNAME/.cache/uv
ENV UV_LINK_MODE=copy
# Ensure the cache directory exists and is owned by the user
RUN mkdir -p /home/$USERNAME/.cache/uv && chown -R $USERNAME:$USERNAME /home/$USERNAME/.cache/uv

# Use the non-root user for development
USER $USERNAME
WORKDIR /workspaces

# Add UV to PATH (the install script typically puts it in ~/.local/bin if not specified)
# But since we used UV_INSTALL_DIR=/usr/local/bin, it should be already in path.
# Let's ensure ~/.local/bin is in path just in case.
ENV PATH="/home/$USERNAME/.local/bin:${PATH}"

# The actual Python management will be done by 'uv' within the workspace.
# We don't pre-install a specific Python here to let 'uv' handle it dynamically.
