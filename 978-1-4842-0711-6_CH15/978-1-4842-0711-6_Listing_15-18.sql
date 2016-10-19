BACKUP DATABASE Chapter15
	FILEGROUP = N'PRIMARY',  FILEGROUP = N'FileGroupA',  FILEGROUP = N'FileGroupB' 
	TO  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH FORMAT
	, NAME = N'Chapter15-Fiegroup Backup'
	, STATS = 10 ;

BACKUP LOG Chapter15
	TO  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH NOFORMAT, NOINIT
	,  NAME = N'Chapter15-Full Database Backup'
	,  STATS = 10 ;
