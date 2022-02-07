
--USE MASTER
--CREATE DATABASE Publications ON (NAME = Publications, FILENAME = 'C:\temp\Publications.mdf')
--Database created from diagram, that's why the above commands are commented
--Task 6
--A
--ALTER Table Publishers ADD CONSTRAINT CK_id_publisher CHECK (ID_publisher LIKE '[A-Z][A-Z][A-Z][A-Z]')
ALTER Table Publishers ADD CONSTRAINT CK_id_publisher CHECK (upper(ID_publisher) = ID_publisher)
--Two ways of converting them to upper, used the upper commande, so the program is more versatile and reusable
--B
--ALTER Table Shops ADD CONSTRAINT CK_id_shop CHECK (ID_shop LIKE '[A-Z][A-Z][A-Z][A-Z]')
ALTER Table Shops ADD CONSTRAINT CK_id_shop CHECK (upper(ID_shop)= ID_shop) 
--C
ALTER TABLE Shops ADD CONSTRAINT CK_shops_zipcode CHECK (PostalCode LIKE '[0-9][0-9]-[0-9][0-9][0-9]')
--D
ALTER TABLE Tasks ADD CONSTRAINT CK_min_level CHECK (Level_min>10)
ALTER TABLE Tasks ADD CONSTRAINT CK_max_level CHECK (Level_max<250)
--E
ALTER TABLE Employees ADD CONSTRAINT CK_acceptance_date CHECK (Date_of_acceptance>'1980-01-01')
ALTER TABLE Sale ADD CONSTRAINT CK_order_date CHECK (OrderDate>'1980-01-01')
--F
ALTER TABLE AuthorOfBooks ADD CONSTRAINT CK_royalty CHECK (Royalties>=0)
ALTER TABLE Books ADD CONSTRAINT CK_price_sale CHECK (Price>=0)

--Task 7
INSERT INTO Tasks (Description, Level_min, Level_max) VALUES ('Something to do',11,25)
--INSERT INTO Employees (FirstName,LastName,[Level], ID_publisher, Date_of_acceptance, ID_task) VALUES ('Dominic', 'Lovell',99, 1, '2000-01-01', 1)
--Wrong data insertion, commented so there are no errors while executing full query
INSERT INTO Books (Title, Type, Price, ReleaseDate) VALUES ('Best of the Best', 'Gaming', 25, 22-05-2020)
INSERT INTO Authors (FirstName, LAstName, Address, City, Country, PostalCode, Contracted, PhoneNumber) VALUES ('Charles', 'Dickens', 'Westmnister','London','UK','12345', 1, 0123456789)
INSERT INTO Publishers (Name, City, Country, ID_publisher) VALUES ('El Rapido', 'Chihuahua', 'Mexico', 'abcd')
--Task 8
DROP DATABASE Publications