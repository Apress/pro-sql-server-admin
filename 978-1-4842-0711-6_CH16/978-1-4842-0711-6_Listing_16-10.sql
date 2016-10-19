EXEC Chapter16.sys.sp_addlogreader_agent 
	@job_login = N'PROSQLADMIN\SQLAdmin'
	, @job_password = 'Pa$$w0rd'
	, @publisher_security_mode = 1
	, @job_name = NULL ;
