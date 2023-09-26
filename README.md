# ArgoCD-demo
Hands on ArgoCD 


# ArgoCD and Nginx Helm Chart Deployment

This repository contains scripts and a Helm chart for deploying ArgoCD and Nginx as an Ingress controller in a Kubernetes cluster. ArgoCD is a declarative, GitOps continuous delivery tool for Kubernetes. Nginx is used to manage external access to ArgoCD.

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/): Kubernetes command-line tool
- [Helm](https://helm.sh/docs/intro/install/): Kubernetes package manager
- [Minikube](https://minikube.sigs.k8s.io/docs/start/): A local Kubernetes cluster 

---

-> All instrcutions exist in ***argocd-script.sh*** and u can install by using 
```bash
./argocd-script.sh
```

## Quick Start

### Create ArgoCD Namespace

```bash
kubectl create ns argocd || true
```
```|| true``` in case argocd namespace exist. 

### Deploy ArgoCD
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Wait for ArgoCD Deployment

```bash
sleep 300
```

### Modify ArgoCD Service Type
Change the service type of the ArgoCD server to NodePort to expose it externally (if necessary):

 ```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

### Extract ArgoCD Admin Password

```bash
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode > argoCD-password.txt
```
### Port Forwarding (Optional)
You can temporarily access ArgoCD using port forwarding

```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### OR Expose ArgoCD Service URL
```bash
minikube service -n argocd argocd-server --url
```
### Helm Chart for Nginx Installation
For installing Nginx as an Ingress controller,you can add it through ArgoCD GUI by following this link  [ArgoCD Documentation](https://argo-cd.readthedocs.io/en/stable/getting_started/).


### Cleanup
Remember to clean up your resources when you're done:
``` bash
./. uninstall-argoCD-script.sh
```

