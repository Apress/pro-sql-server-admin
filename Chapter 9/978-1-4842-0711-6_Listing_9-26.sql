USE Master
GO

--Create Server Audit

CREATE SERVER AUDIT [Audit-Chapter9]
TO FILE 
(	FILEPATH = N'C:\Audit'
	,MAXSIZE = 512 MB
	,MAX_ROLLOVER_FILES = 2147483647
	,RESERVE_DISK_SPACE = OFF
)
WITH
(	QUEUE_DELAY = 1000
	,ON_FAILURE = CONTINUE
) ;

USE Chapter9
GO

--Create database user from Danielle Login

CREATE USER Danielle FOR LOGIN Danielle WITH DEFAULT_SCHEMA=dbo ;
GO

GRANT SELECT ON dbo.SensitiveData TO Danielle ;
