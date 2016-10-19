USE MSDB
GO

EXEC sp_attach_schedule 
		@job_name='BackupAndCheckBrowser', 
		@schedule_name='Maintenance Schedule' ;
GO
