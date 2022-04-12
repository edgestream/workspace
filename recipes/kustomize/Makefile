KUSTOMIZE=/usr/local/bin/kustomize
CURL=/usr/bin/curl

all: install

clean:
	-rm kustomize install_kustomize.sh

install: $(KUSTOMIZE)

$(KUSTOMIZE): | kustomize
	cp $| $@

kustomize: | install_kustomize.sh
	./$|

install_kustomize.sh: | $(CURL)
	$(CURL) -fsSLo $@ https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh
	chmod +x $@