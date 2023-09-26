################ Delete argoCD deployment ################
kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

################ sleep for 10 second untill ################
sleep 10

################ Delete argoCD namespace ################
kubectl delete namespace argocd 


################ Delete argoCD.password.txt ################
rm -f argoCD.password.txt
