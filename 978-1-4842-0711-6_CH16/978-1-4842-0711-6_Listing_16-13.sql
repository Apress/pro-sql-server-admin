EXEC sp_addarticle 
	@publication = 'Chapter16_Customers_Filtered'
	, @article = 'Customers'
	, @source_owner = 'dbo'
	, @source_object = 'Customers'
	, @type = 'logbased'
	, @pre_creation_cmd = 'drop'
	, @schema_option = NULL
	, @identityrangemanagementoption = 'manual'
	, @destination_table = 'Customers'
	, @destination_owner = 'dbo'
	, @ins_cmd = 'CALL sp_MSins_dboCustomers'
	, @del_cmd = 'CALL sp_MSdel_dboCustomers'
	, @upd_cmd = 'SCALL sp_MSupd_dboCustomers'
	, @filter_clause = 'ID > 500' ;
