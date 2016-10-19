USE MSDB
GO

EXEC msdb.dbo.sp_add_operator 
		@name=N'DBATeam', 
		@enabled=1, 
		@email_address=N'SQLServerPrimary@apressprosqladmin.com' ;
GO
