EXEC sys.sp_configure 'cross db ownership chaining', '1' ;
GO

RECONFIGURE WITH OVERRIDE ;
