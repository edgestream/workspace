FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# volumes
VOLUME /root

# unminimize base system
RUN yes | unminimize 2>&1

# get package indices
RUN apt-get update

# installer dependencies
RUN apt-get install --yes curl gpg

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

# code-server
RUN curl -sfLO https://github.com/coder/code-server/releases/download/v4.2.0/code-server_4.2.0_amd64.deb \
&& dpkg -i code-server_4.2.0_amd64.deb \
&& rm code-server_4.2.0_amd64.deb
RUN systemctl enable code-server@root 2>/dev/null
EXPOSE 8080

# flux
RUN curl -s https://fluxcd.io/install.sh | bash

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

# mongosh
RUN curl -sL https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - 2>/dev/null
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-5.0.list
RUN apt-get update
RUN apt-get install --yes --no-install-recommends mongodb-mongosh

# cqlsh
RUN curl -sL https://downloads.datastax.com/enterprise/cqlsh-astra-20201104-bin.tar.gz | tar -xzf - \
&& mkdir --parents /usr/share/dse/cassandra && mv cqlsh-astra/* /usr/share/dse/cassandra/ \
&& ln -s /usr/share/dse/cassandra/bin/cqlsh /usr/local/bin/cqlsh \
&& rm -rf cqlsh-astra

# operator-sdk
RUN curl -sLo /usr/local/bin/operator-sdk https://github.com/operator-framework/operator-sdk/releases/download/v1.18.1/operator-sdk_linux_amd64 \
&& chmod +x /usr/local/bin/operator-sdk

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
