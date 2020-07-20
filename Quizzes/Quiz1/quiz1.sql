/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [SupplierID]
      ,[CompanyName]
      ,[City]
  FROM [Northwind].[dbo].[Suppliers]


/****** task 2  ******/
SELECT 
      Distinct[Country]
  FROM [Northwind].[dbo].[Employees] 
SELECT [EmployeeID]
      ,[LastName]
      ,[FirstName]
      ,[Title]
      ,[TitleOfCourtesy]
      ,[BirthDate]
      ,[HireDate]
      ,[Address]
      ,[City]
      ,[Region]
      ,[PostalCode]
      ,[Country]
      ,[HomePhone]
      ,[Extension]
      ,[Photo]
      ,[Notes]
      ,[ReportsTo]
      ,[PhotoPath]
  FROM [Northwind].[dbo].[Employees] Where City = 'London'
  /* Task 3 */
  SELECT 
      [ProductName]
      
  FROM [Northwind].[dbo].[Products] Where Discontinued = 0


  /* Task 4 */
  SELECT [OrderID]
      
  FROM [Northwind].[dbo].[Order Details] Where Discount <= 0.1

  /****** Task 5 ******/
SELECT [EmployeeID]
      ,[FirstName]    
      ,[HomePhone]
      ,[Extension]
  FROM [Northwind].[dbo].[Employees] Where Region Is Null;

  /****** Task 6 ******/
SELECT [CustomerID]
      ,[CompanyName]
      ,[Phone]
  FROM [Northwind].[dbo].[Customers] Where Country = 'UK' OR Country = 'USA';