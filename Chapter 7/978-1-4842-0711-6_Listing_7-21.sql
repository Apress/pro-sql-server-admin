CREATE XML INDEX SXI_OrderSummary_PATH ON OrderSummary(OrderSummary)
USING XML INDEX PXI_OrderSummary
FOR PATH
GO

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

SET STATISTICS TIME ON

SELECT * 
FROM OrderSummary
WHERE OrderSummary.exist('/OrderSummary/CustomerDetails/.[@CreditLimit = 0]') = 1
