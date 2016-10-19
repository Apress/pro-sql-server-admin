USE Master
GO

RESTORE DATABASE Chapter15 PAGE='3:8' 
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15PageRestore.bak' 
	WITH  FILE = 1
	, NORECOVERY
	,  STATS = 5 ;

BACKUP LOG Chapter15
	TO  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_16-47-46.bak' 
	WITH NOFORMAT, NOINIT
	, NAME = N'Chapter15_LogBackup_2015-02-17_16-32-46'
	, NOSKIP
	, STATS = 5 ;

RESTORE LOG Chapter15 
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_16-47-46.bak' 
	WITH  STATS = 5
              , RECOVERY ;
GO
