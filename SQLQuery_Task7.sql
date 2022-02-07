begin tran 

--Task 1
INSERT INTO Employees (FirstName,LastName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country,Notes,ReportsTo) VALUES ('Dominic','Lovell','CEO','Mr.',1999-04-18,2020-05-07,'23rd Street', 'Star City','NY',90009,'USA','IB',5)
--SELECT * FROM Employees
--Task 2
UPDATE Employees SET NOTES='Future Biomedical Engineer' Where FirstName='Dominic' AND LastName='Lovell'
--Task 3
SELECT * FROM Employees
DELETE FROM Employees Where FirstName='Dominic' AND LastName='Lovell'
SELECT * FROM Employees
--Task 4
SELECT* FROM Region
INSERT INTO Region (RegionID,RegionDescription) VALUES (5,'Central')
SELECT* FROM Region
--Task 5
INSERT INTO Employees (FirstName,LastName)  (SELECT FirstName,LastName FROM Employees WHERE BirthDate = (SELECT MAX( BirthDate) FROM Employees))
SELECT * FROM Employees
--Task 6
SELECT * FROM Orders
SELECT * FROM [Order Details]
--INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry,EmployeeID) SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'El Domingo','24 Goodmorning Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil',EmployeeID FROM Employees Where FirstName='Dominic' AND LastName='Lovell'
--INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry,EmployeeID) SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 32.30, 'El Domingo','24 Goodmorning Street', 'Resende', 'SP',08737-363, 'Brazil',EmployeeID FROM Employees Where FirstName='Dominic' AND LastName='Lovell'
--INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry,EmployeeID) SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 32.31, 'El Domingo','24 Goodmorning Street', 'Resende', 'SP',08737-363, 'Brazil',EmployeeID FROM Employees Where FirstName='Dominic' AND LastName='Lovell'
--INSERT INTO Orders (EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry) VALUES ( 1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'El Domingo','24 Goodnight Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil')
--INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry) VALUES (1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'El Domingo','24 Goodnight Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil')
--INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry) 
--SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'El Domingo','24 Goodnight Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil' FROM Orders O JOIN Employees E ON O.EmployeeID = E.EmployeeID Where FirstName='Dominic' AND LastName='Lovell'
--UPDATE [Order Details] SET Quantity=6 WHERE ORDERID=(Select O.OrderID from Employees E JOIN Orders O ON E.EmployeeID=O.EmployeeID  Where FirstName='Dominic' AND LastName='Lovell')
--DELETE FROM Employees Where FirstName='Dominic' AND LastName='Lovell'
--select * FROM [Order Details]Where Quantity=6
INSERT INTO Orders (ShipCity, EmployeeID) VALUES ('London',10),('Athens',10),('Star City',10), ('New York',10), ('Blackpool',10) 
--INSERT INTO [Order Details] (OrderID,ProductID,Quantity) VALUES (11135, 3, 4), (11135, 20, 10), (11135,12,3), (11135,24,15), (11135,8,1)
DELETE FROM Employees Where EmployeeID=10 --AND LastName = 'Lovell'

--Task 7 
Update Orders SET EmployeeID=(Select EmployeeID from Employees Where ReportsTo IS NULL) Where EmployeeID=(SELECT EmployeeID FROM Employees WHERE FirstName='Dominic' AND LastName='Lovell')
SELECT*FROM Orders
UPDATE Orders set EmployeeID=(select top 1 EmployeeID from Employees where ReportsTo is null order by EmployeeID) where ShipCity = 'Blackpool' OR  Shipcity='Star City' OR ShipCity='Athens'
--INSERT INTO Orders (EmployeeID,OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry) VALUES (2, 1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'El Domingo','24 Goodnight Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil')
UPDATE Orders SET EmployeeID=2, Freight=32.00 WHERE EmployeeID=10
--Task 8
INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry,EmployeeID) SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 12.34, 'Starbucks','24 Goodmorning Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil',EmployeeID FROM Employees Where ReportsTo IS NULL
INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry,EmployeeID) SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'Bearclaw','24 Goodmorning Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil',EmployeeID FROM Employees Where ReportsTo IS NULL
INSERT INTO Orders (OrderDate,RequiredDate,ShippedDate,ShipVia,Freight,ShipName,ShipAddress,ShipCity,ShipRegion,ShipPostalCode,ShipCountry,EmployeeID) SELECT 1996-07-05,1996-08-16,1996-07-10, 3, 32.32, 'Floating Donuts','24 Goodmorning Street', 'Rio de Janeiro', 'RJ',05454-876, 'Brazil',EmployeeID FROM Employees Where ReportsTo IS NULL
--Task 9
UPDATE Orders SET ShipName='George Donuts'  Where ShipName='Floating Donuts'
UPDATE Orders SET Freight=12  Where Freight=12.34 AND ShipName='Starbucks'
UPDATE Orders SET ShipCountry='USA'  Where ShipName='Bearclaw'
SELECT*FROM Orders
--Task 10
--DELETE FROM [Order Details]  WHERE (SELECT ReportsTo FROM Orders O JOIN Employees E ON O.EmployeeID=E.EmployeeID)=NULL
SELECT*FROM [Order Details]
SELECT * FROM Orders
DELETE FROM [Order Details] WHERE  OrderID>=11070 --Or any number from those created
--Task 11
SELECT FirstName FROM Employees
DELETE FROM Employees Where FirstName='Dominic' --AND LastName = 'Lovell'

rollback