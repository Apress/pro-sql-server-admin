USE Chapter16MemOpt
GO

EXEC sp_addsubscription
    @publication = N'Chapter16_MemOpt',
    @subscriber = N'WIN-KIAGK4GN1MJ\PROSQLADMIN2',
    @destination_db = N'Chapter16MemOpt_Sub',
    @subscription_type = N'Push',
    @sync_type = N'replication support only',
    @article = N'all',
    @update_mode = N'read only',
    @subscriber_type = 0;
GO

EXEC sp_addpushsubscription_agent 
	@publication = 'Chapter16_MemOpt'
	, @subscriber = N'WIN-KIAGK4GN1MJ\PROSQLADMIN2'
	, @subscriber_db = 'Chapter16MemOpt_Sub'
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
