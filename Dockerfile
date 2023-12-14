FROM nvidia/cuda:12.2.2-devel-ubuntu22.04

RUN apt update && \
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

WORKDIR /home/

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    EDITOR=code \
    VISUAL=code \
    GIT_EDITOR="code --wait" \
    OPENVSCODE_SERVER_ROOT=/home/.vscode \
    OPENVSCODE=/home/.vscode/bin/openvscode-server

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
    wget https://github.com/gitpod-io/openvscode-server/releases/download/${RELEASE_TAG}/${RELEASE_TAG}-linux-${arch}.tar.gz && \
    tar -xzf ${RELEASE_TAG}-linux-${arch}.tar.gz && \
    mv ${RELEASE_TAG}-linux-${arch} ${OPENVSCODE_SERVER_ROOT} && \
    cp ${OPENVSCODE_SERVER_ROOT}/bin/remote-cli/openvscode-server ${OPENVSCODE_SERVER_ROOT}/bin/remote-cli/code && \
    rm -f ${RELEASE_TAG}-linux-${arch}.tar.gz

# Install oh-my-zsh & Init
RUN yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install VSCode Extensions
RUN ${OPENVSCODE} --install-extension ms-python.python && \
    ${OPENVSCODE} --install-extension monokai.theme-monokai-pro-vscode

# Install python packages
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    rm -rf requirements.txt

ENTRYPOINT ["/bin/sh", "-c", "exec $OPENVSCODE $@"]
