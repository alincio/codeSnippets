# Store the token (run once)
cmdkey /generic:MyAPIToken /user:dummy /pass:your-bearer-token-here

# Retrieve in PowerShell (requires third-party module)
Install-Module -Name CredentialManager
$cred = Get-StoredCredential -Target 'MyAPIToken'
$token = $cred.Password

#or use environment variables solution
# Set the environment variable (run once manually or in deployment)
[System.Environment]::SetEnvironmentVariable('API_TOKEN','your-bearer-token-here','User')

# In your script
$token = [System.Environment]::GetEnvironmentVariable('API_TOKEN','User')