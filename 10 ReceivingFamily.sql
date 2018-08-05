




USE Tax2
GO

DROP TABLE IF EXISTS ReceiveingFamily;
CREATE TABLE ReceiveingFamily
(
FamilyID INT  PRIMARY KEY,
CashReceiveFromChildSupport  DECIMAL NOT NULL,
Time  DATETIME NOT NULL,

CONSTRAINT FK_ReceiveFam FOREIGN KEY (FamilyID)
    REFERENCES FamilyWithChild(FamilyID),

);

DROP PROCEDURE IF EXISTS ReceiveingFamilycreation;
GO

CREATE PROCEDURE ReceiveingFamilycreation
AS
DECLARE @n INT
DECLARE @n1 INT
SET @n= (SELECT COUNT(*) FROM FamilyWithChild )
SET @n1= (SELECT COUNT(*) FROM family1 )

DECLARE @Counter INT= 1
DECLARE @Counter1 INT= 1
DECLARE @Code INT
DECLARE @Code1 INT

DECLARE @start DATETIME = '2015-01-01 08:00:00'
DECLARE @end DATETIME = '2017-01-01 08:00:00'


DECLARE @CashReceiveFromChildSupport DECIMAL 
DECLARE @Time DATETIME
DECLARE @FamilyID INT

WHILE @Counter< @n/8
BEGIN

SET @Code =(SELECT floor(RAND()*4 +1))
SET @Code1 =(SELECT floor(RAND()*11 +1))

SET @CashReceiveFromChildSupport= @Code1* 67
SET @Time = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY, @start, @end)), @start)

SET @FamilyID = (SELECT floor(RAND()*@n1 +1))
While @FamilyID not  in (SELECT FamilyID FROM FamilyWithChild WHERE ChildSupport='Yes') or
	  @FamilyID in ( SELECT FamilyID FROM ReceiveingFamily )

BEGIN
SET @FamilyID = (SELECT floor(RAND()*@n1 +1))
END

INSERT INTO ReceiveingFamily
        (FamilyID,CashReceiveFromChildSupport,Time)
VALUES( @FamilyID,@CashReceiveFromChildSupport,@Time)

SET @Counter+=1
END

GO

INSERT INTO ReceiveingFamily
        (FamilyID,CashReceiveFromChildSupport,Time)
Exec ReceiveingFamilycreation

select * from ReceiveingFamily


  