CLUSTERCTL=/usr/local/bin/clusterctl
CURL=/usr/bin/curl

all: install

clean:
	-rm clusterctl

install: $(CLUSTERCTL)

$(CLUSTERCTL): | clusterctl
	cp $| $@

clusterctl: | $(CURL)
	$(CURL) -fsSLo $@ https://github.com/kubernetes-sigs/cluster-api/releases/download/v1.1.3/clusterctl-linux-amd64
	chmod +x $@