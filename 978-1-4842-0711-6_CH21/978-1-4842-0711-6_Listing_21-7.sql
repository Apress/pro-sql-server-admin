USE MSDB
GO

EXEC sp_add_job @job_name=N'BackupAndCheckBrowser', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Backup Chapter21 database, Check Browser service running', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'DBATeam' ;
GO
