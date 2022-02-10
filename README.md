# workspace
Workspace as a service

## Install

Run a [docker] container:

```
docker run --name=workspace --detach registry.edgestream.net/edgestream/workspace:latest
```

(or)

Use [kubernetes] to deploy the workspace service:

```
kubectl apply --filename=manifest
```

## Usage

Use [docker] to execute the "bash" shell:

```
docker exec --interactive --tty workspace bash
```

```
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@7053e7e42d47:~$ 
```

(or)

Use [kubernetes] to execute the "bash" shell:

```
kubectl exec --stdin=true --tty=true svc/workspace -- bash
```

## Cleanup

Use [docker] to stop the running container and delete the container:

```
docker stop --time 0 workspace && docker rm workspace
```

(or)

Use [kubernetes] to delete the deployment:

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