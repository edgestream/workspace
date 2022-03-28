IMAGE_REPO=edgestream
IMAGE_NAME=workspace
IMAGE_TAG=latest

DOCKER=docker
KUSTOMIZE=kustomize
KUBECTL=kubectl

apply:
	cd kustomization && $(KUSTOMIZE) build | $(KUBECTL) apply -f -
build:
	$(DOCKER) build --tag=$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) .
push:
	$(DOCKER) push $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)
