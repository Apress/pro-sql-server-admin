SELECT OrderNumber, OrderDate
FROM dbo.ExistingOrders 
WHERE OrderDate BETWEEN '2014-11-01' AND '2014-11-14' ;
