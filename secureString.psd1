# config.psd1 (set file permissions to restrict access)
@{
    APIToken = 'encrypted-string-here' # Use ConvertTo-SecureString as in method 1
}

# In script
$config = Import-PowerShellDataFile -Path ".\config.psd1"
$secureToken = ConvertTo-SecureString -String $config.APIToken
$credential = New-Object System.Management.Automation.PSCredential("dummy", $secureToken)
$token = $credential.GetNetworkCredential().Password