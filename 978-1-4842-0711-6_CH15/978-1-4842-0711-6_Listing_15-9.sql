BACKUP DATABASE Chapter15
           TO  DISK = 'H:\MSSQL\Backup\Chapter15Stripe1.bak', 'G:\MSSQL\Backup\Chapter15Stripe2.bak'
           MIRROR TO = 'J:\MSSQL\Backup\Chapter15Mirror1.bak', 'K:\MSSQL\Backup\Chapter15Mirror2.bak'
           WITH  RETAINDAYS = 90
           , FORMAT
           , INIT
           , MEDIANAME = 'Chapter15Mirror'
           , NAME = 'Chapter15-Full Database Backup-Mirror'
           , COMPRESSION ;
GO
