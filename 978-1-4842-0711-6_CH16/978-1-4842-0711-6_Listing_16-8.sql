EXEC sp_adddistpublisher 
	@publisher = N'WIN-KIAGK4GN1MJ\PROSQLADMIN'
	, @distribution_db = N'Distribution'
	, @working_directory = N'\\WIN-KIAGK4GN1MJ\ReplData'
	, @thirdparty_flag = 0 ;
