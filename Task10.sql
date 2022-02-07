--USE MASTER
--CREATE DATABASE Clinic ON (NAME=Clinic , FILENAME = 'c:\temp\Clinic.mdf' )
--I created the database by using the Create Database option, so the previous two commands were not needed on my query.
CREATE TABLE patient (pID int IDENTITY PRIMARY KEY, surname VARCHAR(50) NOT NULL, name VARCHAR(50) NOT NULL, address VARCHAR(100), symptoms VARCHAR(150))
CREATE TABLE diseases (dID VARCHAR(10) PRIMARY KEY, diseasename VARCHAR(200) NOT NULL, site VARCHAR(100), comments VARCHAR(150), specifications VARCHAR(200), diagnosed BIT)
-- The way the ICD10 is portrayed is with a VARCHAR type of distinguishing index/unique identifier, it's the same as what I called my dID
-- Some comments can be made, I also added a column diagnosed which is BIT value as a Boolean for if it has been diagnosed or not before
CREATE TABLE medicine (mID INT IDENTITY PRIMARY KEY, medicinename VARCHAR(200), prescription BIT, stocked BIT, dID VARCHAR(10) FOREIGN KEY REFERENCES diseases ON DELETE CASCADE)
CREATE TABLE medical_staff (msID int PRIMARY KEY, surname VARCHAR(50) NOT NULL, name VARCHAR(50) NOT NULL, authorization_number INT,position VARCHAR(50), appointment BIT, dID VARCHAR(10) FOREIGN KEY REFERENCES diseases ON DELETE NO ACTION, mID INT FOREIGN KEY REFERENCES medicine ON DELETE CASCADE)
CREATE TABLE patients_visits (pvID int IDENTITY PRIMARY KEY,pID int FOREIGN KEY REFERENCES patient ON DELETE CASCADE, dID VARCHAR(10) FOREIGN KEY REFERENCES diseases ON DELETE NO ACTION, appointment DATETIME, diagnosis VARCHAR(100), comments VARCHAR(200), prescription BIT)
-- For Prescription I used BIT, just to specify whether the patient received a prescription or not
INSERT INTO patient (surname, name, address, symptoms) VALUES ('Lovell', 'Dominic', 'Neverland', 'Fear and tiredness')
INSERT INTO diseases (dID, site, diseasename, specifications, diagnosed) VALUES ('C10', 'Abdomen/All sites','BlackDeath', 'ICD10', 0)
INSERT INTO patients_visits (appointment, diagnosis, prescription) VALUES ('2020-07-03', 'Pills', 1)
INSERT INTO medical_staff (msID ,surname, name, authorization_number, position, appointment) VALUES (101, 'Iron', 'Giant', 123, 'Surgeon', 1)
INSERT INTO medicine (medicinename, prescription, stocked) VALUES ('BestMed', 1,0)
SELECT * FROM patient, patients_visits
SELECT * FROM diseases
SELECT * FROM medicine
SELECT * FROM medical_staff
DROP TABLE patient, patients_visits, diseases, medicine, medical_staff
--DROP DATABASE Clinic