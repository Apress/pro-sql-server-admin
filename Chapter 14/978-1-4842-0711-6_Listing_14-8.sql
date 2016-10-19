--Restore the first transaction log

RESTORE LOG Chapter14 FROM  DISK = N'C:\LogShippingDR\Chapter14.trn' WITH  FILE = 1,  NORECOVERY,  STATS = 10 ;
GO

--Restore the tail end of the log

RESTORE LOG Chapter14 FROM  DISK = N'C:\LogShippingDR\Chapter14_tail.trn' WITH  FILE = 1,  RECOVERY, STATS = 10 ;
GO
