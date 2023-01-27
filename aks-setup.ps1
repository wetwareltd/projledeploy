param(
    [string] [Parameter(Mandatory=$true)] $vaultName,
    [string] [Parameter(Mandatory=$true)] $certificateName,
    [string] [Parameter(Mandatory=$true)] $subjectName
  )

  # $output = 'Hello {0}. The username is {1}, the password is {2}.' -f $vaultName,${Env:UserName},${Env:Password}
  # $output = 'private to {0}. The username is {1}, the public is {2}.' -f ${Env:PrivateKey},${Env:UserName},${Env:PublicKey}
  # Write-Output $output

  # On bootstrapping VM, login using its user assigned identity
  # az login --identity -u /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1

  # Assign identity to the VMSS
  # az vmss identity assign -g <VMSS_RESOURCE_GROUP> -n <VMSS_NAME> --identities /subscriptions/c9c8ae57-acdb-48a9-99f8-d57704f18dee/resourceGroups/avama2-mrg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/avama2mi1
  cat ~/.ssh/id_rsa

  echo "Looks good Vern"

  cat ~/.ssh/id_rsa.pub


  ssh -tt -i ~/.ssh/id_rsa -t ${Env:UserName}@${Env:PublicIpAddress}

  # curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true

