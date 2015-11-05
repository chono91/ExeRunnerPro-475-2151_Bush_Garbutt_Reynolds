<#  
sysinternals for psexec https://technet.microsoft.com/en-us/sysinternals/bb842062   (psexec -i -s powershell) 
System doesn't have access to all regkeys, This may be OK and we can jsut hide the errors
Files in use cannot be hashed, this may be OK and we can hide errors
The Write-Progress indicators need to be tweaked
The Entire Process takes about 20 minutes.. we might need to find a way to streamline it
We might now be able to compare the registry keys in the current format.. need to look into this
#> 

Function Get-PowerShot

{
$registryFolders = (Get-ChildItem -Path Registry::*).Name
#foreach($regFolder in $registryFolders) {Get-RecentFiles -numberDays 1 -touchedFiles ([ref]$touchedFiles)  -path ("Registry::" + $regFolder)}
$i = 1
foreach ($regFolder in $registryFolders) {
    Write-Progress -Activity "Registry Snapshot" -Status "Percent Complete" -PercentComplete ($i / $registryFolders.count * 100)
    $regDir = "Registry::"+$regFolder 
    Get-ChildItem -Path $regDir -Recurse | Out-File -Append registryshot2.reg
}


$i = 0

$rootFolders = Get-ChildItem C:\
foreach ($folder in $rootFolders){
    Write-Progress -Activity "Filesystem Snapshot" -Status "Percent Complete" -PercentComplete ($i /$rootFolders.count * 100)
    Get-ChildItem C:\$folder -Recurse | Get-FileHash -Algorithm MD5 | Out-File -Append filehashes2.txt
    $i++
}

}
