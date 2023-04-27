$name ="null" 
while ($name -NotLike "mneu-*","mnua-*"){   
    [string]$token = Invoke-RestMethod -Headers  @{"X-azure-vm-metadata-token-ttl-seconds" = "21600"} -Method GET -Uri http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/
    $subscription_id = Invoke-RestMethod -Headers @{"X-azure-vm-metadata-token" = $token} -Method GET -Uri http://169.254.169.254/metadata/instance?api-version=2017-08-01 
    $resource = Invoke-RestMethod -Headers @{"X-azure-vm-metadata-token" = $token} -Method GET -Uri http://169.254.169.254/metadata/instance?api-version=2017-08-01
    $name = Invoke-restmethod -Headers @{"X-azure-vm-metadata-token" = $token} -Method GET -uri http://169.254.169.254/metadata/instance/compute/name?api-version=2019-03-11
    $location = Invoke-RestMethod -Headers @{"X-azure-vm-metadata-token" = $token} -Method GET -uri http://169.254.169.254/metadata/instance/compute/location?api-version=2019-03-11
    $TAG= $(az vm describe --resource-group "$resource" --name "$name" --location "$location" --output text)
} 
