# Requires Az module: Install-Module -Name Az
Connect-AzAccount

# Store secret
$secretValue = ConvertTo-SecureString "your-bearer-token-here" -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName "MyVault" -Name "APIToken" -SecretValue $secretValue

# Retrieve secret
$secret = Get-AzKeyVaultSecret -VaultName "MyVault" -Name "APIToken"
$token = $secret.SecretValue | ConvertFrom-SecureString -AsPlainText