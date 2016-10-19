EXEC sp_addpublication_snapshot 
	@publication = 'Chapter16_Customers_Filtered'
	, @frequency_type = 1
	, @frequency_interval = 1
	, @frequency_subday = 8
	, @frequency_subday_interval = 1
	, @active_start_time_of_day = 0
	, @active_end_time_of_day = 235959
	, @active_start_date = 0
	, @active_end_date = 0
	, @job_login = N'PROSQLADMIN\SQLAdmin'
	, @job_password = 'Pa$$w0rd'
	, @publisher_security_mode = 1 ;
