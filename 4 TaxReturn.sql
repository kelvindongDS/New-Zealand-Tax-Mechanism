USE Tax2
GO

DROP TABLE IF EXISTS TaxReturn;
CREATE TABLE TaxReturn
(
TaxReturnID INT IDENTITY(1,1) PRIMARY KEY,
FilingChannel  VARCHAR(30) NOT NULL,
ReturnType VARCHAR(50) NOT NULL,
TimeRegister DATETIME NOT NULL,
ReturnAmount DECIMAL NOT NULL,

CustomerID INT,
CONSTRAINT FK_TaxReturn FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID),
);


DROP PROCEDURE IF EXISTS TaxReturncreation;
GO

CREATE PROCEDURE TaxReturncreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code1 INT
DECLARE @Code2 INT
DECLARE @Code3 INT
DECLARE @Code4 INT
DECLARE @n INT

DECLARE @TimeRegister DATETIME
DECLARE @FilingChannel varchar(30) 
DECLARE @ReturnType VARCHAR(50)
DECLARE @ReturnAmount INT
DECLARE @CustomerID INT

DECLARE @start DATETIME = '2015-01-01 08:00:00'
DECLARE @end DATETIME = '2017-01-01 08:00:00'

WHILE @Counter< @total
BEGIN
SET @Code1 =(SELECT floor(RAND()*3 +1))
SET @Code2 =(SELECT floor(RAND()*6 +1))
SET @Code3 =(SELECT floor(RAND()*11 +1))
SET @Code4 =(SELECT floor(RAND()*6 +1))
SET @n= (SELECT COUNT(*) FROM Customer)

SET @CustomerID= (SELECT floor(RAND()*@n +1))

SET @FilingChannel = (SELECT CHOOSE(@Code1,'E Filing','Web Filing','Paper-Based Filing'))

IF @CustomerID >2*@n/3 
	SET @ReturnType= (SELECT CHOOSE(@Code2,'IR101: Goods and services tax','IR4: Income tax return-Companies','IR4J: Annual imputation return','IR6: Income tax return-Estates or Trusts','IR7 : Income tax return-Partnerships','Fringe benefit tax'))
ELSE 
	SET @ReturnType= (SELECT CHOOSE(@Code2,'IR345: PAYE monthly summary','IR348: PAYE monthly schedule','IR3: Individual Tax return','Personal Tax Summary','FS1 : Family Assistance Registration','IR526 : Claim for personal tax rebate'))

SET @ReturnAmount= @Code3* 930

SET @TimeRegister = DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(SECOND, @start, @end)), @start)

INSERT INTO TaxReturn
        ( FilingChannel,ReturnType,TimeRegister,ReturnAmount,CustomerID)
VALUES( @FilingChannel,@ReturnType,@TimeRegister,@ReturnAmount,@CustomerID)

SET @Counter+=1
END

GO

INSERT INTO TaxReturn
        ( FilingChannel,ReturnType,TimeRegister,ReturnAmount,CustomerID)
Exec TaxReturncreation @total= 75001

select * from TaxReturn



