SUBMAKEFILES=$(wildcard */Makefile)
SUBMODULES=$(patsubst %/Makefile,%,$(SUBMAKEFILES))

.PHONY: $(SUBMODULES)

all: $(SUBMODULES)

clean:
	$(foreach submodule,$(SUBMODULES),make --directory $(submodule) clean;)

install: all

list:
	$(info $(SUBMODULES))

cilium: tar curl
clusterctl: curl
docker: curl gpg
flux: curl
hcloud: tar curl
helm: curl
kubectl: curl
kustomize: curl

$(SUBMODULES):
	make --directory $@ install