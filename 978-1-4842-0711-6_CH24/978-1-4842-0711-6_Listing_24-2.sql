SELECT a.type_name 
FROM sys.trigger_event_types a
INNER JOIN sys.trigger_event_types b
	ON a.parent_type = b.type 
WHERE b.type_name = 'DDL_TABLE_EVENTS' ;
