USE MSDB
GO

EXEC sp_add_jobserver 
        @job_name=N'BackupAndCheckBrowser', 
        @server_name = N'SQLSERVER\MASTERSERVER' ;
GO
