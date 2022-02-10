FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV DEFAULT_USER=ubuntu
ENV DEFAULT_HOME=/home/${DEFAULT_USER}

# get package indices
RUN apt-get update

# sudo
RUN apt-get install --yes sudo

# add default user
RUN adduser --gecos 'Default user' --disabled-password ${DEFAULT_USER}
RUN adduser ${DEFAULT_USER} sudo

# dependencies
RUN apt-get install --yes curl bash-completion

# kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install --yes kubectl

# flux
RUN curl --location https://fluxcd.io/install.sh | bash
RUN echo 'source <(flux completion bash)' >>/home/${DEFAULT_USER}/.bashrc

# run in default user context
USER ${DEFAULT_USER}
WORKDIR ${DEFAULT_HOME}

ENTRYPOINT ["/usr/bin/sleep", "3650d"]