--Create Logins for the Service Account, create Endpoints and assign Service Account permissions to the Endpoint on Primary Replica

:Connect CLUSTERNODE1\PRIMARYREPLICA

USE [master]
GO

CREATE LOGIN [prosqladmin\clusteradmin] FROM WINDOWS ;
GO

CREATE ENDPOINT [Hadr_endpoint] 
	AS TCP (LISTENER_PORT = 5022)
	FOR DATA_MIRRORING (ROLE = ALL, ENCRYPTION = REQUIRED ALGORITHM AES) ;
GO

ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED ;
GO

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [prosqladmin\clusteradmin] ;
GO

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO

--Create Logins for the Service Account, create Endpoints and assign Service Account permissions to the Endpoint on Secondary Replica

:Connect CLUSTERNODE2\SYNCHA

USE [master]
GO

CREATE LOGIN [prosqladmin\ClusterAdmin] FROM WINDOWS ;
GO

CREATE ENDPOINT [Hadr_endpoint] 
	AS TCP (LISTENER_PORT = 5022)
	FOR DATA_MIRRORING (ROLE = ALL, ENCRYPTION = REQUIRED ALGORITHM AES) ;
GO

ALTER ENDPOINT [Hadr_endpoint] STATE = STARTED ;
GO

GRANT CONNECT ON ENDPOINT::[Hadr_endpoint] TO [prosqladmin\ClusterAdmin] ;
GO

IF EXISTS(SELECT * FROM sys.server_event_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER WITH (STARTUP_STATE=ON);
END
IF NOT EXISTS(SELECT * FROM sys.dm_xe_sessions WHERE name='AlwaysOn_health')
BEGIN
  ALTER EVENT SESSION [AlwaysOn_health] ON SERVER STATE=START;
END
GO

--Create Avaiability Group

:Connect CLUSTERNODE1\PRIMARYREPLICA

USE [master]
GO

CREATE AVAILABILITY GROUP [App1]
WITH (AUTOMATED_BACKUP_PREFERENCE = PRIMARY)
FOR DATABASE [Chapter13App1Customers], [Chapter13App1Sales]
REPLICA ON N'CLUSTERNODE1\PRIMARYREPLICA' WITH (ENDPOINT_URL = N'TCP://ClusterNode1.PROSQLADMIN.COM:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO)),
	N'CLUSTERNODE2\SYNCHA' WITH (ENDPOINT_URL = N'TCP://ClusterNode2.PROSQLADMIN.COM:5022', FAILOVER_MODE = AUTOMATIC, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SECONDARY_ROLE(ALLOW_CONNECTIONS = NO));
GO

--Create the Listener (Use an IP Address applicable to your environment)

ALTER AVAILABILITY GROUP [App1]
ADD LISTENER N'App1Listen' (
WITH IP
((N'192.168.0.4', N'255.255.255.0')
)
, PORT=1433);
GO

--Join the Secondary Replica

:Connect CLUSTERNODE2\SYNCHA

ALTER AVAILABILITY GROUP [App1] JOIN;
GO

--Backup Database and Log (First database)

:Connect CLUSTERNODE1\PRIMARYREPLICA

BACKUP DATABASE [Chapter13App1Customers] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.bak' WITH  COPY_ONLY, FORMAT, INIT, REWIND, COMPRESSION,  STATS = 5 ;
GO

BACKUP LOG [Chapter13App1Customers] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.trn' WITH NOSKIP, REWIND, COMPRESSION,  STATS = 5 ;
GO

--Restore Database and Log (First database)

:Connect CLUSTERNODE2\SYNCHA

RESTORE DATABASE [Chapter13App1Customers] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.bak' WITH  NORECOVERY,  STATS = 5 ;
GO

RESTORE LOG [Chapter13App1Customers] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Customers.trn' WITH  NORECOVERY, STATS = 5 ;
GO

--Wait for replica to start communicating

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

--Add first Database to the Availability Group

ALTER DATABASE [Chapter13App1Customers] SET HADR AVAILABILITY GROUP = [App1];

GO

--Backup Database and Log (Second database)

:Connect CLUSTERNODE1\PRIMARYREPLICA

BACKUP DATABASE [Chapter13App1Sales] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.bak' WITH  COPY_ONLY, FORMAT, INIT, REWIND, COMPRESSION,  STATS = 5 ;
GO

BACKUP LOG [Chapter13App1Sales] TO  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.trn' WITH NOSKIP, REWIND, COMPRESSION,  STATS = 5 ;
GO

--Restore Database and Log (Second database)

:Connect CLUSTERNODE2\SYNCHA

RESTORE DATABASE [Chapter13App1Sales] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.bak' WITH  NORECOVERY, STATS = 5 ;
GO

RESTORE LOG [Chapter13App1Sales] FROM  DISK = N'\\CLUSTERNODE1\AOAGShare\Chapter13App1Sales.trn' WITH  NORECOVERY,  STATS = 5 ;
GO

--Wait for replica to start communicating
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

--Add Second database to the Availaility Group

ALTER DATABASE [Chapter13App1Sales] SET HADR AVAILABILITY GROUP = [App1];
GO
