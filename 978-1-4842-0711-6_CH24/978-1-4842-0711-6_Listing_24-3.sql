;WITH EventsHierarchy
AS
( 
	SELECT 
		type
		, type_name
		, CAST(type_name as NVARCHAR(4000)) AS type_hierarchy
		, parent_type
	FROM sys.trigger_event_types
	WHERE parent_type IS NULL

	UNION ALL

	SELECT 
		TET.type
		, TET.type_name
		, CONCAT(TE.type_hierarchy,' \ ' , TET.type_name)
		, TET.parent_type
	FROM   sys.trigger_event_types TET
		      INNER JOIN EventsHierarchy TE
				ON TET.parent_type = TE.type
)

-- Select results from CTE

SELECT 
type_name
, type_hierarchy
FROM EventsHierarchy
WHERE type_name IN ('CREATE_TABLE', 'ALTER_TABLE', 'DROP_TABLE')
ORDER BY type_name ; --type_hierarchy
