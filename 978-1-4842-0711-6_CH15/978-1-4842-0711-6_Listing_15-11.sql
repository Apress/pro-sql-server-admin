USE Chapter15
GO

BACKUP DATABASE Chapter15
	TO  DISK = 'H:\MSSQL\Backup\Chapter15PointinTime.bak' 
	WITH  RETAINDAYS = 90
	, FORMAT
	, INIT, SKIP
	, MEDIANAME = 'Chapter15Point-in-time'
	, NAME = 'Chapter15-Full Database Backup'
	, COMPRESSION ;

INSERT INTO dbo.Addresses
VALUES('1 Carter Drive', 'Hedge End', 'Southampton', 'SO32 6GH')
	,('10 Apress Way', NULL, 'London', 'WC10 2FG') ;

BACKUP LOG Chapter15
	TO  DISK = 'H:\MSSQL\Backup\Chapter15PointinTime.bak' 
	WITH  RETAINDAYS = 90
	, NOINIT
	, MEDIANAME = 'Chapter15Point-in-time'
	, NAME = 'Chapter15-Log Backup'
	, COMPRESSION ;

INSERT INTO dbo.Addresses
VALUES('12 SQL Street', 'Botley', 'Southampton', 'SO32 8RT')
	,('19 Springer Way', NULL, 'London', 'EC1 5GG') ;

TRUNCATE TABLE dbo.Addresses ;

BACKUP LOG Chapter15
	TO  DISK = 'H:\MSSQL\Backup\Chapter15PointinTime.bak' 
	WITH  RETAINDAYS = 90
	, NOINIT
	, MEDIANAME = 'Chapter15Point-in-time'
	, NAME = 'Chapter15-Log Backup'
	, COMPRESSION ;
GO
