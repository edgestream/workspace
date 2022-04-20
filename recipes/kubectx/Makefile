KUBECTX=/usr/local/bin/kubectx

TAR=$(shell which tar)
CURL=$(shell which curl)

all: install

clean:
	-rm kubectx kubectx_v0.9.4_linux_x86_64.tar.gz

install: $(KUBECTX)

$(KUBECTX): | kubectx
	cp $| $@

kubectx: | kubectx_v0.9.4_linux_x86_64.tar.gz
	$(TAR) -xf $| $@

kubectx_v0.9.4_linux_x86_64.tar.gz:
	$(CURL) -fsSLo $@ https://github.com/ahmetb/kubectx/releases/download/v0.9.4/kubectx_v0.9.4_linux_x86_64.tar.gz