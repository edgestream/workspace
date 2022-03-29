# workspace
Workspace as a service

## Install

Run with [docker]:

```
docker run --name=workspace --detach harbor.edgestream.net/library/workspace:latest
```

Deploy on [kubernetes] with [kustomize]:

```
cd kustomization
kustomize build | kubectl apply -f -
```

## Usage

Enter workspace on [docker]:

```
docker exec --interactive --tty workspace bash
```

Enter workspace on [kubernetes]:

```
kubectl exec --stdin=true --tty=true svc/workspace -- bash
```

## Build

Use [docker] to build a new customized container image:

```
docker build --tag=<Your Registry>/workspace:latest .
```

Use [docker] to push the new image into the registry:

```
docker push <Your Registry>/workspace:latest
```
