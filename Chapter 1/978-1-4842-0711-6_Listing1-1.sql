SELECT COUNT(*) 
FROM sys.dm_os_schedulers
WHERE status = ‘VISIBLE ONLINE’
