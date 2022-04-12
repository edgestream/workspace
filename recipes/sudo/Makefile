SUDO=/usr/bin/sudo
APT_GET=/usr/bin/apt-get

all: install

clean:
	-rm 10-sudo-nopasswd

install: | $(SUDO) /etc/sudoers.d/10-sudo-nopasswd

/etc/sudoers.d/10-sudo-nopasswd: | 10-sudo-nopasswd /etc/sudoers.d
	cp 10-sudo-nopasswd $@

$(SUDO) /etc/sudoers.d:
	$(APT_GET) install --yes sudo

10-sudo-nopasswd:
	echo "%sudo ALL=(ALL) NOPASSWD:ALL" > $@