IMAGE_REGISTRY=docker.io
IMAGE_PROJECT=edgestream
IMAGE_REPOSITORY=workspace
IMAGE_TAG=latest

builddir=.build

KUBECTL=/usr/bin/kubectl
DOCKER=/usr/bin/docker
SSH_KEYGEN=/usr/bin/ssh-keygen
KUSTOMIZE=/usr/local/bin/kustomize

all: build push apply shell

apply: $(builddir)/workspace.yaml | $(KUBECTL)
	$(KUBECTL) apply -f $<

build: | $(DOCKER)
	$(DOCKER) build --tag=$(IMAGE_REGISTRY)/$(IMAGE_PROJECT)/$(IMAGE_REPOSITORY):$(IMAGE_TAG) .

clean:
	-rm -rf $(builddir)

delete: | $(builddir)/workspace.yaml $(KUBECTL)
	$(KUBECTL) delete -f $(builddir)/workspace.yaml

push: | $(DOCKER)
	$(DOCKER) push $(IMAGE_REGISTRY)/$(IMAGE_PROJECT)/$(IMAGE_REPOSITORY):$(IMAGE_TAG)

shell: | $(KUBECTL)
	@$(KUBECTL) exec service/workspace --stdin=true --tty=true -- bash

$(builddir)/workspace.yaml: $(builddir)/kustomization.yaml | $(KUSTOMIZE) $(builddir)
	$(KUSTOMIZE) build $(builddir) > $@

$(builddir)/kustomization.yaml: $(builddir)/configmap.yaml $(builddir)/secret.yaml | $(builddir)
	echo "apiVersion: kustomize.config.k8s.io/v1beta1" > $@
	echo "kind: Kustomization" >> $@
	echo "resources:" >> $@
	echo "- ../kustomization" >> $@
	echo "- configmap.yaml" >> $@
	echo "- secret.yaml" >> $@

$(builddir)/configmap.yaml: $(builddir)/ssh_host_rsa_key.pub | $(KUBECTL) $(builddir)
	$(KUBECTL) create configmap workspace-ssh-host-key-public --from-file=ssh_host_rsa_key.pub=$< --dry-run='client' --output='yaml' > $@

$(builddir)/secret.yaml: $(builddir)/ssh_host_rsa_key | $(KUBECTL) $(builddir)
	$(KUBECTL) create secret generic workspace-ssh-host-key-private --from-file=ssh_host_rsa_key=$< --dry-run='client' --output='yaml' > $@

$(builddir)/ssh_host_rsa_key $(builddir)/ssh_host_rsa_key.pub: | $(SSH_KEYGEN) $(builddir)
	$(SSH_KEYGEN) -q -N "" -t rsa -b 4096 -f $(builddir)/ssh_host_rsa_key

$(builddir):
	mkdir -p $@