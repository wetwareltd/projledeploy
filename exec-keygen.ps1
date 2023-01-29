
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '""' -C "comment"

  ls -la ~/.ssh/

  echo "We have a public key"
  cat ~/.ssh/id_rsa.pub

  echo "We have a private key"
  cat ~/.ssh/id_rsa

  
  echo "We have base64 encoded 1"
  # echo $EncodedText
  cat ~/.ssh/id_rsa.base64
  $temp = cat ~/.ssh/id_rsa
  echo $temp.getType()

  echo "We have json encoded 1"
  $json = echo $temp | ConvertTo-Json
  # echo $json
  # echo $json.getType()

  $Bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
  $EncodedText = [Convert]::ToBase64String($Bytes)

  $DeploymentScriptOutputs = @{}
  $DeploymentScriptOutputs['publicKey'] = cat ~/.ssh/id_rsa.pub
  $DeploymentScriptOutputs['privateKey'] = $EncodedText


  # "arguments": "[concat('-privateKey', ' ', concat('\\\"', reference('execKeygen').outputs.privateKey, '\\\"'))]",


  echo  $DeploymentScriptOutputs

  # REM: $AZ_SCRIPTS_OUTPUT_PATH for AZ CLI, and  $DeploymentScriptOutputs for PowerShell
  # echo $DeploymentScriptOutputs > $AZ_SCRIPTS_OUTPUT_PATH

  # cat ~/.ssh/id_rsa.pub

  # echo ""

  # cat ~/.ssh/id_rsa

  
# Save the important properties as depoyment script outputs.
# outputJson=$(jq -n 
# \\\n                --arg applicationObjectId \"$applicationObjectId\" 
# \\\n                --arg applicationClientId \"$applicationClientId\" 
# \\\n                --arg servicePrincipalObjectId \"$servicePrincipalObjectId\" 
# \\\n                '{applicationObjectId: $applicationObjectId, applicationClientId: $applicationClientId, servicePrincipalObjectId: $servicePrincipalObjectId}' )
# echo $outputJson > $AZ_SCRIPTS_OUTPUT_PATH