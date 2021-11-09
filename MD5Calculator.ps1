Write-Host '------------------------------' -ForegroundColor Yellow
Write-Host '        MD5 Calculator        ' -ForegroundColor Yellow
Write-Host '------------------------------' -ForegroundColor Yellow

# Check if a 1 paramter1 were given.
If ($args.Count -ne 1)
{
    #Write-Host 'Please provide hash filename!' -ForegroundColor Red
    $hashfile = Read-Host -Prompt "Please provide hash filename!"
    
}
Else
{
    # MD5 filename
    $hashfile = $args[0]
}

# Inform user about the filepath.
Write-Host "MD5 filename: $hashfile"

If (Test-Path -Path $hashfile -PathType leaf)
{
    Remove-Item $hashfile
    Write-Host "$hashfile was deleted, because it's not needed anymore." -ForegroundColor Red
}

# Get the path without the filename.
$directory = $hashfile | Split-Path

# We will collect all hashes and filenames here.
$fileContent = ""

# Go via all files in the directory and calculate MD5, add two spaces and filename.
# Concatane results into the sum string.
Get-ChildItem $directory | 
Foreach-Object {
    $md5 = Get-FileHash $_.FullName -Algorithm MD5

    $filehash = $md5.Hash.ToLower()
    $filename = $_

    $fileContent += "$filehash  $filename`n" 
}

# Print MD5 hashes to file.
$fileContent | Out-File -FilePath $hashfile -NoNewline
Write-Host "$hashfile was created." -ForegroundColor Green
