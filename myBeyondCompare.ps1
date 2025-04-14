$block = {
    $path1 = "C:\Path1"
    $path2 = "C:\Path12"

    $files1= Get-ChildItem -Path $path1 -Recurse -File
    $files2= Get-ChildItem -Path $path2 -Recurse -File

    $fileInfo1 = @{}
    $fileInfo2 = @{}

    $foreach ($file in $files1){
        $fileInfo1[$file.Name] = $file.FullName
    }

    $foreach ($file in $files2){
        $fileInfo2[$file.Name] = $file.FullName
    }

    $allFiles = $fileInfo1.Keys + $fileInfo2.Keys | Sort-Object -Unique

    $results = foreach ($file in $allFiles) {
        $info1 = $fileInfo1[$file]
        $info2 = $fileInfo2[$file]

        if ($info1 -and $info2) {
            $compareResults = & cmd /c fc "$info1" "$info2"
            if ($compareResults -match "no differences") {
                [PSCustomObject]@{
                    FileName = $info1
                    Status = "Identical"
                }
            }else{
                [PSCustomObject]@{
                    FileName = $info1
                    Status = "Different"
                    Differences = $compareResults
                }
            }elseif ($info1){
                [PSCustomObject]@{
                    FileName = $info1
                    Status = "Only in Path1"
                }
            }elseif ($info2){
                [PSCustomObject]@{
                    FileName = $info2
                    Status = "Only in Path2"
                }
            }
        }
    }
    $diffs = $results | where {$_.Status -eq "Different"}
    $onlyIn1 = $results | where {$_.Status -eq "Only in Path1"}
    $onlyIn2 = $results | where {$_.Status -eq "Only in Path2"}

    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

    $diffs | ForEach-Object {
        $name = $_.FileName
        $status = $_.Status
        foreach ($diff in $_.Differences) {
            [PSCustomObject]@{
                FileName = $name
                Status = $status
                Diff = $diff
            }
        }
    } | Export-Csv -Path "C:\diffs-$timestamp.csv" -NoTypeInformation

    $onlyIn1 | Export-Csv -Path "C:\onlyIn1-$timestamp.csv" -NoTypeInformation
    $onlyIn2 | Export-Csv -Path "C:\onlyIn2-$timestamp.csv" -NoTypeInformation

}
