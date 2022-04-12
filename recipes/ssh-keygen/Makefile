SSH_KEYGEN=/usr/bin/ssh-keygen
APT_GET=/usr/bin/apt-get

all: install

clean:

install: $(SSH_KEYGEN)

$(SSH_KEYGEN):
	$(APT_GET) install --yes openssh-client