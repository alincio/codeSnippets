$searchPattern = "config*.json"
$driveLetter = get-psdrive | where {if($_.Provider -like "*FileSystem*"){$_.Root}} | select Root

foreach ($dL in $driveLetter) {
    $startDirectory = $dl.Root

    $settings = Get-ChildItem -Path $startDirectory -Filter $searchPattern -Recurse -ErrorAction SilentlyContinue| Select-Object -expandProperty FullName

    $parentFolder = Split-Path -Path "$settings" -Parent
    cd $parentFolder

    #check if file exists

    $filesToCheck = @("file1.txt","file2.log")
    foreach ($file in $filesToCheck) {
        $fullPath = Join-Path -path $parentFolder -childPath $file
        if (Test-Path -Path $fullPath) {
            Write-Host "$file exists in $parentFolder"
        }else{
            Write-Host -foregroundColor Yellow "$(hostname) -- $file does not exist in $parentFolder"
            $nok =1
        }
    }
    if ($nok -eq 1) {
        break
    }

    if ($null -eq $settings) {
        Write-Host -foregroundColor Yellow "cannot find config file on $(hostname) Drive: $startDirectory"
    }else{
        $settingsContent = Get-Content -Path $settings -Raw
        $modifiedContent = $settings -replace [regex] "1\.(\d+)\.(\d+)","1.9.0"
        $modifiedContent | out-file -filepath "$settings" -foregroundColor
        
        $exec = Get-ChildItem -Path $parentFolder -Filter "*start*" -Recurse -ErrorAction SilentlyContinue| Select-Object -expandProperty FullName

        if ($exec) {
            & powershell "$exec -param '$settings'"
        }else{
            Write-Host -foregroundColor Red "Cannot Find exec $exec on machine $(hostname)"
        }
        break
    }
    return "Completed"
}
