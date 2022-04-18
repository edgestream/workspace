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

ENV EXTRA_PACKAGES="git vim man"

# install extra packages
RUN apt-get install --yes ${EXTRA_PACKAGES}