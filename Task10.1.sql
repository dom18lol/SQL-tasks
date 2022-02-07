--USE MASTER
--CREATE DATABASE NewClinic on (NAME=NewClinic,FILENAME='c:\tmp\NewClinic.mdf')
-- I created the database by using the Create Database option, so the previous two commands were not needed on my query.
CREATE TABLE medical_staff (staffID INT IDENTITY PRIMARY KEY, position VARCHAR(30) NOT NULL, name VARCHAR(50) NOT NULL, surname VARCHAR(50) NOT NULL, authorizationNumber int NOT NULL, SecondPositionName VARCHAR(20))
-- Here I used it as an identity key, because I wasn't sure which way to do it and then added a second position which can be null
-- but isn't always depending on the individual and if he has or occupies more positions
CREATE TABLE patients (patientID INT IDENTITY PRIMARY KEY, name VARCHAR(50), surname VARCHAR(50), address varchar(100), symptoms VARCHAR(150))
CREATE TABLE medicine (medsID INT IDENTITY PRIMARY KEY, medicineName VARCHAR(300), comments VARCHAR(300), stocked BIT,type varchar(50) NOT NULL)
CREATE TABLE diseases(ICD10 varchar(50) PRIMARY KEY, site VARCHAR(50), diseasename VARCHAR(50) NOT NULL,medsID INT FOREIGN KEY REFERENCES medicine ON DELETE CASCADE, comments varchar(300), diagnosed BIT)
-- I named the ID as ICD10, and again used diagnosed (Boolean) to make sure the disease exists in the database or is a new disease.
CREATE TABLE patient_visits (visitID INT IDENTITY PRIMARY KEY,staffID INT FOREIGN KEY REFERENCES medical_staff ON DELETE CASCADE,patientID INT FOREIGN KEY REFERENCES patients ON DELETE CASCADE,appointment DateTime NOT NULL, comments VARCHAR(200), diagnosis varchar(100) NOT NULL,ICD10 varchar(50) FOREIGN KEY REFERENCES diseases ON DELETE CASCADE,medsID INT FOREIGN KEY REFERENCES medicine ON DELETE NO ACTION,symptoms varchar(200) NOT NULL, prescription BIT)
-- For Prescription I used BIT, just to specify whether the patient received a prescription or not
-- I used patient_visits as the "centre" of my database trying to follow the directions from the Tasks
DROP TABLE patients, patient_visits, diseases, medicine, medical_staff
--DROP DATABASE NewClinic