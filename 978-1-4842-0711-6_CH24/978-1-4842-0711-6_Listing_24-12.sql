CREATE TABLE #Triggers  
(name	NVARCHAR(128), 
scope	NVARCHAR(128)) ;

INSERT INTO #Triggers
SELECT 
	name
	,'Server'
FROM sys.server_triggers ;

DECLARE @SQL	NVARCHAR(MAX) ;

SET @SQL = (SELECT 'INSERT INTO #Triggers SELECT name, ''' 
						+ d.name 
						+ ''' FROM ' 
						+ d.name 
						+ '.sys.triggers WHERE parent_class = 0 AND is_ms_shipped = 0 ; ' AS [data()]
			FROM sys.databases d
			FOR XML PATH ('')) ;

EXEC (@SQL) ;

SELECT * 
FROM #Triggers ;

DROP TABLE #Triggers ;
