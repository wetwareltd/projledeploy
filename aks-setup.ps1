param(
  [string[]] [Parameter(Mandatory=$true)] $privateKey
  )

  Write-Output "ssh to  ${Env:UserName}@${Env:PublicIpAddress}"  
  Write-Output "with principal ${Env:UserResourceId}"

  $decodedText = [Convert]::FromBase64String($privateKey)
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

  Write-Output "Log in to VM"
  ssh -tt -i ~/id_rsa.pem -tt -o StrictHostKeyChecking=No ${Env:UserName}@${Env:PublicIpAddress} "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && az login --identity -u  ${Env:UserResourceId} && exit"

  Write-Output "Closing out VM bootstrap setup"

  # curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true

  # On bootstrapping VM, login using its user assigned identity
  # az login --identity -u /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1

  # Assign identity to the VMSS
  # az vmss identity assign -g <VMSS_RESOURCE_GROUP> -n <VMSS_NAME> --identities /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1
