
/* Activity 4 */

SELECT [CustomerID],[CompanyName],[City],[Region]
  FROM [Northwind].[dbo].[Customers] WHERE  Not City= 'Berlin'  AND Not (Region='SP' OR Region='OR')
SELECT [OrderID],[Quantity]
  FROM [Northwind].[dbo].[Order Details] WHERE [Quantity] BETWEEN 10 AND 40  
SELECT [OrderID],[Quantity]
  FROM [Northwind].[dbo].[Order Details] WHERE [Quantity] IN (10 , 40)  
