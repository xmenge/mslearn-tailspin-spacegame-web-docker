az configure --defaults location=australiaeast

resourceSuffix=300
webName="tsg-web-docker-${resourceSuffix}"
registryName="tsgacr${resourceSuffix}"
rgName='tsg-docker-rg'
planName='tsg-docker-asp'


az group create --name $rgName

az acr create --name $registryName \
  --resource-group $rgName \
  --sku Standard \
  --admin-enabled true


  az appservice plan create \
  --name $planName \
  --resource-group $rgName \
  --sku F1 \
  --is-linux


az webapp create \
  --name $webName \
  --resource-group $rgName \
  --plan $planName \
  --deployment-container-image-name $registryName.azurecr.io/web:latest


az webapp list \
  --resource-group $rgName \
  --query "[].{hostName: defaultHostName, state: state}" \
  --output table


az acr list \
  --resource-group $rgName \
  --query "[].{loginServer: loginServer}" \
  --output table

