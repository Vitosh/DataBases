--create database
CREATE DATABASE PerformanceSQL
GO

USE PerformanceSQL

CREATE TABLE SomeTable
(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
SomeText NVARCHAR(60) NOT NULL,
SomeDate Date NOT NULL,
SomeInteger INT NOT NULL
)
GO

USE PerformanceSQL

--fill database with random data
--I did not have the time to wait until the end, so I have stopped the query below 5 million entries
DECLARE @I int =1
WHILE @I < 10000000  BEGIN
	SET @I = @I+ 1
	INSERT INTO SomeTable(SomeText, SomeDate, SomeInteger)
	VALUES(		
		SUBSTRING(CONVERT(varchar(40), NEWID()),0,3)+ ' ' +left(NEWID(),4) + ' beer',
		DATEADD(day, (ABS(CHECKSUM(NEWID())) % 65530), 0),
		CAST(RAND() * 100 AS INT))	
END 
GO
