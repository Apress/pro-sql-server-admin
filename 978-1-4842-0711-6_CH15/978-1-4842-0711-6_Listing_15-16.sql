--Backup the database

BACKUP DATABASE Chapter15
	TO  DISK = N'H:\MSSQL\Backup\Chapter15PageRestore.bak' 
	WITH FORMAT
	, NAME = N'Chapter15-Full Backup'
	, STATS = 10 ;

--Corrupt a page in the Contacts table

ALTER DATABASE Chapter15 SET SINGLE_USER WITH NO_WAIT ;
GO

DECLARE @SQL NVARCHAR(MAX)

SELECT @SQL = 'DBCC WRITEPAGE(' +
(
	SELECT CAST(DB_ID('Chapter15') AS NVARCHAR)
) +
', ' +
(
	SELECT TOP 1 CAST(file_id AS NVARCHAR)
	FROM dbo.Contacts
	CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%)
) +
 ', ' +
(
	SELECT TOP 1 CAST(page_id AS NVARCHAR)
	FROM dbo.Contacts
	CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%)
) +
', 2000, 1, 0x61, 1)' ;

EXEC(@SQL) ;

ALTER DATABASE Chapter15 SET MULTI_USER ;
GO
