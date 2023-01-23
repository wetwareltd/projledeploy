param(
    [string] [Parameter(Mandatory=$true)] $vaultName,
    [string] [Parameter(Mandatory=$true)] $certificateName,
    [string] [Parameter(Mandatory=$true)] $subjectName
  )

  $output = 'Hello {0}. The username is {1}, the password is {2}.' -f $vaultName,${Env:UserName},${Env:Password}
  Write-Output $output
