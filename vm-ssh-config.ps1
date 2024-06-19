$ip = Get-NetNeighbor -LinkLayerAddress 00-15-5d-*

$content = "Host mharder-dev-u24" + [Environment]::NewLine + `
           "  HostName " + $ip.IPAddress + [Environment]::NewLine + `
           "  User mharder" + [Environment]::NewLine;

$sshConfig = Join-Path $HOME ".ssh" "config"

$content | Out-File -FilePath $sshConfig
