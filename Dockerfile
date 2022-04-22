FROM ubuntu

ENV DEBIAN_FRONTEND="noninteractive"

# gather package indices
RUN apt-get update
# upgrade packages
RUN apt-get upgrade --yes
# unminimize
RUN yes | unminimize
# install make
RUN apt-get install --yes make
# create a build directory
RUN mkdir build
# change current directory
WORKDIR /build
# copy recipes
COPY recipes .
# build all targets
RUN make install
# delete build directory
RUN rm -rf /build
# reset current directory
WORKDIR /
# install SSH server
RUN apt-get install --yes openssh-server
RUN rm /etc/ssh/ssh_host_*_key*
RUN mkdir /run/sshd
EXPOSE 22
# run SSH server
ENTRYPOINT /usr/sbin/sshd -D
# add default user
RUN adduser --gecos "Default User" --disabled-password ubuntu\
 && adduser ubuntu sudo

# shell
RUN apt-get install --yes command-not-found
RUN apt-get update
# text
RUN apt-get install --yes vim man
# networking
RUN apt-get install --yes inetutils-ftp inetutils-ping inetutils-talk inetutils-telnet inetutils-tools inetutils-traceroute bind9-dnsutils
# scvm
RUN apt-get install --yes git
# mail
RUN apt-get install --yes mutt
