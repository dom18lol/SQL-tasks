--1
SELECT Address FROM Customers WHERE Country NOT LIKE 'USA'
SELECT Suppliers.CompanyName FROM Suppliers WHERE Suppliers.HomePage NOT LIKE ''
SELECT ContactName,CompanyName, ContactTitle FROM Customers WHERE ContactTitle LIKE 'Owner'
SELECT * FROM Employees
SELECT * FROM Employees WHERE Year(HireDate) BETWEEN 1990 AND 1993
SELECT * FROM Employees WHERE Year(HireDate) < 1993
SELECT * FROM [Order Details] WHERE Discount NOT LIKE '0'
SELECT Products.ProductName FROM Products WHERE UnitsInStock<Products.UnitsOnOrder --less
SELECT Products.ProductName FROM Products WHERE UnitsInStock>Products.UnitsOnOrder --greater
SELECT Products.ProductName, UnitPrice FROM Products WHERE Discontinued!=0 AND UnitPrice>10

--2
SELECT * FROM Suppliers WHERE Country='Canada' OR Country='Japan'
SELECT *,Discontinued FROM [Order Details], [Products]
SELECT UnitPrice, UnitsInStock, UnitsOnOrder FROM Products WHERE UnitPrice>20 AND Discontinued!=0
SELECT [Order Details].UnitPrice,Quantity,Discount, [Order Details].UnitPrice*Quantity*Discount, Discontinued FROM [Order Details],Products WHERE [Order Details].UnitPrice>20 AND Discontinued=0
SELECT * FROM Suppliers WHERE (Country='Germany'OR Country='Mexico') AND (FAX='' OR Region='')
SELECT * FROM Suppliers WHERE (Country='Germany'OR Country='Mexico') 
--There are zero options because all Regions are Null, and 2/3 of Faxes are Null
SELECT * FROM Employees WHERE Country!='Germany' AND City!='Rio de Janeiro'
SELECT * FROM Orders WHERE ShipCountry!='' AND ShipRegion!='' AND ShipPostalCode!=''

--3
SELECT * FROM TERRITORIES WHERE REGIONID BETWEEN 3 AND 4
SELECT * FROM [Order Details] WHERE UnitPrice BETWEEN 45 AND 50
SELECT OrderID, Orders.ShippedDate FROM orders WHERE (Year(ShippedDate) BETWEEN 1997 AND 1998) AND (Month(ShippedDate) BETWEEN 5 AND 6)
SELECT OrderID, Orders.ShippedDate FROM Orders WHERE (Year(ShippedDate)<=1998 and Year(ShippedDate)>=1997) and (Month(ShippedDate)<=6 and Month(ShippedDate)>=5)
--There are no differences, they show the same number of orders
SELECT * FROM Customers WHERE Customers.CustomerID LIKE 'L%S' 

--4
SELECT * FROM Employees WHERE TitleOfCourtesy IN ('Mrs.','Ms.')
SELECT * FROM Suppliers WHERE City IN ('Rio de Janeiro','Cologne','Munich')
SELECT Employees.LastName,Employees.FirstName,Employees.HireDate,Employees.TitleOfCourtesy FROM Employees WHERE TitleOfCourtesy IN ('Mr.','Dr.')