BACKUP LOG Chapter15
	TO  DISK = 'H: \MSSQL\Backup\Chapter15.bak' 
	WITH  RETAINDAYS = 90
	, NOINIT
	, MEDIANAME = 'Chapter15'
	, NAME = 'Chapter15-Log Backup'
	, COMPRESSION ;
GO
