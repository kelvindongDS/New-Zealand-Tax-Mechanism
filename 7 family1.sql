
USE Tax2
GO
DROP TABLE IF EXISTS ReceiveingFamily
DROP TABLE IF EXISTS LiableParent
DROP TABLE IF EXISTS FamilyWithChild;
DROP TABLE IF EXISTS Family1;
CREATE TABLE Family1
(
FamilyID INT IDENTITY(1,1) PRIMARY KEY,
NumberOfChild INT NOT NULL,
Time DATETIME NOT NULL,

CustomerID1 int,CustomerID2 int

CONSTRAINT FK_1Indi1 FOREIGN KEY (CustomerID1)
    REFERENCES Individual(CustomerID),

CONSTRAINT FK_1Indi2 FOREIGN KEY (CustomerID2)
    REFERENCES Individual(CustomerID),
);


DROP PROCEDURE IF EXISTS Familycreation1;
GO

CREATE PROCEDURE Familycreation1 @total INT
AS
DECLARE @n INT
SET @n= (SELECT COUNT(*) FROM Customer)

DECLARE @Counter INT= 1
DECLARE @Counter1 INT= 1
DECLARE @Code INT
DECLARE @Code1 INT
DECLARE @Code2 INT

DECLARE @Time DATETIME
DECLARE @NumberOfChild INT
DECLARE @CustomerID1 INT
DECLARE @CustomerID2 INT

DECLARE @start DATE = '2010-01-01'
DECLARE @end DATE = '2015-01-01'

WHILE @Counter< @total
BEGIN

SET @Code =(SELECT floor(RAND()*4 +1))
SET @Code1 =(SELECT floor(RAND()*11 +1))
SET @Code2 =(SELECT floor(RAND()*2 +1))

IF @Counter1 < @n*2/3
	SET @Counter1+=2
ELSE 
	SET @Counter1=1

SET @NumberOfChild = (SELECT floor(RAND()*4 +1))-1

SET @CustomerID1= @Counter1

SET @CustomerID2= @CustomerID1+1

SET @Time = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY, @start, @end)), @start)

INSERT INTO Family1
        (NumberOfChild,Time,CustomerID1,CustomerID2)
VALUES( @NumberOfChild,@Time,@CustomerID1,@CustomerID2)

SET @Counter+=1
END
GO

INSERT INTO Family1
        (NumberOfChild,Time,CustomerID1,CustomerID2)
Exec Familycreation1 @total= 26001

select * from Family1 where NumberOfChild=0


  
