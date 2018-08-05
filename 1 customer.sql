USE Tax2
GO

DROP TABLE IF EXISTS Debt;
DROP TABLE IF EXISTS Taxreturn;
DROP TABLE IF EXISTS DonationRebate;
DROP TABLE IF EXISTS Individual;
DROP TABLE IF EXISTS Organization;
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
(
CustomerID INT IDENTITY(1,1) PRIMARY KEY,
FName VARCHAR(50) NOT NULL,
LName VARCHAR(50) NOT NULL,
Register VARCHAR(5) NOT NULL,
Active VARCHAR(5) NOT NULL,
Geography VARCHAR(50) NOT NULL,
TimeRegister DATETIME NOT NULL
);

DROP PROCEDURE IF EXISTS customercreation;
GO

CREATE PROCEDURE customercreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code1 INT
DECLARE @Code2 INT
DECLARE @Code3 INT
DECLARE @Code4 INT
DECLARE @FName varchar(50)
DECLARE @LName VARCHAR(50)
DECLARE @Register varchar(5)
DECLARE @Active varchar(5)
DECLARE @Geography VARCHAR(50)
DECLARE @start DATETIME = '2015-01-01 08:00:00'
DECLARE @end DATETIME = '2017-01-01 08:00:00'
DECLARE @TimeRegister DATETIME

WHILE @Counter< @total
BEGIN
SET @Code1 =(SELECT floor(RAND()*10 +1))
SET @Code2 =(SELECT floor(RAND()*2 +1))
SET @Code3 =(SELECT floor(RAND()*3 +1))
SET @Code4 =(SELECT floor(RAND()*2 +1))

SET @FName=(SELECT CASE @Code1
WHEN 1 THEN CONCAT('John ',@Counter)
WHEN 2 THEN CONCAT('Kelvin ',@Counter)
WHEN 3 THEN CONCAT('Tom ',@Counter)
WHEN 4 THEN CONCAT('Stephan ',@Counter)
WHEN 5 THEN CONCAT('Steven ',@Counter)
WHEN 6 THEN CONCAT('Bella ',@Counter)
WHEN 7 THEN CONCAT('Jackie Sales ',@Counter)
WHEN 8 THEN CONCAT('Helen Park ',@Counter)
WHEN 9 THEN CONCAT('Nelson Century ',@Counter)
WHEN 10 THEN CONCAT('Tracy',@Counter)
END)

SET @LName=(SELECT CASE @Code1
WHEN 1 THEN CONCAT('Dong',@Counter)
WHEN 2 THEN CONCAT('Burn',@Counter)
WHEN 3 THEN CONCAT('Thomson',@Counter)
WHEN 4 THEN CONCAT('Walker',@Counter)
WHEN 5 THEN CONCAT('Williams',@Counter)
WHEN 6 THEN CONCAT('Smith',@Counter)
WHEN 7 THEN CONCAT('Taylor',@Counter)
WHEN 8 THEN CONCAT('Davis',@Counter)
WHEN 9 THEN CONCAT('Clark',@Counter)
WHEN 10 THEN CONCAT('Thomas',@Counter)
END)

SET @Register= (SELECT CASE @Code2
WHEN 1 THEN 'No'
WHEN 2 THEN 'Yes'
END)

SET @TimeRegister = (SELECT CHOOSE(@Code2,Null,
									DATEADD(DAY, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY, @start, @end)), @start)))

SET @Active=(SELECT CASE @Register
WHEN 'No' THEN 'None'
WHEN 'Yes' THEN 
	(SELECT CASE @Code4
		WHEN 1 THEN 'No'
		WHEN 2 THEN 'Yes'
		END)
END)

SET @Geography= (SELECT CASE @Code3
WHEN 1 THEN 'Auckland'
WHEN 2 THEN 'South Island'
WHEN 3 THEN 'Rest of North Island'
END)

INSERT INTO Customer
        ( FName,LName, Register, Active,Geography,TimeRegister )
VALUES( @FName,@LName,@Register,@Active,@Geography,@TimeRegister)

SET @Counter+=1
END
GO

INSERT INTO Customer
        ( FName,LName, Register, Active,Geography,TimeRegister )
Exec customercreation @total= 90001

select * from Customer



