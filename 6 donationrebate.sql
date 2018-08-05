
USE Tax2
GO

DROP TABLE IF EXISTS DonationRebate;
CREATE TABLE DonationRebate
(
DonationRebateID INT IDENTITY(1,1) PRIMARY KEY,
DoRebateAmount  DECIMAL NOT NULL,
RebateTime DATETIME NOT NULL,

CustomerID INT,
CONSTRAINT FK_DonaRebate FOREIGN KEY (CustomerID)
    REFERENCES Individual(CustomerID),
);

DROP PROCEDURE IF EXISTS DonationRebatecreation;
GO

CREATE PROCEDURE DonationRebatecreation @total INT
AS
DECLARE @n INT
SET @n= (SELECT COUNT(*) FROM Customer)

DECLARE @Counter INT= 1
DECLARE @Code INT

DECLARE @RebateTime DATETIME
DECLARE @DoRebateAmount DECIMAL 
DECLARE @CustomerID INT

DECLARE @start DATETIME = '2015-01-01 08:00:00'
DECLARE @end DATETIME = '2017-01-01 08:00:00'

WHILE @Counter< @total
BEGIN

SET @Code =(SELECT floor(RAND()*11 +1))
SET @CustomerID= (SELECT floor(RAND()*@n*2/3 +1))

SET @DoRebateAmount= @Code* 311

SET @RebateTime = DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(SECOND, @start, @end)), @start)

INSERT INTO DonationRebate
        ( DoRebateAmount,RebateTime,CustomerID)
VALUES( @DoRebateAmount,@RebateTime,@CustomerID)

SET @Counter+=1
END
GO

INSERT INTO DonationRebate
        ( DoRebateAmount,RebateTime,CustomerID)
Exec DonationRebatecreation @total= 49001

select * from DonationRebate



