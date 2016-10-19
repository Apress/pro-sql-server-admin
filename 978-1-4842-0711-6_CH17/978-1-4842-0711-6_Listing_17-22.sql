USE Chapter17
GO

EXEC sp_create_plan_guide 
	@name = N'[PlanGuide-FindDuplicates]'
	, @stmt = N'SELECT Duplicates.CustomerID 
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
, @type = N'SQL'
, @hints = N'OPTION(LOOP JOIN)' ;
GO
