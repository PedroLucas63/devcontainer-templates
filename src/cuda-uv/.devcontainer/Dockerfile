FROM nvidia/cuda:13.1.1-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

# Base system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    git \
    sudo \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    bash \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# Create vscode user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN if ! id -u "${USERNAME}" >/dev/null 2>&1; then \
        if getent group "${USERNAME}" >/dev/null 2>&1; then \
            USER_GROUP="${USERNAME}"; \
        elif getent group "${USER_GID}" >/dev/null 2>&1; then \
            USER_GROUP="$(getent group "${USER_GID}" | cut -d: -f1)"; \
        else \
            groupadd --gid "${USER_GID}" "${USERNAME}"; \
            USER_GROUP="${USERNAME}"; \
        fi; \
        if getent passwd "${USER_UID}" >/dev/null 2>&1; then \
            useradd --gid "${USER_GROUP}" -m "${USERNAME}"; \
        else \
            useradd --uid "${USER_UID}" --gid "${USER_GROUP}" -m "${USERNAME}"; \
        fi; \
    fi \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Install uv (system-wide)
ENV UV_INSTALL_DIR=/usr/local/bin
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# ---- Starship cache & logs (FIX DEFINITIVO) ----
ENV XDG_CACHE_HOME=/home/${USERNAME}/.cache
ENV STARSHIP_CACHE=/home/${USERNAME}/.cache/starship
ENV STARSHIP_LOG=error

# Set UV environment variables
ENV UV_LINK_MODE=copy

RUN mkdir -p /home/${USERNAME}/.cache/starship \
    && chown -R ${USERNAME} /home/${USERNAME}/.cache

# Init Starship for bash
RUN echo 'eval "$(starship init bash)"' >> /home/${USERNAME}/.bashrc

# Ensure home ownership
RUN chown -R ${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /workspaces

ENV PATH="/home/${USERNAME}/.local/bin:${PATH}"