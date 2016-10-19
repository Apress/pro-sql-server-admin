CREATE TABLE OrderSummary
(
	CustomerID	INT	PRIMARY KEY	CLUSTERED,
	OrderSummary XML
)

INSERT INTO OrderSummary
SELECT CustomerID,
(SELECT
	CustomerDetails.FirstName FirstName
	,CustomerDetails.LastName LastName
	,CustomerDetails.CreditLimit CreditLimit
	,Orders.ProductID ProductID
	,Orders.Quantity Quantity
	,Orders.NetAmount NetAmount
FROM CustomersDisc CustomerDetails
INNER JOIN OrdersDisc Orders
	ON CustomerDetails.CustomerID = Orders.CustomerID
WHERE CustomerDetails.CustomerID = a.CustomerID
ORDER BY CustomerDetails.CustomerID
FOR XML AUTO, ROOT('OrderSummary')) OrderSummary
FROM CustomersDisc a

CREATE PRIMARY XML INDEX PXI_OrderSummary ON OrderSummary(OrderSummary)

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

SET STATISTICS TIME ON

SELECT *
FROM OrderSummary
WHERE OrderSummary.exist('/OrderSummary/CustomerDetails/.[@CreditLimit = 0]') = 1
