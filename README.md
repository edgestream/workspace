# workspace
Workspace as a service

## Install

Generate SSH host keys:

```
ssh-keygen -q -N "" -t rsa -b 4096 -f ssh_host_rsa_key
```

Create a configmap resource declaration containing the public SSH host key:

```
kubectl create configmap workspace-ssh-host-key-public --from-file=ssh_host_rsa_key.pub --dry-run='client' --output='yaml' > kustomization/configmap.yaml
```

Create a secret resource declaration containing the private SSH host key:

```
kubectl create secret generic workspace-ssh-host-key-private --from-file=ssh_host_rsa_key --dry-run='client' --output='yaml' > kustomization/secret.yaml
```

Create the kustomization and apply it to the cluster:

```
kustomize build kustomization | kubectl apply -f -
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
