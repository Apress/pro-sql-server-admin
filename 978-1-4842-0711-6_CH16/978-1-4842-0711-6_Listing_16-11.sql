USE Chapter16
GO

EXEC sp_addpublication 
	@publication = 'Chapter16_Customers_Filtered'
	, @description = 'Transactional publication of database ''Chapter16'' from Publisher ''WIN-KIAGK4GN1MJ\PROSQLADMIN''.'
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
