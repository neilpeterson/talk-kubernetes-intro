# Run this in cloud shell in personal subscription

RESOURCE_GROUP=aks-azure-ad-integrated
AKS_NAME=aksWithAAD

az group create --name $RESOURCE_GROUP --location eastus

az aks create \
  --resource-group $RESOURCE_GROUP \
  --name $AKS_NAME \
  --generate-ssh-keys \
  --aad-server-app-id $(az keyvault secret show --name aksServerAppId --vault-name nepeterskv --query value -o tsv) \
  --aad-server-app-secret $(az keyvault secret show --name aksServerAppSecret --vault-name nepeterskv --query value -o tsv) \
  --aad-client-app-id $(az keyvault secret show --name aksClientAppId --vault-name nepeterskv --query value -o tsv) \
  --aad-tenant-id $(az keyvault secret show --name AzureTenantID --vault-name nepeterskv --query value -o tsv) \
  --kubernetes-version 1.11.3 \
  --node-count 4

  # Stage container images

  kubectl create -f ./2-vote-app/azure-vote.yaml
  kubectl scale --replicas 5  deployment/azure-vote-front
  kubectl set image deployment azure-vote-front azure-vote-front=microsoft/azure-vote-front:v2