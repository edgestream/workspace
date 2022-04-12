
# unminimize base system
RUN yes | unminimize 2>&1

# add default user
RUN adduser --gecos 'Default User' --disabled-password ubuntu

# get package indices
RUN apt-get update

# installer dependencies
RUN apt-get install --yes curl gpg

# sudo
RUN apt-get install --yes sudo
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/10-sudo-nopasswd
RUN adduser ubuntu sudo

# systemd
RUN apt-get install --yes systemd systemd-sysv dbus dbus-user-session

# ssh
RUN apt-get install --yes openssh-server
RUN rm /etc/ssh/ssh_host_*_key*
EXPOSE 22

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update
RUN apt-get install --yes docker-ce-cli

# kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install --yes kubectl

# helm
RUN curl -s "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3" | bash

# kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
RUN mv kustomize /usr/local/bin/

# flux
RUN curl -s https://fluxcd.io/install.sh | bash

# capi
RUN curl -fsSL -o /usr/local/bin/clusterctl https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.1.3/clusterctl-linux-amd64
RUN chmod +x /usr/local/bin/clusterctl

# cilium
RUN curl -fsSL https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz | tar -xzC /usr/local/bin

# hcloud
RUN curl -fsSL https://github.com/hetznercloud/cli/releases/download/v1.29.4/hcloud-linux-amd64.tar.gz | tar -xzC /usr/local/bin

# github-cli
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list
RUN apt-get update
RUN apt-get install -y gh

# node
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get update
RUN apt-get install --yes --no-install-recommends nodejs

# yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor > /usr/share/keyrings/yarnkey.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install --yes --no-install-recommends yarn

# openjdk
RUN apt-get install --yes openjdk-11-jdk
RUN echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment

# maven
RUN apt-get install --yes maven

# cqlsh
RUN curl -sL https://downloads.datastax.com/enterprise/cqlsh-astra-20201104-bin.tar.gz | tar -xzf - \
&& mkdir --parents /usr/share/dse/cassandra && mv cqlsh-astra/* /usr/share/dse/cassandra/ \
&& ln -s /usr/share/dse/cassandra/bin/cqlsh /usr/local/bin/cqlsh \
&& rm -rf cqlsh-astra

# base
RUN apt-get install --yes man

# shell
RUN apt-get install --yes command-not-found
RUN apt-get update

# networking
RUN apt-get install --yes iproute2
RUN apt-get install --yes inetutils-ftp
RUN apt-get install --yes inetutils-ping
RUN apt-get install --yes inetutils-telnet
RUN apt-get install --yes inetutils-traceroute
RUN apt-get install --yes dnsutils
RUN apt-get install --yes wget
RUN apt-get install --yes spf-tools-perl
RUN apt-get install --yes swaks
RUN apt-get install --yes mutt

# editor
RUN apt-get install --yes vim

# development
RUN apt-get install --yes git
RUN apt-get install --yes make
RUN apt-get install --yes jq

# codespace theme
COPY scripts/codespace-theme.sh /etc/profile.d/codespace-theme.sh

# working directory
WORKDIR /root

# execute entrypoint script
ENTRYPOINT [ "/usr/lib/systemd/systemd", "--system" ] 
