USE master
GO

BACKUP LOG Chapter15
	TO  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_27-29-46.bak' 
	WITH NOFORMAT, NOINIT
	, NAME = N'Chapter15_LogBackup_2015-02-17_17-29-46'
	, NOSKIP
	, NORECOVERY
	, NO_TRUNCATE
	, STATS = 5 ;

RESTORE DATABASE Chapter15
	FILEGROUP = N'PRIMARY' 
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH  FILE = 1
	, NORECOVERY
	, PARTIAL
	, STATS = 10 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH  FILE = 2
	, NORECOVERY
	, STATS = 10 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_27-29-46.bak' 
	WITH  FILE = 1
	, STATS = 10
	, RECOVERY ;

-----------------The PRIMARY Filegroup is now online--------------------

RESTORE DATABASE Chapter15
	FILEGROUP = N'FileGroupA' 
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH  FILE = 1
	, NORECOVERY
	, STATS = 10 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH  FILE = 2
	, NORECOVERY
	, STATS = 10 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_27-29-46.bak' 
	WITH  FILE = 1
	, STATS = 10
	, RECOVERY ;

-----------------The FilegroupA Filegroup is now online--------------------

RESTORE DATABASE Chapter15
	FILEGROUP = N'FileGroupB' 
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH  FILE = 1
	, NORECOVERY
	, STATS = 10 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15Piecemeal.bak' 
	WITH  FILE = 2
	, NORECOVERY
	, STATS = 10 ;

RESTORE LOG Chapter15
	FROM  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-17_27-29-46.bak' 
	WITH  FILE = 1
	, STATS = 10
	, RECOVERY ;

-----------------The database is now fully online--------------------  
