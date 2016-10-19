USE [Chapter7]
GO

--Create multi-column statistic on FirstName and LastName

CREATE STATISTICS [Stat_FirstName_LastName] ON [dbo].[CustomersDisc]([FirstName], [LastName])
GO

--Create filtered statistic on NetAmount

CREATE STATISTICS [Stat_NetAmount_Filter_OrderDate] ON [dbo].[OrdersDisc]([NetAmount])
WHERE OrderDate > '2014-01-01'
GO
