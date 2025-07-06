ARG DISTRO
FROM ${DISTRO:-fedora}

ARG DISTRO
RUN if [ "$DISTRO" = "fedora" ]; then \
        CMD=dnf; \
        dnf -y update; \
    else \
        export DEBIAN_FRONTEND=noninteractive; \
        export TZ=Etc/UTC; \
        CMD=apt-get; \
        apt-get -y update; \
        apt-get -y install software-properties-common; \
        add-apt-repository ppa:neovim-ppa/unstable -y; \
    fi && \
    $CMD -y install ansible git sudo

ARG USERNAME=fedora
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
ENV USER=$USERNAME
WORKDIR /home/$USERNAME

ENV TERM=xterm-256color
ENV SHELL=/usr/bin/zsh

RUN git clone https://github.com/jazik/termenv.git && \
    cd termenv && \
    ansible-playbook -i hosts termenv.yml

CMD ["zsh"]
