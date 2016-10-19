--Part 1 - To be run on the controller

BACKUP DATABASE Chapter20 
TO  DISK = N'F:\MSSQL\Backup\Chapter20.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'Chapter20-Full Database Backup', SKIP,  STATS = 10
GO

--Part 2 - To be run on the Client, after moving the backup file across

RESTORE DATABASE Chapter20 
FROM  DISK = N'F:\MSSQL\Backup\Chapter20.bak' 
WITH  FILE = 1, STATS = 5
GO
