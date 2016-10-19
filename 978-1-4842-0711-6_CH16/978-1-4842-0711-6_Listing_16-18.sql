--Create the database

CREATE DATABASE Chapter16MemOpt ;
GO

USE Chapter16MemOpt
GO

--Create and populate the table

CREATE TABLE dbo.Customers
(
	ID	INT	IDENTITY	PRIMARY KEY
	, FirstName	NVARCHAR(30)
	, LastName	NVARCHAR(30)
) ;
GO

INSERT INTO Chapter16MemOpt.dbo.Customers
SELECT 
	FirstName
	, LastName
FROM Chapter16.dbo.Customers ;
GO

--Add the Publication

EXEC sp_replicationdboption 
	@dbname = N'Chapter16MemOpt'
	, @optname = N'publish'
	, @value = N'true' ;
GO

EXEC Chapter16MemOpt.sys.sp_addlogreader_agent 
	@job_login = N'PROSQLADMIN\SQLAdmin'
	, @job_password = Pa$$w0rd
	, @publisher_security_mode = 1
	, @job_name = NULL ;
GO

EXEC sp_addpublication 
	@publication = N'Chapter16_MemOpt'
	, @description = N'Transactional publication of database ''Chapter16MemOpt'' from Publisher ''WIN-KIAGK4GN1MJ\PROSQLADMIN''.'
	, @sync_method = N'concurrent'
	, @retention = 0
	, @allow_push = N'true'
	, @allow_pull = N'true'
	, @allow_anonymous = N'true'
	, @enabled_for_internet = N'false'
	, @snapshot_in_defaultfolder = N'true'
	, @allow_subscription_copy = N'false'
	, @repl_freq = N'continuous'
	, @status = N'active'
	, @independent_agent = N'true'
	, @immediate_sync = N'true'
	, @allow_sync_tran = N'false'
	, @allow_dts = N'false'
	, @replicate_ddl = 1
	, @allow_initialize_from_backup = N'false'
	, @enabled_for_p2p = N'false'
	, @enabled_for_het_sub = N'false' ;
GO

EXEC sp_addpublication_snapshot 
	@publication = N'Chapter16_MemOpt'
	, @frequency_type = 1
	, @frequency_interval = 1
	, @frequency_subday = 8
	, @frequency_subday_interval = 1
	, @active_start_time_of_day = 0
	, @active_end_time_of_day = 235959
	, @active_start_date = 0
	, @active_end_date = 0
	, @job_login = N'PROSQLADMIN\SQLAdmin'
	, @job_password = Pa$$w0rd
	, @publisher_security_mode = 1 ;
GO

EXEC sp_addarticle 
	@publication = N'Chapter16_MemOpt'
	, @article = N'Customers'
	, @source_owner = N'dbo'
	, @source_object = N'Customers'
	, @type = N'logbased'
	, @pre_creation_cmd = N'drop'
	, @schema_option = 0x000000000803509F
	, @identityrangemanagementoption = N'manual'
	, @destination_table = N'Customers'
	, @destination_owner = N'dbo'
	, @ins_cmd = N'CALL sp_MSins_dboCustomers'
	, @del_cmd = N'CALL sp_MSdel_dboCustomers'
	, @upd_cmd = N'SCALL sp_MSupd_dboCustomers' ;
GO

EXEC sp_startpublication_snapshot @publication = N'Chapter16_MemOpt' ;
