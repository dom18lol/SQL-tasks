SELECT FirstName , LastName FROM Employees WHERE BirthDate < (SELECT MIN(BirthDate) FROM Employees WHERE City LIKE 'London')
SELECT ProductID , SUM( Quantity ) AS SumA FROM [ORDER DETAILS] GROUP BY PRODUCTID HAVING SUM(QUANTITY) > 100
SELECT FirstName , LastName FROM Employees WHERE EmployeeID =(SELECT ReportsTo FROM Employees WHERE BirthDate = (SELECT MAX(BirthDate) FROM Employees))
SELECT * FROM Territories
SELECT DISTINCT TerritoryDescription FROM Territories WHERE TerritoryID IN (SELECT TerritoryID FROM EmployeeTerritories WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE City LIKE 'London'))
IF NOT EXISTS (SELECT EmployeeID FROM Employees WHERE City LIKE 'Wars%') SELECT FirstName, LastName FROM Employees WHERE City LIKE 'London'
SELECT Employees.FirstName , Employees.LastName , Title FROM Employees WHERE HireDate = (SELECT MIN(HireDate) FROM Employees )


--Tasks:
--1 Display information on how many employees are from the same city.
SELECT COUNT(EmployeeID) FROM Employees GROUP BY City;

--2 Display information on the number of orders supported by a particular employee.
SELECT Employees.EmployeeID,COUNT(Orders.EmployeeID) AS 'Count Of Employees' FROM Orders, Employees GROUP BY Employees.EmployeeID
SELECT Employees.FirstName,Employees.LastName,COUNT(Orders.EmployeeID) FROM Orders, Employees GROUP BY Employees.FirstName,Employees.LastName

--3 Determine the average value of unproduced items.
--Using Discontinued for unproduced items
SELECT AVG(UnitPrice) AS 'Average Of Unproduced' FROM Products WHERE Discontinued=1 
SELECT AVG(UnitPrice*UnitsInStock) FROM Products WHERE Discontinued=1 

--4 Display information on the number of employees in each position.
SELECT Employees.Title, COUNT(*) FROM Employees GROUP BY Title;

--5 Check which suppliers have more than 100 products in stock.
SELECT ProductID, Products.SupplierID, SUM( UnitsInStock ) AS 'More Than 100' FROM [Products] GROUP BY PRODUCTID, SupplierID HAVING SUM(UnitsInStock) > 100

--6 Display information on suppliers, the average value of stored products in stock by a given supplier, for those products that are not produced.
SELECT SupplierID, AVG(UnitPrice * UnitsInStock) AS 'Average of Stored Products' FROM Products GROUP BY SupplierID
SELECT SupplierID, AVG(UnitPrice * UnitsInStock) AS 'Average of Stored Products' FROM Products WHERE Discontinued=1 GROUP BY SupplierID
SELECT SupplierID, AVG(UnitPrice) AS 'Average of Stored Products' FROM Products GROUP BY SupplierID
SELECT SupplierID, AVG(UnitPrice) AS 'Average of Stored Products' FROM Products WHERE Discontinued=1 GROUP BY SupplierID

--7 Display the number of orders delivered only to countries beginning with the first letter of Your names
--(Different Letters for comparison)
SELECT SUM(Freight) AS 'Final Income', COUNT(Quantity) AS 'Number of Orders Delivered' FROM Orders, [Order Details] WHERE Orders.ShipCountry LIKE ('D%')
SELECT SUM(Freight) AS 'Final Income', COUNT(Quantity) AS 'Number of Orders Delivered' FROM Orders, [Order Details] WHERE Orders.ShipCountry LIKE ('L%')
SELECT SUM(Freight) AS 'Final Income', COUNT(Quantity) AS 'Number of Orders Delivered' FROM Orders, [Order Details] WHERE Orders.ShipCountry LIKE ('J%')
SELECT SUM(Freight) AS 'Final Income', COUNT(Quantity) AS 'Number of Orders Delivered' FROM Orders, [Order Details] WHERE Orders.ShipCountry LIKE ('P%')

--8 Please find the ID of employees who completed less than 10 orders between July and October 1996
--SELECT EmployeeID, SUM(OrderID) AS 'Orders Processed' FROM Orders WHERE MONTH(ShippedDate)>6 AND MONTH(ShippedDate)<11 AND YEAR(ShippedDate)>1995 AND YEAR(ShippedDate)<1996 GROUP BY EmployeeID HAVING SUM(OrderID) < 10 
SELECT EmployeeID, COUNT(OrderID) AS 'Orders Processed' FROM Orders WHERE MONTH(ShippedDate) > 6 AND MONTH(ShippedDate) <11 AND YEAR(ShippedDate) > 1995 AND YEAR(ShippedDate) <1997 GROUP BY EmployeeID HAVING COUNT(OrderID) < 10