EXEC sp_addpushsubscription_agent 
	@publication = 'Chapter16_Customers_Filtered'
	, @subscriber = N'WIN-KIAGK4GN1MJ\PROSQLADMIN2'
	, @subscriber_db = 'Chapter16_Sub'
	, @job_login = N'PROSQLADMIN\SQLAdmin'
	, @job_password = Pa$$w0rd
	, @subscriber_security_mode = 1
	, @frequency_type = 64
	, @frequency_interval = 0
	, @frequency_subday = 0
	, @frequency_subday_interval = 0
	, @active_start_time_of_day = 0
	, @active_end_time_of_day = 235959
	, @active_start_date = 20150223
	, @active_end_date = 99991231
	, @enabled_for_syncmgr = N'False' ;
