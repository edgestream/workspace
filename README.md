# Workspace as a service



## INSTALL

Generate SSH host keys:
```
ssh-keygen -q -N "" -t rsa -b 4096 -f ssh_host_rsa_key
```
Create a configmap resource containing the public SSH host key:
```
kubectl create configmap workspace-ssh-host-key-public --from-file=ssh_host_rsa_key.pub
```
Create a secret resource containing the private SSH host key:
```
kubectl create secret generic workspace-ssh-host-key-private --from-file=ssh_host_rsa_key
```
Create a configmap resource containing the public authorized SSH user keys:
```
kubectl create configmap workspace-ssh-user-key-public --from-file id_rsa.pub=$HOME/.ssh/id_rsa.pub --from-file authorized_keys=$HOME/.ssh/id_rsa.pub
```
Create the kustomization and apply it to the cluster:
```
kustomize build kustomization | kubectl apply -f -
```

## USAGE

### Enter workspace via "docker"

```
docker exec --interactive --tty workspace bash
```

### Enter workspace via "kubectl"

```
kubectl exec --stdin=true --tty=true svc/workspace -- bash
```

### Enter workspace via "ssh"

```
ssh workspace.default.svc.cluster.local
```

## BUILD

Build a customized container image:
```
docker build --tag=<Your Registry>/workspace:latest .
```
Push the new container image in a private registry:
```
docker login <Your Registry>
docker push <Your Registry>/workspace:latest
```
Update the deployment spec to use your customized image.
