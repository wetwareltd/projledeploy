
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '""' -C "comment"

  ls -la ~/.ssh/

  Write-Output "We have a public key"
  Get-Content ~/.ssh/id_rsa.pub

  Write-Output "Encoded private key"
  $json = Get-Content ~/.ssh/id_rsa | ConvertTo-Json

  $Bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  $EncodedText = [Convert]::ToBase64String($Bytes)

  $DeploymentScriptOutputs = @{}
  $DeploymentScriptOutputs['publicKey'] = Get-Content ~/.ssh/id_rsa.pub
  $DeploymentScriptOutputs['privateKey'] = $EncodedText

  # echo  $DeploymentScriptOutputs

  
# Save the important properties as depoyment script outputs.
# outputJson=$(jq -n 
# \\\n                --arg applicationObjectId \"$applicationObjectId\" 
# \\\n                --arg applicationClientId \"$applicationClientId\" 
# \\\n                --arg servicePrincipalObjectId \"$servicePrincipalObjectId\" 
# \\\n                '{applicationObjectId: $applicationObjectId, applicationClientId: $applicationClientId, servicePrincipalObjectId: $servicePrincipalObjectId}' )
# echo $outputJson > $AZ_SCRIPTS_OUTPUT_PATH