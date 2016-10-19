USE Master
GO

--Create Database Chapter 6 using default settings from Model

CREATE DATABASE Chapter6 ;
GO

USE Chapter6
GO

--Create Partition Function

CREATE PARTITION FUNCTION PartFunc(Date)
AS RANGE LEFT
FOR VALUES('2012-01-01', '2014-01-01') ;
