FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive
ENV DEFAULT_USER=ubuntu
ENV DEFAULT_HOME=/home/${DEFAULT_USER}

# unminimize base system
RUN yes | unminimize 2>&1

# get package indices
RUN apt-get update

# sudo
RUN apt-get install --yes sudo

# add default user
RUN adduser --gecos 'Default user' --disabled-password ${DEFAULT_USER}
RUN adduser ${DEFAULT_USER} sudo
RUN echo "${DEFAULT_USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/10-${DEFAULT_USER}-nopasswd

# dependencies
RUN apt-get install --yes curl bash-completion

# vim
RUN apt-get install --yes vim

# git
RUN apt-get install --yes git

# kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install --yes kubectl

# flux
RUN curl --location https://fluxcd.io/install.sh | bash
RUN echo "source <(flux completion bash)" >> /etc/skel/.bashrc

# node
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get update
RUN apt-get install --yes --no-install-recommends nodejs

# yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > /usr/share/keyrings/yarnkey.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install --yes --no-install-recommends yarn

# mongosh
RUN curl -sL https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - 2>/dev/null
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-5.0.list
RUN apt-get update
RUN apt-get install --yes --no-install-recommends mongodb-mongosh

# codespace-theme
COPY src/etc/profile.d/codespace-theme.sh /etc/profile.d/
RUN echo "source /etc/profile.d/codespace-theme.sh" >> /etc/skel/.bashrc

# copy init script
COPY src/* /

# change into default user context
USER ${DEFAULT_USER}
WORKDIR ${DEFAULT_HOME}

# entry-point
ENTRYPOINT ["/usr/bin/bash", "/init.sh"]