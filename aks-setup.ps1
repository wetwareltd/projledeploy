param(
  [object[]] [Parameter(Mandatory=$true)] $privateKey
  # [string] [Parameter(Mandatory=$true)] $privateKey
  )

  echo $privateKey
  echo "ssh to  ${Env:UserName}@${Env:PublicIpAddress}"  

  # $encodedText = [Convert]::FromBase64String($privateKey)
  # $decodedPrivateKey = [System.Text.Encoding]::UTF8.GetString($encodedText)
  # echo "with decoded privateKey?"  
  # echo $decodedPrivateKey

  echo $privateKey|base64 --decode > id_rsa.txt
  
  
  echo "Verify the key file"
  cat id_rsa.txt

  echo "Log in to VM"
  ssh -tt -i id_rsa.txt -tt ${Env:UserName}@${Env:PublicIpAddress}

  echo "Test local FS"

  pwd

  ls



  # curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true

  # On bootstrapping VM, login using its user assigned identity
  # az login --identity -u /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1

  # Assign identity to the VMSS
  # az vmss identity assign -g <VMSS_RESOURCE_GROUP> -n <VMSS_NAME> --identities /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1
