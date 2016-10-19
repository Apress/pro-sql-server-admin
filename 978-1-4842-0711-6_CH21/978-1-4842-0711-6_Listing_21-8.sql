USE MSDB
GO

EXEC sp_add_jobstep 
		@job_name=N'BackupAndCheckBrowser', 
		@step_name=N'Backup', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=3, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'BACKUP DATABASE Chapter21 
	TO  DISK = N''C:\Program Files\Microsoft SQL Server\MSSQL12.MASTERSERVER\MSSQL\Backup\Chapter21.bak'' 
	WITH NOINIT
	, NAME = N''Chapter21-Full Database Backup''
	, SKIP
	, STATS = 10', 
		@database_name=N'Chapter21', 
		@database_user_name=N'PROSQLADMIN\sqluser', 
		@flags=4 ;

EXEC sp_add_jobstep @job_name=N'BackupAndCheckBrowser', @step_name=N'CheckBrowser', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'PowerShell', 
		@command=N'get-service | where {$_.name -eq "SQLBrowser"}', 
		@database_name=N'master', 
		@flags=32, 
		@proxy_name=N'PowerShellProxy' ;
GO
