USE Chapter16
GO

EXEC sp_replicationdboption 
	@dbname = N'Chapter16'
	, @optname = 'publish'
	, @value = 'true' ;
