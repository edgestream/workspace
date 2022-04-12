HCLOUD=/usr/local/bin/hcloud
TAR=/usr/bin/tar
CURL=/usr/bin/curl

all: install

clean:
	-rm hcloud hcloud-linux-amd64.tar.gz

install: $(HCLOUD)

$(HCLOUD): | hcloud
	cp $| $@

hcloud: | hcloud-linux-amd64.tar.gz $(TAR)
	$(TAR) -xzf hcloud-linux-amd64.tar.gz $@

hcloud-linux-amd64.tar.gz: | $(CURL)
	$(CURL) -fsSLo $@ https://github.com/hetznercloud/cli/releases/download/v1.29.4/hcloud-linux-amd64.tar.gz