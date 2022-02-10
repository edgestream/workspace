REGISTRY_HOST=registry.edgestream.net
REGISTRY_PROJECT=edgestream

IMAGE_NAME=workspace
IMAGE_VERSION=latest

DOCKER=/usr/bin/docker
KUBECTL=/usr/bin/kubectl

all: build push install shell

build: Dockerfile
	$(DOCKER) build --tag=$(REGISTRY_HOST)/$(REGISTRY_PROJECT)/$(IMAGE_NAME):$(IMAGE_VERSION) .

install:
	$(KUBECTL) apply --filename=manifest
	$(KUBECTL) wait --for=condition=available deployment/workspace

push:
	$(DOCKER) push $(REGISTRY_HOST)/$(REGISTRY_PROJECT)/$(IMAGE_NAME):$(IMAGE_VERSION)

uninstall:
	$(KUBECTL) delete --filename=manifest

shell:
	$(KUBECTL) exec --stdin=true --tty=true svc/workspace -- bash

Dockerfile: src/init.sh src/etc/profile.d/codespace-theme.sh