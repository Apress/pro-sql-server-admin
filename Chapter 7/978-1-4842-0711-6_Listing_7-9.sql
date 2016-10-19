SELECT 
DB_NAME(database_id) 'Database'
,OBJECT_NAME(i.object_id) TableName
,i.index_id
,i.name
,user_seeks
,last_user_seek
,user_scans
,user_lookups
,last_user_lookup
,last_user_scan
,user_updates
,last_user_update
FROM sys.dm_db_index_usage_stats ius
INNER JOIN sys.indexes i 
ON ius.object_id = I.object_id 
	AND ius.index_id = i.index_id
ORDER BY user_updates - (user_seeks + user_scans + user_lookups) DESC 
