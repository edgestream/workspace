DOCKER=/usr/bin/docker
CURL=/usr/bin/curl
GPG=/usr/bin/gpg
APT_GET=/usr/bin/apt-get

all: install

clean:
	-rm docker.list docker-archive-keyring.gpg

install: $(DOCKER)

$(DOCKER): | /etc/apt/sources.list.d/docker.list $(APT_GET)
	$(APT_GET) install --yes docker-ce-cli

/etc/apt/sources.list.d/docker.list: | docker.list
	cp $| $@
	$(APT_GET) update

docker.list: | /usr/share/keyrings/docker-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=$|] https://download.docker.com/linux/ubuntu focal stable" > $@

/usr/share/keyrings/docker-archive-keyring.gpg: | docker-archive-keyring.gpg
	cp $| $@

docker-archive-keyring.gpg: | $(CURL) $(GPG)
	$(CURL) -fsSL https://download.docker.com/linux/ubuntu/gpg | $(GPG) --dearmor -o $@