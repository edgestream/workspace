# Workspace as a service



## INSTALL

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
Update the deployment spec to use your customized image:
```
...
```

## ROADMAP

### Persist authorized "SSH" keys

- Store "authorized_keys" into a configmap "ssh-user-keys-public"
- Mount "authorized_keys" into "/root/.ssh/authorized_keys" using proper permissions
- Write documentation to generate the configmap from "~/.ssh/id_rsa.pub"

### "Visual Studio Code" server

- Use an official workspace image as the base image
- Add useful extensions like "Kubernetes", "Docker", "German" to the image

### "Helm" chart

- Create a helm chart for easier installation/configuration
- Publish helm chart via "github" pages/repository

### "Kubernetes" configuration

- Find a way to generate a ".kube/config" configmap for the workspace user restricted to it's namespace
- Mount the configmap into the user's home directory as ".kube/config"