SELECT physical_name
FROM sys.master_files
WHERE database_id = DB_ID(‘Chapter8’)
    AND type_desc = ‘Log’ ;
