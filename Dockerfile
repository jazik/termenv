ARG DISTRO
FROM $DISTRO

ARG DISTRO
RUN if [ "$DISTRO" == "fedora" ]; then \
        CMD=dnf; \
    else \
        CMD=apt-get; \
        apt-get -y update; \
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

RUN git clone https://github.com/jazik/termenv.git && \
    cd termenv && \
    ansible-playbook -i hosts termenv.yml

CMD ["zsh"]
