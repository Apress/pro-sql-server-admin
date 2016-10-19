SELECT 
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
WHERE SUBSTRING(ST.text, (QS.statement_start_offset/2) + 1,
    ((CASE statement_end_offset 
        WHEN -1 THEN DATALENGTH(st.text)
        ELSE QS.statement_end_offset END 
            - QS.statement_start_offset)/2) + 1) = 'SELECT Duplicates.CustomerID 
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
WHERE Duplicates.DuplicateMarker > 1’
ORDER BY total_elapsed_time DESC ;'
