# Base image with CUDA 12 and cuDNN development headers
FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

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

# Install starship prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

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
RUN mkdir -p /home/$USERNAME/.cache && chown -R $USERNAME:$USERNAME /home/$USERNAME/.cache

# Create starship cache directory and ensure it's owned by the user
RUN mkdir -p /home/$USERNAME/.cache/starship \
    && chown -R $USERNAME:$USERNAME /home/$USERNAME/.cache
# Initialize Starship prompt in .bashrc
RUN echo 'eval "$(starship init bash)"' >> /home/$USERNAME/.bashrc

# Ensure the entire home directory is owned by the user
RUN chown -R $USERNAME:$USERNAME /home/$USERNAME

# Use the non-root user for development
USER $USERNAME
WORKDIR /workspaces

# Ensure ~/.local/bin is in PATH
ENV PATH="/home/$USERNAME/.local/bin:${PATH}"
