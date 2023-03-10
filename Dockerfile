FROM debian:11 as base

ARG USERNAME=docker
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# base setup
RUN apt-get update -y && apt-get install -y curl build-essential

# node setup
RUN curl -sL https://deb.nodesource.com/setup_19.x | bash -
RUN apt-get -y install nodejs

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME

FROM base as dev

WORKDIR /code

CMD [ "/bin/bash" ]
