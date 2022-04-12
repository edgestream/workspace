KUBECTL=/usr/bin/kubectl
CURL=/usr/bin/curl
APT_GET=/usr/bin/apt-get

all: install

clean:
	-rm kubernetes.list kubernetes-archive-keyring.gpg

install: $(KUBECTL)

$(KUBECTL): | /etc/apt/sources.list.d/kubernetes.list $(APT_GET)
	$(APT_GET) install --yes kubectl

/etc/apt/sources.list.d/kubernetes.list: | kubernetes.list
	cp $| $@
	$(APT_GET) update

kubernetes.list: | /usr/share/keyrings/kubernetes-archive-keyring.gpg
	echo "deb [signed-by=$|] https://apt.kubernetes.io/ kubernetes-xenial main" > $@

/usr/share/keyrings/kubernetes-archive-keyring.gpg: | kubernetes-archive-keyring.gpg
	cp $| $@

kubernetes-archive-keyring.gpg: | $(CURL)
	$(CURL) -fsSLo $@ https://packages.cloud.google.com/apt/doc/apt-key.gpg