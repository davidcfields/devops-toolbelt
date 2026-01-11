FROM debian:bookworm-slim

# Minimal base for devcontainers (language-agnostic)
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    git \
    openssh-client \
    procps \
    less \
  && rm -rf /var/lib/apt/lists/*

# Non-root user is best practice for devcontainers
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
  && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
  && mkdir -p /workspaces \
  && chown -R $USERNAME:$USERNAME /workspaces

USER $USERNAME
WORKDIR /workspaces
SHELL ["/bin/bash", "-lc"]
