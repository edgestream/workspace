CILIUM=/usr/local/bin/cilium
TAR=/usr/bin/tar
CURL=/usr/bin/curl

all: install

clean:
	-rm cilium cilium-linux-amd64.tar.gz

install: $(CILIUM)

$(CILIUM): | cilium
	cp $| $@

cilium: | cilium-linux-amd64.tar.gz $(TAR)
	$(TAR) -xzf cilium-linux-amd64.tar.gz $@

cilium-linux-amd64.tar.gz: | $(CURL)
	$(CURL) -fsSLo $@ https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz