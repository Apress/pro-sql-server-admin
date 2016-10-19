BACKUP DATABASE Chapter15
	TO  DISK = 'H:\MSSQL\Backup\Chapter15Stripe1.bak', 'G:\MSSQL\Backup\Chapter15Stripe2.bak'
	WITH  RETAINDAYS = 90
	, FORMAT
	, INIT
	, MEDIANAME = 'Chapter15Stripe'
	, NAME = 'Chapter15-Full Database Backup-Stripe'
	, COMPRESSION ;
GO
