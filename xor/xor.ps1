
# ref https://github.com/ITAYC0HEN/XOR-Files/blob/master/xor.ps1
# only add line 15 , because location is not correct , see:https://stackoverflow.com/questions/11246068/why-dont-net-objects-in-powershell-use-the-current-directory
# usage: xor.ps1 [firstFile] [secondFile] [outputFile] 


param (
    [Parameter(Mandatory=$true)]
    [string] $file1, #First File
    [Parameter(Mandatory=$true)]
    [string] $file2, #Second file
    [Parameter(Mandatory=$true)]
    [string] $out #Output File
) #end param

# let location correct
[Environment]::CurrentDirectory = (Get-Location -PSProvider FileSystem).ProviderPath
 
# Read two files as byte arrays
$key = [System.IO.File]::ReadAllBytes("$file1") 
$target_file = [System.IO.File]::ReadAllBytes("$file2")
 
# Set the length to be the smaller one
$len = if ($key.Count -lt $target_file.Count) {$key.Count} else { $target_file.Count}
$xord_byte_array = New-Object Byte[] $len

# XOR between the files
for($i=0; $i -lt $len ; $i++)
{
    $xord_byte_array[$i] = $key[$i] -bxor $target_file[$i]
}
 
# Write the XORd bytes to the output file
[System.IO.File]::WriteAllBytes("$out", $xord_byte_array)

write-host "[*] $file1 XOR $file2`n[*] Saved to " -nonewline;
Write-host "$out" -foregroundcolor yellow -nonewline; Write-host ".";
