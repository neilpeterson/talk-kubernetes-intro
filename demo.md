## Local containers
docker-compose up -d

## Get Nodes
kubectl get nodes

## Run application
kubectl create -f ./2-vote-app/azure-vote.yaml

## View Kubernetes objects
kubectl get pods
kubectl get pods -o wide
kubectl get deployment
kubectl get replicaset
kubectl get service

## Delete pod / force re-recreation
kubeclt delete pod azure-vote-front-<>

## Scale deployment
kubectl scale --replicas 2 deployment/azure-vote-front

## Update deployment
kubectl set image deployment azure-vote-front azure-vote-front=microsoft/azure-vote-front:v2
kubectl get pods -w
kubectl rollout status deployment/azure-vote-front
kubectl rollout undo deployment/azure-vote-front

## Governance

## Create namespace
kubectl get namespaces
kubectl create namespace lob

## Create role and rolebinding
kubectl create -f ./4-governance/1-rbac-line-of-buisness.yaml

## Get user context
az aks get-credentials --name sugarAlpha --resource-group sugarAlpha

## Create lob app
kubectl create -f ./4-governance/2-azure-vote.yaml
kubectl create -f ./4-governance/2-azure-vote.yaml -n lob

## Service Catalog
kubectl create -f ./5-extensions/svc-cat-storage.yaml


