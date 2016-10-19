DBCC FREEPROCCACHE
GO

SELECT * 
FROM dbo.Customers ;

SELECT * 
FROM dbo.Customers 
WHERE CreditLimit > 100000 ;
GO

SELECT SUM(Balance) TotalExposure
FROM dbo.Customers ;
GO

SELECT Duplicates.CustomerID 
	,Customers.FirstName
	,Customers.LastName
	,Duplicates.DuplicateMarker
FROM
(
	SELECT CustomerID
		,ROW_NUMBER() OVER(PARTITION BY FirstName, LastName ORDER BY FirstName, LastName) DuplicateMarker
	FROM dbo.Customers
) Duplicates
INNER JOIN dbo.Customers Customers
	ON Duplicates.CustomerID = Customers.CustomerID
WHERE Duplicates.DuplicateMarker > 1 ;
GO

SELECT TOP 5 
	execution_count
	,total_elapsed_time
	,total_worker_time
	,total_physical_reads
	,total_logical_reads
	,total_logical_writes
	,qp.dbid
	,SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,
    ((CASE statement_end_offset 
        WHEN -1 THEN DATALENGTH(st.text)
        ELSE QS.statement_end_offset END 
            - QS.statement_start_offset)/2) + 1) Query
	,qp.query_plan
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp
ORDER BY total_elapsed_time DESC ;
