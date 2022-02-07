-- Example 1:
SELECT EmployeeID , LastName , FirstName , City FROM Employees WHERE City IN (SELECT City FROM Customers);-- Example 2:
SELECT EmployeeID, LastName, FirstName, City FROM Employees WHERE City LIKE (SELECT City FROM Customers WHERE CompanyName like 'Trai%');

-- 1
SELECT FirstName, LastName FROM Employees WHERE BirthDate < (SELECT MIN(BirthDate) FROM Employees WHERE City LIKE 'London')

-- 2. Return the information about the category identification number and its name for the product stored in the greatest quantity.
--SELECT CategoryID FROM Categories WHERE ProductID IN (SELECT MAX(UnitsInStock) FROM Products)
SELECT DISTINCT Products.CategoryID, Products.ProductName FROM Products WHERE UnitsInStock =(SELECT MAX(UnitsInStock) FROM Products)
-- 3. Return information about the product identification number and the sum of the ordered quantities on individual orders for 
-- this product if the total quantity on all orders is different from that indicated in the Products table.
SELECT [Order Details].ProductID, Quantity FROM [Order Details] WHERE Quantity !=( SELECT SUM(UnitsOnOrder) FROM Products)

-- 4. Display information on the name of the supplier who delivers the last (by date) order.
SELECT ShipName, ShippedDate FROM Orders WHERE ShippedDate = (SELECT MAX(ShippedDate) FROM Orders)
-- 5
SELECT FirstName, LastName FROM Employees WHERE EmployeeID =(SELECT ReportsTo FROM employees WHERE BirthDate = (SELECT MAX(BirthDate) FROM Employees))

-- 6. Display the name of the region to which New York territory belongs.
SELECT * FROM Territories, Region
-- SELECT RegionDescription FROM Region WHERE RegionID ="SHOULD BE IN" (SELECT RegionID FROM Territories WHERE TerritoryDescription LIKE 'New York')
SELECT RegionDescription FROM Region WHERE RegionID IN (SELECT RegionID FROM Territories WHERE TerritoryDescription LIKE '%New York%')

-- 7. Assuming the uniqueness of the company’s name, check whether any of the customers are also suppliers.
SELECT CustomerID, CompanyName FROM Customers WHERE CompanyName IN (SELECT CompanyName FROM Suppliers)

-- 8. Display the numbers and dates of orders belonging to employees born before 1955.
SELECT OrderID, OrderDate FROM Orders WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE YEAR(BirthDate)<1955)

-- 9
SELECT DISTINCT TerritoryDescription FROM Territories WHERE TerritoryID IN (SELECT TerritoryID FROM EmployeeTerritories WHERE EmployeeID IN (SELECT EmployeeID FROM Employees WHERE City LIKE 'London' ))

-- 10. Display information about the first and last names of employees living in the same cities as the youngest and oldest employee.
--(Showed only one name) SELECT FirstName, LAstName, City FROM Employees WHERE BirthDate IN (SELECT MIN(Birthdate) FROM Employees WHERE Birthdate IN (SELECT MAX(Birthdate) FROM Employees WHERE City IN (SELECT DISTINCT City FROM Employees))) 
SELECT FirstName, LAstName, City FROM Employees WHERE BirthDate IN (SELECT MIN(Birthdate) FROM Employees WHERE City IN (SELECT DISTINCT City FROM Employees))
SELECT FirstName, LAstName, City FROM Employees WHERE BirthDate IN (SELECT MAX(Birthdate) FROM Employees WHERE City IN (SELECT DISTINCT City FROM Employees))
-- 2 queries it works perfectly fine, as above, but show only one name, whereas the single query shows more employees and most of them living in London
SELECT FirstName, LastName, City FROM Employees WHERE City IN (SELECT City FROM Employees WHERE BirthDate in ((SELECT MAX(Birthdate) FROM Employees), (SELECT MIN(Birthdate) FROM Employees)))

-- 11
IF EXISTS (SELECT ProductName FROM Products WHERE CategoryID=100) Select ProductName FROM Products
IF EXISTS (SELECT ProductName FROM Products WHERE CategoryID=1) Select ProductName FROM Products

-- 12
IF NOT EXISTS (SELECT EmployeeID FROM Employees WHERE City LIKE 'Wars%' ) SELECT FirstName, LastName FROM Employees WHERE City LIKE 'London'

-- 13
-- IF EXISTS (SELECT DISTINCT SupplierID FROM Products WHERE UnitsInStock>100) Select DISTINCT MAX(Unitprice) from Products
IF EXISTS (SELECT SupplierID FROM Products  GROUP BY SupplierID HAVING sum(UnitsInStock)>100)  SELECT MAX(unitprice) AS 'Max Price' FROM Products HAVING SUM(UnitsInStock)>100

-- 14
IF EXISTS (SELECT  supplierid FROM products GROUP BY SupplierID HAVING SUM(UnitsInStock)>100) SELECT MAX(unitprice), SupplierID FROM Products GROUP BY SupplierID HAVING SUM(UnitsInStock)>100
