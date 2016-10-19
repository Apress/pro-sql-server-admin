BACKUP DATABASE Chapter15
	TO  DISK = 'H:\MSSQL\Backup\Chapter15.bak' 
	WITH  RETAINDAYS = 90
	, FORMAT
	, INIT
	, MEDIANAME = 'Chapter15'
	, NAME = 'Chapter15-Full Database Backup'
	, COMPRESSION ;
GO
