:Connect CLUSTERNODE3\ASYNCDR

--Create Login for Service Account

USE [master]
GO

CREATE LOGIN [prosqladmin\ClusterAdmin] FROM WINDOWS ;
GO

--Create the Endpoint

CREATE ENDPOINT [Hadr_endpoint] 
	AS TCP (LISTENER_PORT = 5022)
	FOR DATA_MIRRORING (ROLE = ALL, ENCRYPTION = REQUIRED ALGORITHM AES) ;
GO

ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED ;
GO

--Grant the Service Account permissions to the Endpoint

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [prosqladmin\ClusterAdmin] ;
GO

--Start the AOAG Health Trace

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO

:Connect CLUSTERNODE1\PRIMARYREPLICA

USE [master]
GO

--Add the replica to the Avaialability Group

ALTER AVAILABILITY GROUP [App1]
ADD REPLICA ON N'CLUSTERNODE3\ASYNCDR' WITH (ENDPOINT_URL = N'TCP://CLUSTERNODE3.PROSQLADMIN.COM:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO));
GO

--Backup and restore the first database and log

BACKUP DATABASE [Chapter13App1Customers] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.bak' WITH  COPY_ONLY, FORMAT, INIT, REWIND, COMPRESSION,  STATS = 5 ;
GO

BACKUP LOG [Chapter13App1Customers] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.trn' WITH NOSKIP, REWIND, COMPRESSION,  STATS = 5 ;
GO

:Connect CLUSTERNODE3\ASYNCDR

ALTER AVAILABILITY GROUP [App1] JOIN;
GO

RESTORE DATABASE [Chapter13App1Customers] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.bak' WITH  NORECOVERY,  STATS = 5 ;
GO

RESTORE LOG [Chapter13App1Customers] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.trn' WITH  NORECOVERY, STATS = 5 ;
GO


-- Wait for the replica to start communicating
DECLARE @connection BIT

DECLARE @replica_id UNIQUEIDENTIFIER 
DECLARE @group_id UNIQUEIDENTIFIER

SET @connection = 0

WHILE @Connection = 0
BEGIN
	SET @group_id = (SELECT group_id 
						FROM Master.sys.availability_groups 
						WHERE name = N'App1')
	SET @replica_id = (SELECT replica_id 
						FROM Master.sys.availability_replicas 
						WHERE UPPER(replica_server_name COLLATE Latin1_General_CI_AS) = UPPER(@@SERVERNAME COLLATE Latin1_General_CI_AS) 
							AND group_id = @group_id)

	SET @connection = ISNULL((SELECT connected_state 
						FROM Master.sys.dm_hadr_availability_replica_states 
						WHERE replica_id = @replica_id), 1)

	WAITFOR DELAY '00:00:10'
END 

--Add the first Database to the Avaioability Group on the new replica

ALTER DATABASE [Chapter13App1Customers] SET HADR AVAILABILITY GROUP = [App1];
GO

--Bcakup and restore the second database and log

:Connect CLUSTERNODE1\PRIMARYREPLICA

BACKUP DATABASE [Chapter13App1Sales] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.bak' WITH  COPY_ONLY, FORMAT, INIT, REWIND, COMPRESSION,  STATS = 5 ;
GO

BACKUP LOG [Chapter13App1Sales] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.trn' WITH NOSKIP, REWIND, COMPRESSION,  STATS = 5 ;
GO

:Connect CLUSTERNODE3\ASYNCDR

ALTER AVAILABILITY GROUP [App1] JOIN;
GO

RESTORE DATABASE [Chapter13App1Sales] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.bak' WITH  NORECOVERY,  STATS = 5 ;
GO

RESTORE LOG [Chapter13App1Sales] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.trn' WITH  NORECOVERY, STATS = 5 ;
GO

-- Wait for the replica to start communicating
DECLARE @connection BIT

DECLARE @replica_id UNIQUEIDENTIFIER 
DECLARE @group_id UNIQUEIDENTIFIER

SET @connection = 0

WHILE @Connection = 0
BEGIN
	SET @group_id = (SELECT group_id 
						FROM Master.sys.availability_groups 
						WHERE name = N'App1')
	SET @replica_id = (SELECT replica_id 
						FROM Master.sys.availability_replicas 
						WHERE UPPER(replica_server_name COLLATE Latin1_General_CI_AS) = UPPER(@@SERVERNAME COLLATE Latin1_General_CI_AS) 
							AND group_id = @group_id)

	SET @connection = ISNULL((SELECT connected_state 
						FROM Master.sys.dm_hadr_availability_replica_states 
						WHERE replica_id = @replica_id), 1)

	WAITFOR DELAY '00:00:10'
END 

--Add the second database to the Avaiability Group on the new replica

ALTER DATABASE [Chapter13App1Sales] SET HADR AVAILABILITY GROUP = [App1];
GO
