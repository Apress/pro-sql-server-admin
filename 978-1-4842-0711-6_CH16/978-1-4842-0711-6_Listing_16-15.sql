EXEC sp_articleview 
	@publication = 'Chapter16_Customers_Filtered'
	, @article = 'Customers'
	, @view_name = 'SYNC_Customers_1__54'
	, @filter_clause = 'ID > 500'
	, @force_invalidate_snapshot = 1
	, @force_reinit_subscription = 1 ;
