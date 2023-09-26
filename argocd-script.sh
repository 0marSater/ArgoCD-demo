################ Create argoCD namespace ################
kubectl create ns argocd || true 

################ Deploy argoCD ################
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

################ Sleep for 100 second untill argoCD deployed ################
sleep 300

################ Modify argoCD service type ################
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
#kubectl patch svc argocd-server -n argocd -p "{\"spec\": {\"type\": \"LoadBalancer\"}}"


################ Extract the password to argoCD-password.txt ################
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode > argoCD-password.txt


################ Port forwarding argoCD svc for temporarily access ################
#kubectl port-forward svc/argocd-server -n argocd 8080:443 


################ Expose argoCD service URL to ################
minikube service -n argocd argocd-server --url






