USE master
GO

RESTORE DATABASE Chapter15 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter15PointinTime.bak' 
        WITH  FILE = 1
        ,  NORECOVERY
        ,  STATS = 5
        , REPLACE ;

RESTORE LOG Chapter15 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter15PointinTime.bak' 
        WITH  FILE = 2
        ,  NORECOVERY
        ,  STATS = 5
        , REPLACE ;

RESTORE LOG Chapter15 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter15PointinTime.bak' 
        WITH  FILE = 3
        ,  STATS = 5
        , STOPBEFOREMARK = 'lsn:35000000036000001'
        , RECOVERY
        , REPLACE ;  
