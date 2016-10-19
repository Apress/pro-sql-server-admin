USE MSDB
GO

--Create the Proxy

EXEC msdb.dbo.sp_add_proxy 
	@proxy_name='PowerShellProxy'
	,@credential_name='WinUserCredential'
	,@enabled=1
	,@description='Proxy to check Browser Service status' ;
GO

--Grant the Proxy access to the PowerShell subsystem

EXEC msdb.dbo.sp_grant_proxy_to_subsystem 
	@proxy_name='PowerShellProxy'
	,@subsystem_name='PowerShell' ;
GO
