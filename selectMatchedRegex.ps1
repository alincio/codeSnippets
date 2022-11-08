#This was needed to extract variables that match the regex pattern.

$pattern = Read-Host "please provide pattern" #e.g. "%\w+%"
$pathFile = Read-Host "please provide path to file" # "..\test.txt"
$exportedFile = Read-Host "please provide exported file location" # "..\output.txt"

Select-string -Path $pathFile -Pattern $pattern -AllMatches | % { $_.Matches } | select-object Value -unique | sort-object Value > $exportedFile