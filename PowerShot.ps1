<# Registry access fix https://support.microsoft.com/en-us/kb/329291
    sysinternals for psexec https://technet.microsoft.com/en-us/sysinternals/bb842062#>

Function Get-PowerShot

{
$registryFolders = (Get-ChildItem -Path Registry::*).Name
#foreach($regFolder in $registryFolders) {Get-RecentFiles -numberDays 1 -touchedFiles ([ref]$touchedFiles)  -path ("Registry::" + $regFolder)}

foreach ($regFolder in $registryFolders) {
$regDir = "Registry::"+$regFolder 
Get-ChildItem -Path $regDir -Recurse | Out-File -Append registryshot.reg}

Get-ChildItem -Recurse | Get-FileHash -Algorithm MD5 | Out-File -Append filehashes.txt
}
