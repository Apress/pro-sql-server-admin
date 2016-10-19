USE Chapter5
GO

CREATE TABLE dbo.FilestreamExample
(
	ID			UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE  ,
	PictureDescription	NVARCHAR(500),
	Picture			VARBINARY(MAX) FILESTREAM
);
GO

INSERT INTO FilestreamExample
    SELECT NEWID(), 'Figure 5-1. Diagram showing the SQL Server storage hierachy.', * FROM 
    OPENROWSET(BULK N'c:\Figure_5-1.jpg'  , SINGLE_BLOB) AS import; 
