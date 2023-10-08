FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

ENV USERNAME=vscode \
    USER_UID=1000 \
    USER_GID=1000 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    EDITOR=code \
    VISUAL=code \
    GIT_EDITOR="code --wait" \
    OPENVSCODE_SERVER_ROOT=/home/vscode \
    OPENVSCODE=/home/vscode/bin/openvscode-server

RUN sed -i "s@archive.ubuntu.com@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    sed -i "s@security.ubuntu.com@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list && \
    apt update && \
    apt install -y --no-install-recommends \
        curl \
        git \
        git-lfs \
        libatomic1 \
        locales \
        man \
        nano \
        net-tools \
        netcat \
        openssh-client \
        python3 \
        python3-pip \
        python3-venv \
        sudo \
        vim \
        wget \
        zsh \
    && git lfs install \
    && rm -rf /var/lib/apt/lists/*

RUN yes | sh -c "$(curl -fsSL https://ghproxy.com/https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

WORKDIR /home/

# Downloading the latest VSC Server release and extracting the release archive
# Rename `openvscode-server` cli tool to `code` for convenience
RUN RELEASE_TAG=$(curl -sX GET "https://api.github.com/repos/gitpod-io/openvscode-server/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
    arch=$(uname -m) && \
    if [ "${arch}" = "x86_64" ]; then \
        arch="x64"; \
    elif [ "${arch}" = "aarch64" ]; then \
        arch="arm64"; \
    elif [ "${arch}" = "armv7l" ]; then \
        arch="armhf"; \
    fi && \
    wget https://ghproxy.com/https://github.com/gitpod-io/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-${arch}.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-${arch}.tar.gz && \
    mv ${RELEASE_TAG}-linux-${arch} ${USERNAME} && \
    cp ${USERNAME}/bin/remote-cli/openvscode-server ${USERNAME}/bin/remote-cli/code && \
    rm -f ${RELEASE_TAG}-linux-${arch}.tar.gz

WORKDIR /home/workspace/

# Creating the user and usergroup
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USERNAME} -m -s /bin/bash ${USERNAME} \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

RUN chmod g+rw /home && \
    chown -R ${USERNAME}:${USERNAME} /home/workspace && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER $USERNAME

# Install VSCode Extensions
RUN ${OPENVSCODE} --install-extension ms-python.python && \
    ${OPENVSCODE} --install-extension monokai.theme-monokai-pro-vscode

EXPOSE 3000

ENTRYPOINT ["/bin/sh", "-c", "exec $OPENVSCODE --host 0.0.0.0 $@"]