KUBENS=/usr/local/bin/kubens

TAR=$(shell which tar)
CURL=$(shell which curl)

all: install

clean:
	-rm kubens kubens_v0.9.4_linux_x86_64.tar.gz

install: $(KUBENS)

$(KUBENS): | kubens
	cp $| $@

kubens: | kubens_v0.9.4_linux_x86_64.tar.gz
	$(TAR) -xf $| $@

kubens_v0.9.4_linux_x86_64.tar.gz:
	$(CURL) -fsSLo $@ https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubens_v0.9.4_linux_x86_64.tar.gz