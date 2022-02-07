-- 1. For each employee born in January, display the year of his birth, the name of the territory assigned to
--him and the names of the cities to which the orders assigned to that employee were sent, provided that
--the name of the country in which these cities are located begins with ’A’
--SELECT YEAR(BirthDate) AS 'Year', TerritoryDescription, ShipCity FROM Employees, Orders, Territories WHERE Country = 'A%'
--SELECT E.BirthDate, T.TerritoryDescription, O.ShipCity FROM Employees E JOIN EmployeeTerritories ET ON E.EmployeeID =ET.EmployeeID JOIN Territories T ON ET.TerritoryID=T.TerritoryID JOIN Orders O ON E.EmployeeID=O.EmployeeID WHERE Country = 'A%' AND MONTH(E.BirthDate) = 01
SELECT YEAR(E.BirthDate), T.TerritoryDescription, O.ShipCity FROM Employees E JOIN EmployeeTerritories ET ON E.EmployeeID=ET.EmployeeID JOIN Territories T ON T.TerritoryID=ET.TerritoryID JOIN Orders O ON E.EmployeeID=O.EmployeeID WHERE Month(E.BirthDate)= 01 AND O.ShipCountry LIKE 'A%'
--2. For each supplier, write his ID number, city, fax number and company name. The displayed column headers
--should be: ID, M, F, N, respectively

SELECT SupplierID AS ID, City AS M, Fax as F, CompanyName AS N FROM Suppliers

--3. Display the company name, address, telephone number and city for such clients that contact with them
--is contact directly with the owner of the company provided that the company has a fax number

SELECT CompanyName,Address, Phone, City FROM Customers WHERE Fax IS NOT NULL AND ContactTitle='Owner'

--4. Display the names and the unit price of products supplied by suppliers such that the largest number of
--units of their products ordered is less than the smallest number of units of their products in stock.
 
--SELECT P.ProductName, P.UnitPrice FROM Products P WHERE P.SupplierID  ( MAX(P.UnitsOnOrder)<MIN(P.UnitsInStock))
--select P.ProductName, P.UnitPrice from Products P HAVING P.SupplierID In ( select SupplierID from Products  WHERE MAX(P.UnitsOnOrder)<MIN(P.UnitsInStock)group by SupplierID)
--SELECT ProductName, UnitPrice, SupplierID FROM Products P where SupplierID In (SELECT SupplierID FROM Products GROUP BY SupplierID HAVING MAX(P.UnitsOnOrder)<MIN(P.UnitsInStock))

SELECT p.ProductName, p.UnitPrice FROM  Products p WHERE SupplierID IN(SELECT SupplierID FROM Products GROUP BY SupplierID HAVING MAX(UnitsOnOrder)< MIN(UnitsInStock))
--5. For each order, display its ID number and the phone number of the supplier (manufacturer) and shipper.
--join products with order details, suppliers with products, orders with order details and shippers with orders
SELECT O.OrderID, S.Phone AS SupplyPhone, Sh.Phone As ShipPhone FROM [Order Details] OD JOIN Products P ON OD.ProductID=P.ProductID JOIN Suppliers S ON S.SupplierID = P.SupplierID JOIN Orders O ON O.OrderID=OD.OrderID JOIN Shippers Sh ON Sh.ShipperID=O.ShipVia
--6. For each manufacturer, display his ID number and date of birth of the oldest employee who executes
--orders including products from that manufacturer. Sort result by first column.
--SELECT  S.SupplierID, E.BirthDate, E.Title FROM Suppliers S JOIN Products P ON P.SupplierID=S.SupplierID JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON OD.OrderID=O.OrderID JOIN Employees E ON O.EmployeeID=E.EmployeeID WHERE E.BirthDate=(SELECT MIN(BirthDate) FROM Employees) AND S.ContactTitle='Order Administrator'  ORDER BY 1
--SELECT DISTINCT S.SupplierID, E.BirthDate, E.Title FROM Suppliers S JOIN Products P ON P.SupplierID=S.SupplierID JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON OD.OrderID=O.OrderID JOIN Employees E ON O.EmployeeID=E.EmployeeID WHERE YEAR(E.BirthDate)=1966  ORDER BY 1

SELECT P.SupplierID, MAX(E.BirthDate) FROM Products P JOIN [Order Details] OD ON OD.ProductID = P.ProductID JOIN Orders O ON O.OrderID = OD.OrderID JOIN Employees E ON E.EmployeeID = O.EmployeeID GROUP BY P.SupplierID ORDER BY P.SupplierID
--7. Display the order numbers and dates, product numbers, quantities and prices on these orders and the
--name of the employee’s supervisor assigned to the certain order.

SELECT O.OrderID, O.OrderDate, P.ProductID,P.QuantityPerUnit, P.UnitPrice, E1.FirstName, E1.LastName FROM Orders O JOIN [Order Details] OD ON O.OrderID=OD.OrderID JOIN Products P ON P.ProductID=OD.ProductID JOIN Employees E1 ON O.EmployeeID=E1.EmployeeID WHERE E1.ReportsTo IS NOT NULL
--SELECT Title, TitleOfCourtesy, Extension, ReportsTo FROM Employees
--Select S.ContactTitle From Suppliers S
--8. Display the customer’s company names, the number of their orders and the sum of the ordered products
--if the order was delivered by United Package and the average discount for the customer’s orders does not
--exceed 10 %.

SELECT C.CompanyName ,COUNT(O.ShippedDate), SUM(P.UnitsOnOrder) FROM Customers C JOIN Orders O ON O.CustomerID = C.CustomerID JOIN [Order Details] OD ON OD.OrderID=O.OrderID JOIN Products P ON P.ProductID=OD.ProductID JOIN Shippers Sh ON O.ShipVia=Sh.ShipperID WHERE Sh.CompanyName='United Package' GROUP BY C.CompanyName HAVING AVG(OD.Discount)<=0.1 

--9.Display the order number list with the name of the shipper and customer if they were delivered before
--October 15, 1996
SELECT O.OrderID, Sh.CompanyName,C.CompanyName FROM Orders O JOIN Customers C ON O.CustomerID=C.CustomerID JOIN Shippers Sh ON Sh.ShipperID=O.ShipVia WHERE o.ShippedDate < '1996.10.15'

--10.as above, with an additional condition: or were placed in 1995".

SELECT O.OrderID, Sh.CompanyName,C.CompanyName FROM Orders O JOIN Customers C ON O.CustomerID=C.CustomerID JOIN Shippers Sh ON Sh.ShipperID=O.ShipVia WHERE o.ShippedDate < '1996.10.15' OR YEAR(O.ShippedDate)=1995

--11.Display order numbers, product numbers and price if the quantity of ordered product is greater than 20
--or less than 10.
SELECT OrderID, ProductID, UnitPrice FROM [Order Details] OD WHERE Quantity>20 OR Quantity<=10

--12.Provide order numbers, product numbers and price if the quantity is in the range (−∞; 10] ∪ [20; ∞) and
--the price does not exceed 10.

SELECT OrderID, ProductID, UnitPrice FROM [Order Details] WHERE  Quantity>20 AND UnitPrice<=10 OR Quantity<=10 AND UnitPrice<=10

--13.From among all employees, select those who live in the same country where the suppliers of products
--operate, for which products are stored in an amount of 150 pieces.

SELECT E.EmployeeID FROM Employees E JOIN Orders O ON O.EmployeeID = E.EmployeeID JOIN [Order Details] OD ON OD.OrderID=O.OrderID JOIN Products P ON P.ProductID=OD.ProductID JOIN Suppliers S ON S.Country=E.Country WHERE P.UnitsInStock = 150

--14. Create a list of employees with the total value of orders completed over the past year (counting from
--1998-05-06), sorted from the best employee
--SELECT COUNT(OD.Quantity*OD.UnitPrice)  AS 'TOTAL'  FROM Employees E JOIN Orders O ON O.EmployeeID = E.EmployeeID JOIN [Order Details] OD ON O.OrderID=OD.OrderID WHERE YEAR(O.OrderDate)=1997 AND MONTH(O.OrderDate)=05 AND DAY(O.OrderDate)=06 Order BY OD.Quantity*OD.UnitPrice DESC

SELECT E.FirstName,E.LastName,COUNT(OD.Quantity*OD.UnitPrice*OD.Discount)  AS 'TOTAL'  FROM Employees E JOIN Orders O ON O.EmployeeID = E.EmployeeID JOIN [Order Details] OD ON O.OrderID=OD.OrderID WHERE O.OrderDate BETWEEN '1997.05.06' AND '1998.05.06'  Group BY E.FirstName,E.LastName 

--15. Find the name of the company that placed orders for the highest amount in the last 3 months (assuming
--today is early May 1998), also provide the order’s amount.
--SELECT S.CompanyName, COUNT(O.OrderID) AS [Nb of Orders] FROM Shippers S JOIN Orders O ON S.ShipperID = O.ShipVia WHERE (OrderDate>=(Year(1998)& Month(05)) AND OrderDate<=(Year(1998)& Month(08)))  GROUP BY S.CompanyName
--SELECT S.CompanyName, COUNT(O.OrderID) AS COUNTED, SUM(P.UnitPrice*P.UnitsOnOrder) AS Total FROM Suppliers S JOIN Products P ON S.SupplierID=P.SupplierID JOIN [Order Details] OD ON OD.ProductID=P.ProductID JOIN Orders O ON O.OrderID=OD.OrderID JOIN Shippers Sh ON O.ShipVia=Sh.ShipperID WHERE P.UnitsOnOrder=(SELECT MAX(P.UnitsOnOrder) FROM Products P) AND YEAR(O.OrderDate)=1998 AND MONTH(O.OrderDate) BETWEEN 02 AND 05 GROUP BY S.CompanyName
SELECT TOP 1 C.CompanyName, SUM(OD.Quantity*OD.UnitPrice) AS MAXP FROM Customers C JOIN Orders O ON C.CustomerID=O.CustomerID JOIN [Order Details] OD ON OD.OrderID=O.OrderID WHERE O.OrderDate BETWEEN '1998.02.01' AND '1998.05.01' GROUP BY C.CustomerID, C.CompanyName ORDER BY MAXP
--16. Find product categories (names) in which at least one product is discontinued
SELECT DISTINCT CategoryName FROM Categories C JOIN Products P ON C.CategoryID=P.CategoryID WHERE Discontinued=1

--17. Find product categories (names) in which all products are discontinued
SELECT C.CategoryName FROM Categories C JOIN Products P ON C.CategoryID=P.CategoryID WHERE Discontinued= (SELECT COUNT(Discontinued) FROM Products)
--SELECT * FROM Categories
--SELECT Discontinued FROM Products
--18View a list of employees whose orders were delayed (from early January 1998 to now).
SELECT DISTINCT E.FirstName,E.LastName FROM Employees E JOIN Orders O ON E.EmployeeID=O.EmployeeID WHERE ShippedDate>RequiredDate AND YEAR(O.OrderDate)>=1998
--SELECT DISTINCT E.FirstName, E.LastName FROM Employees E JOIN Orders O on E.EmployeeID = O.EmployeeID WHERE O.ShippedDate > O.RequiredDate AND O.ShippedDate > '1998-01-01'

--19. Display the name of the supplier whose products have not been sold in the last month counting from May
--1998.
--In the last one, you can use subquery to get information about supplierid, which meet the condition OrderDate>='1998.05.01'. When you get those IDs, you can use them to narrow down main query using "where SupplierID not in subquery". YOur current query gives you companies, 
--which sold their products exactly in 1998.05.01.
--SELECT S.CompanyName FROM Suppliers S  JOIN Products P On S.SupplierID=P.SupplierID JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON OD.OrderID=O.OrderID WHERE YEAR(O.OrderDate)=1998 AND MONTH(O.OrderDate)=05 AND UnitsOnOrder=0
--IF EXISTS(SELECT S.CompanyName FROM Suppliers S JOIN Products P On S.SupplierID=P.SupplierID JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON O.OrderID=OD.OrderID WHERE P.ReorderLevel=0 AND YEAR(O.ShippedDate)=1998 AND MONTH(O.ShippedDate)=05) SELECT Suppliers.CompanyName FROM Suppliers
--SELECT DISTINCT S.CompanyName FROM Suppliers S JOIN Products P On S.SupplierID=P.SupplierID JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON O.OrderID=OD.OrderID WHERE P.UnitsOnOrder=0 AND YEAR(O.ShippedDate)=1998 AND MONTH(O.ShippedDate)=05 AND YEAR(O.OrderDate)=1998 AND MONTH(O.OrderDate)=05
--SELECT S.CompanyName FROM Suppliers S JOIN Products P ON S.SupplierID=P.SupplierID JOIN [Order Details] OD ON OD.ProductID=P.ProductID JOIN Orders O ON OD.OrderID=O.OrderID WHERE NOT EXISTS (SELECT OrderDate FROM Orders WHERE OrderDate>='1998.05.01')
--IF NOT EXISTS (SELECT S.CompanyName FROM Suppliers S JOIN Products P ON S.SupplierID=P.SupplierID JOIN [Order Details] OD ON OD.ProductID=P.ProductID JOIN Orders O ON OD.OrderID=O.OrderID WHERE O.OrderDate>='1998.05.01') SELECT S.CompanyName FROM Suppliers S
--SELECT DISTINCT S.CompanyName FROM Suppliers S JOIN Products P ON S.SupplierID=P.SupplierID JOIN [Order Details] OD ON OD.ProductID=P.ProductID JOIN Orders O ON OD.OrderID=O.OrderID WHERE S.SupplierID NOT IN (SELECT OrderDate FROM Orders WHERE OrderDate>='1998.05.01')
--IF NOT EXISTS (SELECT * FROM Suppliers S JOIN Products P ON S.SupplierID=P.SupplierID JOIN [Order Details] OD ON OD.ProductID=P.ProductID JOIN Orders O ON OD.OrderID=O.OrderID WHERE O.OrderDate>='1998.05.01') SELECT S.CompanyName FROM Suppliers S
--SELECT DISTINCT S.CompanyName FROM Suppliers S JOIN Products P ON S.SupplierID=P.SupplierID JOIN [Order Details] OD ON OD.ProductID=P.ProductID JOIN Orders O ON OD.OrderID=O.OrderID WHERE S.SupplierID NOT IN (SELECT SupplierID FROM Suppliers WHERE O.OrderDate>='1998.05.01')

SELECT S.CompanyName FROM Suppliers S WHERE S.SupplierID NOT IN (SELECT P.SupplierId FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID JOIN Orders O ON O.OrderID = OD.OrderID WHERE OrderDate>='1998.05.01')