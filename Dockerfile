FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

# unminimize base system
RUN yes | unminimize 2>&1

# get package indices
RUN apt-get update

# installer dependencies
RUN apt-get install --yes curl gpg

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu focal stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update
RUN apt-get install --yes docker-ce

# kubectl
RUN curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install --yes kubectl

# kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
RUN mv kustomize /usr/local/bin/

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
RUN apt-get install --yes spf-tools-perl
RUN apt-get install --yes swaks

# editor
RUN apt-get install --yes vim

# development
RUN apt-get install --yes git

# codespace theme
COPY scripts/codespace-theme.sh /etc/profile.d/codespace-theme.sh

# volumes
VOLUME /root

# working directory
WORKDIR /root

# ports
EXPOSE 8080

# entry-point
ENTRYPOINT ["/usr/bin/sleep", "3650d"]
