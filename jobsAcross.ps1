$jobs = @()

foreach ($sv in $servers) {
    $job = Start-Job -Scriptblock {
        try {
            $output = Invoke-Command -ComputerName $server -Scriptblock{
                $service = Get-Service *teams*
                Stop-Server -Name $service.Name -Force
                return $service.Name
            }
            Write-Host -foregroundColor Green "worked"
        }
        catch {
            Write-Host -foregroundColor Red "Failed bacause: $_"
        }

        try {
            $output = Invoke-Command -ComputerName $server -Scriptblock ([scriptblock]::Create($scriptblock))
            Write-Host -foregroundColor Green "worked"
        }
        catch {
            Write-Host -foregroundColor Red "Failed bacause: $_"
        }
    } -ArgumentList $sv, $scriptblock

    $jobs += $job
}

$jobs | Wait-Job
$results = $jobs | Receive-Job
$jobs | Remove-Job
$results
