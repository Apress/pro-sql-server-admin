USE Chapter16
GO

EXEC sp_addsubscription 
	@publication = N'Chapter16_Customers_Filtered'
	, @subscriber = N'WIN-KIAGK4GN1MJ\PROSQLADMIN2'
	, @destination_db = N'Chapter16_Sub'
	, @subscription_type = N'Push'
	, @sync_type = N'automatic'
	, @article = N'all' ;
