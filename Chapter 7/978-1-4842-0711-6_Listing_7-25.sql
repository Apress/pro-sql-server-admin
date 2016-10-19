SELECT SUM(c.creditlimit) TotalExposure, SUM(o.netamount) TotalOrdersValue
FROM CustomersDisc c
INNER JOIN OrdersDisc o 
	ON c.CustomerID = o.CustomerID
