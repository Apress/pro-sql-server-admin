Get-ClusterResource "App1_App1Listen" | Set-ClusterParameter RegisterAllProvidersIP 0

Get-ClusterResource "App1_App1Listen" | Set-ClusterParameter HostRecordTTL 300 
