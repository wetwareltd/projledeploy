
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -N '""' -C "comment"

  ls -la ~/.ssh/
  
  $DeploymentScriptOutputs = @{}
  $DeploymentScriptOutputs['publicKey'] = cat ~/.ssh/id_rsa.pub
  $DeploymentScriptOutputs['privateKey'] = cat ~/.ssh/id_rsa

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