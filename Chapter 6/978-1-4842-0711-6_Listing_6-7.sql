--Create new partition function
CREATE PARTITION FUNCTION PartFuncWeek(DATE)
AS RANGE LEFT
FOR VALUES ('2014-11-7','2014-11-14','2014-11-21','2014-11-28') ;

--Assess spread of rows
SELECT 
	COUNT(*) 'Number of Rows'
	,$PARTITION.PartFuncWeek(OrderDate) 'Partition'
FROM dbo.ExistingOrders
GROUP BY $PARTITION.PartFuncWeek(OrderDate) ;
