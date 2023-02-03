  Write-Output "ssh to  ${Env:UserName}@${Env:PublicIpAddress}"

  $decodedText = [Convert]::FromBase64String(${Env:Key})
  $jsonPrivateKey = [System.Text.Encoding]::UTF8.GetString($decodedText)
  $decodedPrivateKey = Write-Output $jsonPrivateKey | ConvertFrom-Json

  # NOTE: The json/base64 encoding process strips off the tail new line.
  # The new line is requried for the key to be valid.
  $decodedPrivateKey += "`r`n"

  # NOTE: The private key needs to be in the users $HOME directory otherwise
  # an access policy error is given on login.  Only the user should be able to access
  # the key
  Write-Output $decodedPrivateKey > ~/id_rsa.pem
  chmod 400 ~/id_rsa.pem
  
  Write-Output "Verify the key file"
  Get-Content ~/id_rsa.pem
 
  # Build up commmands to execute
  $UserIdentity = "${Env:SubscriptionId}/resourceGroups/${Env:MgdAppGroup}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${Env:MgdIdentity}"
  Write-Output "with principal $UserIdentity"

  $InstallAzCli = "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash"
  $LoginUser = "az login --identity -u $UserIdentity"
  $GetAksCredentials = "az aks get-credentials -g ${Env:MgdAppGroup} -n ${Env:AppName}"
  $DownloadKubectl = "curl -LO `"https://dl.k8s.io/release/`$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl`""
  $InstallKubectl = "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl"
  $VmssNameHarvest = "vmssName=`$(az vmss list --output tsv --query [0].name)"
  $EchoVmssName = "echo `$vmssName"
  $AddVMSSIdentity = "az vmss identity assign -g ${Env:VmssGroup} -n `$vmssName --identities $UserIdentity"
  $PropogateVMMSIdentity = 'az vmss update-instances -g ${Env:VmssGroup} -n `$vmssName --instance-ids *'
  
  Write-Output "Log in to VM"
  # ssh -tt -i ~/id_rsa.pem -tt -o StrictHostKeyChecking=No ${Env:UserName}@${Env:PublicIpAddress} "$InstallAzCli && $LoginUser && $GetAksCredentials && $DownloadKubectl && $InstallKubectl && $VmssNameHarvest && $EchoVmssName && $AddVMSSIdentity && $PropogateVMMSIdentity && exit"
  ssh -tt -i ~/id_rsa.pem -tt -o StrictHostKeyChecking=No ${Env:UserName}@${Env:PublicIpAddress} "$InstallAzCli && $LoginUser && $GetAksCredentials && $DownloadKubectl && $InstallKubectl && $VmssNameHarvest && $EchoVmssName && $AddVMSSIdentity && exit"

  Write-Output "Closing out VM bootstrap setup"

  # curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true

  # On bootstrapping VM, login using its user assigned identity
  # az login --identity -u /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1

  # Assign identity to the VMSS
  # az vmss identity assign -g <VMSS_RESOURCE_GROUP> -n <VMSS_NAME> --identities /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1
