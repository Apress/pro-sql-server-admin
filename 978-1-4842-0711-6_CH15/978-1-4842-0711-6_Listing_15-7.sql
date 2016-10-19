BACKUP DATABASE Chapter15 FILEGROUP = 'FileGroupA'
	TO  DISK = 'H:\MSSQL\Backup\Chapter15FGA.bak' 
	WITH  RETAINDAYS = 90
	, FORMAT
	, INIT
	, MEDIANAME = 'Chapter15FG'
	, NAME = 'Chapter15-Full Database Backup-FilegroupA'
	, COMPRESSION ;
GO
