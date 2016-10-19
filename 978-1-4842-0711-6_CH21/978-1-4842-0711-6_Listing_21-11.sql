EXEC sp_add_alert 
		@name=N'Chapter21LogSpace', 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=0, 
		@notification_message=N'Instance: SQLSERVER\MASTERSERVER', 
		@performance_condition=N'Databases|Percent Log Used|Chapter21|>|75' ;
GO
