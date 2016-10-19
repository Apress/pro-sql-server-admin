USE master
GO

RESTORE DATABASE Chapter15 FILE = N'Chapter15FileA' 
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15FileRestore.bak' 
	WITH  FILE = 1
	, NORECOVERY
	, STATS = 10
	, REPLACE ;
GO

BACKUP LOG Chapter15
	TO  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_15-26-09.bak' 
	WITH NOFORMAT
	, NOINIT
	,  NAME = N'Chapter15_LogBackup_2015-02-17_15-26-09'
	, NOSKIP
	, NORECOVERY 
              ,  STATS = 5 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15FileRestore.bak' 
	WITH  FILE = 2
	, STATS = 10
	, NORECOVERY ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_15-26-09.bak' 
	WITH FILE = 1
	, STATS = 10
	, RECOVERY ;
GO  
