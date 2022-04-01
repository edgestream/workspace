IMAGE_REGISTRY=docker.io
IMAGE_PROJECT=edgestream
IMAGE_REPOSITORY=workspace
IMAGE_TAG=latest

DOCKER=docker
KUSTOMIZE=kustomize
KUBECTL=kubectl

apply:
	cd kustomization && $(KUSTOMIZE) build | $(KUBECTL) apply -f -
build:
	$(DOCKER) build --tag=$(IMAGE_REGISTRY)/$(IMAGE_PROJECT)/$(IMAGE_REPOSITORY):$(IMAGE_TAG) .
push:
	$(DOCKER) push $(IMAGE_REGISTRY)/$(IMAGE_PROJECT)/$(IMAGE_REPOSITORY):$(IMAGE_TAG)
