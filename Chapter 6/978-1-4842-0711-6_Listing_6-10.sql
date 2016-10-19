SELECT OrderNumber, OrderDate
FROM dbo.ExistingOrders 
WHERE CAST(OrderDate AS DATETIME2) BETWEEN '2014-11-01' AND '2014-11-14' ;
