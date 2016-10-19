BACKUP DATABASE Chapter15
	TO  DISK = 'H:\MSSQL\Backup\Chapter15.bak' 
	WITH  DIFFERENTIAL
	, RETAINDAYS = 90
	, NOINIT
	, MEDIANAME = 'Chapter15'
	, NAME = 'Chapter15-Diff Database Backup'
	, COMPRESSION ;
GO
