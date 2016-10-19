SELECT 
	b.type_name GroupName
	, a.type_name EventName
FROM sys.trigger_event_types a
INNER JOIN sys.trigger_event_types b
	ON a.parent_type = b.type 
ORDER BY b.type_name ;
