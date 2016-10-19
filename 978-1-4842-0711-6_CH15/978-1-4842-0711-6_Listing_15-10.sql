USE master
GO

--Backup the tail of the log

BACKUP LOG [Chapter15] TO  DISK = N'H:\MSSQL\Backup\Chapter15_LogBackup_2015-02-16_12-17-49.bak' 
	WITH NOFORMAT, NAME = N'Chapter15_LogBackup_2015-02-16_12-17-49', NORECOVERY ,  STATS = 5 ;

--Restore the full backup

RESTORE DATABASE [Chapter15] FROM  DISK = N'H:\MSSQL\Backup\Chapter15.bak' WITH  FILE = 1,  NORECOVERY, STATS = 5 ;

--Restore the differential

RESTORE DATABASE [Chapter15] FROM  DISK = N'H:\MSSQL\Backup\Chapter15.bak' WITH  FILE = 2,  NORECOVERY,  STATS = 5 ;

--Restore the transaction log

RESTORE LOG [Chapter15] FROM  DISK = N'H:\MSSQL\Backup\Chapter15.bak' WITH  FILE = 3,  STATS = 5 ;

GO  
