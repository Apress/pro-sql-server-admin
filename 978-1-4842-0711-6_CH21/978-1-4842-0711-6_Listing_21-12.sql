USE msdb
GO

EXEC sp_add_notification 
		@alert_name=N'Chapter21LogSpace', 
		@operator_name=N'DBATeam', 
		@notification_method = 1 ;
GO
