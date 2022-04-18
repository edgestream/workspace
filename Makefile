IMAGE_REGISTRY=docker.io
IMAGE_PROJECT=edgestream
IMAGE_REPOSITORY=workspace
IMAGE_TAG=latest

KUBECTL=$(shell which kubectl)
DOCKER=$(shell which docker)
SSH_KEYGEN=$(shell which ssh-keygen)

all: build push apply shell

apply: configmap.yaml secret.yaml | $(KUBECTL)
	$(KUBECTL) apply -f configmap.yaml
	$(KUBECTL) apply -f secret.yaml
	$(KUBECTL) apply -k kubernetes

build: | $(DOCKER)
	$(DOCKER) build --tag=$(IMAGE_REGISTRY)/$(IMAGE_PROJECT)/$(IMAGE_REPOSITORY):$(IMAGE_TAG) .

clean:
	-rm -rf ssh_host_rsa_key ssh_host_rsa_key.pub configmap.yaml secret.yaml

delete: | $(KUBECTL)
	$(KUBECTL) delete -k kubernetes

push: | $(DOCKER)
	$(DOCKER) push $(IMAGE_REGISTRY)/$(IMAGE_PROJECT)/$(IMAGE_REPOSITORY):$(IMAGE_TAG)

shell: | $(KUBECTL)
	@$(KUBECTL) exec service/workspace --stdin=true --tty=true -- bash

configmap.yaml: ssh_host_rsa_key.pub $(HOME)/.ssh/id_rsa.pub | $(KUBECTL)
	$(KUBECTL) create configmap workspace-ssh-host-key-public --from-file=ssh_host_rsa_key.pub=ssh_host_rsa_key.pub --dry-run='client' --output='yaml' > $@
	echo "---" >> $@
	$(KUBECTL) create configmap workspace-ssh-user-key-public --from-file=authorized_keys=$(HOME)/.ssh/id_rsa.pub --from-file=id_rsa.pub=$(HOME)/.ssh/id_rsa.pub  --dry-run='client' --output='yaml' >> $@

secret.yaml: ssh_host_rsa_key | $(KUBECTL)
	$(KUBECTL) create secret generic workspace-ssh-host-key-private --from-file=ssh_host_rsa_key=$< --dry-run='client' --output='yaml' > $@

ssh_host_rsa_key ssh_host_rsa_key.pub: | $(SSH_KEYGEN)
	$(SSH_KEYGEN) -q -N "" -t rsa -b 4096 -f ssh_host_rsa_key