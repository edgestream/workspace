HELM=/usr/local/bin/helm
CURL=/usr/bin/curl

all: install

clean:
	-rm install_helm.sh

install: $(HELM)

$(HELM): | install_helm.sh
	./$| --no-sudo

install_helm.sh: | $(CURL)
	$(CURL) -fsSLo $@ "https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
	chmod +x $@