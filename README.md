# workspace
Workspace as a service

## Install

Run in a local [docker] container:

```
docker run --name=workspace --detach registry.edgestream.net/edgestream/workspace:latest
```

Or apply [kubernetes] manifests to deploy the service:

```
kubectl apply --filename=manifest
```

## Usage

Use [docker] to execute the "bash" shell:

```
docker exec --interactive --tty workspace bash
```

Or use [kubernetes] container to execute "bash" shell:

```
kubectl exec --stdin=true --tty=true svc/workspace -- bash
```

```
ubuntu@7053e7e42d47:~$ 
```

## Cleanup

Use [docker] to stop and delete the running container:

```
docker stop --time 0 workspace && docker rm workspace
```

Or delete [kubernetes] deployment and service:

```
kubectl delete --filename=manifest
```

## Build

Use [docker] to build a customized container image:

```
docker build --tag=registry.edgestream.net/edgestream/workspace:latest .
```

Use [docker] to push container image into a container registry:

```
docker push registry.edgestream.net/edgestream/workspace:latest
```

[docker]:(https://docker.com)
[kubernetes]:(https://kubernetes.io)