# Convert the token to a secure string and save to file
$token = "your-bearer-token-here"
$secureToken = ConvertTo-SecureString -String $token -AsPlainText -Force
$encryptedToken = ConvertFrom-SecureString -SecureString $secureToken
$encryptedToken | Out-File "C:\secure\encryptedToken.txt"

# Later, retrieve and use it (only works for same user on same machine)
$encryptedToken = Get-Content "C:\secure\encryptedToken.txt"
$secureToken = ConvertTo-SecureString -String $encryptedToken
$credential = New-Object System.Management.Automation.PSCredential("dummy", $secureToken)
$token = $credential.GetNetworkCredential().Password