--1. Display the cartesian join of tables Employees and EmployeeTerritories
--SELECT * FROM Employees, EmployeeTerritories
SELECT * FROM Employees E JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
--2. Narrow down the above information to the name, surname and identification number of the territory
--assigned to the employee
SELECT E.FirstName, E.LastName,ET.TerritoryID FROM Employees E JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID
--3. Enrich the above information with the name of the territory assigned to the employee.
SELECT E.FirstName, E.LastName,ET.TerritoryID, T.TerritoryDescription FROM Employees E JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID JOIN Territories T ON ET.TerritoryID=T.TerritoryID
--4. Enrich the above information with the name of the region to which the employee’s territory belongs.
SELECT E.FirstName, E.LastName,ET.TerritoryID,T.TerritoryDescription,R.RegionDescription FROM Employees E JOIN EmployeeTerritories ET ON E.EmployeeID = ET.EmployeeID JOIN Territories T ON ET.TerritoryID=T.TerritoryID JOIN Region R ON T.RegionID=R.RegionID

SELECT E1.FirstName, E1.LastName, E2.Firstname, E2.LastName FROM Employees E1 JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
--5. Expand the above information by the quantity of each ordered product from the Products table, the
--average price resulting from the Order Details table, and the average price from the Products table.
SELECT OD.ProductID, P.ProductName, SUM(OD.Quantity), P.QuantityPerUnit FROM Products P JOIN [Order Details] OD ON P.ProductID = OD.ProductID AND P.UnitPrice=OD.UnitPrice GROUP BY OD.ProductID, P.ProductName, P.QuantityPerUnit
--6. Display the product name along with the supplier name for products no longer manufactured.
SELECT P.ProductName, P.Discontinued, S.CompanyName FROM Suppliers S JOIN Products P ON P.SupplierID=S.SupplierID WHERE P.Discontinued > 0
-- P.ProductName=S.ContactName AND //It gives zero answers
-- , P.ProductName,S.ContactName //It errors out for some reason, ask for help
--7. Display the names of the shipping companies and the number of orders they delivered, if they were executed
--for customers from the USA (check the result for the absence of this condition).
--SELECT Sh.CompanyName, O.ShipCountry FROM Shippers Sh JOIN Orders O ON O.ShipCountry = Sh.CompanyName WHERE O.ShipCountry = 'USA'
--SELECT SH.CompanyName, O.ShipCountry, COUNT(O.OrderID) FROM Shippers SH JOIN Orders O ON SH.ShipperID=O.OrderID JOIN Customers C ON O.ShipCountry=C.Country WHERE O.ShipCountry = '%USA%'
--SELECT C.CompanyName, COUNT(O.OrderID)  from Shippers S JOIN Customers C ON C.CompanyName=S.CompanyName JOIN Orders O ON O.ShipCountry=C.Country WHERE Country='%USA%'

--SELECT SH.CompanyName, COUNT(O.OrderID) AS [Orders] FROM Shippers SH JOIN Orders O on Sh.ShipperID = O.OrderID JOIN Customers C on C.CustomerID = O.CustomerID WHERE Country LIKE '%USA%'  GROUP BY Sh.CompanyName
--Working with OrderID didnt give the results that ShipVia gave, so I did the final one with ShipVia,
-- OrderID gave 0 results
SELECT SH.CompanyName, COUNT(O.ShipVia) AS [Orders] FROM Shippers SH JOIN Orders O on Sh.ShipperID = O.ShipVia JOIN Customers C on C.CustomerID = O.CustomerID WHERE Country LIKE '%USA%'  GROUP BY Sh.CompanyName

--8. Display information about the customer’s name along with the discounts obtained (for which products,
--on which orders) if he received such discounts.
	--SELECT C.ContactName,OD.Discount FROM Customers C JOIN Products P ON C.CustomerID=P.ProductID JOIN [Order Details] OD ON P.QuantityPerUnit=OD.Quantity GROUP BY OD.Discount, C.ContactName
SELECT C.ContactName,P.ProductName, OD.Discount FROM Products P JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON OD.OrderID=O.OrderID JOIN Customers C ON C.CustomerID=O.CustomerID WHERE OD.Discount > 0 
SELECT C.CompanyName,P.ProductName, OD.Discount FROM Products P JOIN [Order Details] OD ON P.ProductID=OD.ProductID JOIN Orders O ON OD.OrderID=O.OrderID JOIN Customers C ON C.CustomerID=O.CustomerID WHERE OD.Discount > 0 
--9. Display the name and identification number of each employee, as well as the name and surname of the
--person to whom this employee is subjected.
SELECT DISTINCT E2.FirstName, E2.LastName, E2.EmployeeID FROM Employees E1 JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
SELECT E1.LastName, E1.FirstName, E1.EmployeeID, E2.LastName, E2.FirstName, E2. EmployeeID FROM Employees E1 JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID

--10. Display information about each employee’s subordinate employees.
SELECT DISTINCT E1.FirstName, E1.LastName, E1.EmployeeID FROM Employees E1 JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
SELECT E1.LastName, E1.FirstName, E1.EmployeeID, E2.LastName, E2.FirstName, E2. EmployeeID FROM Employees E1 JOIN Employees E2 ON E2.ReportsTo=E1.EmployeeID

--9 & 10 are opposite to each other, I ran two command lines for both, one showing both cases of higher and lower rank in opposite order
-- Also, I ran with just the lower and just the higher rank employees so they appear once, as you can see Andrew Fuller and 
-- Steve Buchanan appear multiple times in the connected queries. But, when looking at them distinctly there are only 2 distinct
-- employees in that rank.
SELECT E1.EmployeeID, E1.FirstName, E1.LastName, E2.FirstName, E2.LastName FROM Employees E1 JOIN Employees E2 ON E1.ReportsTo = E2.EmployeeID
SELECT E1.EmployeeID, E1.FirstName, E1.LastName, E2.FirstName, E2.LastName FROM Employees E1 JOIN Employees E2 ON E1.EmployeeID = E2.ReportsTo GROUP BY E1.EmployeeID, E1.FirstName, E1.LastName, E2.FirstName, E2.LastName
--Ran once more side by side to compare the two