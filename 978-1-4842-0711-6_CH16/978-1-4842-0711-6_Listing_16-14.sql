EXEC sp_articlefilter 
	@publication = 'Chapter16_Customers_Filtered'
	, @article = 'Customers'
	, @filter_name = 'FLTR_Customers_1__54'
	, @filter_clause = 'ID > 500'
	, @force_invalidate_snapshot = 1
	, @force_reinit_subscription = 1 ;
