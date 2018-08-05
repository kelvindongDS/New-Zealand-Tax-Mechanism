



USE Tax2
GO

DROP TABLE IF EXISTS LiableParent;
CREATE TABLE LiableParent
(
FamilyID INT  PRIMARY KEY,
CashForChildSupport  DECIMAL NOT NULL,
Time  DATETIME NOT NULL,

CONSTRAINT FK_Liable FOREIGN KEY (FamilyID)
    REFERENCES FamilyWithChild(FamilyID),

);

DROP PROCEDURE IF EXISTS LiableParentcreation;
GO

CREATE PROCEDURE LiableParentcreation
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

DECLARE @CashForChildSupport DECIMAL 
DECLARE @Time DATETIME
DECLARE @FamilyID INT

WHILE @Counter< @n/2
BEGIN

SET @Code =(SELECT floor(RAND()*4 +1))
SET @Code1 =(SELECT floor(RAND()*11 +1))

SET @CashForChildSupport= @Code1* 87
SET @Time = DATEADD(DAY, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(DAY, @start, @end)), @start)

SET @FamilyID = (SELECT floor(RAND()*@n1 +1))
While @FamilyID not  in (SELECT FamilyID FROM FamilyWithChild WHERE ChildSupport='Yes') or
	  @FamilyID in ( SELECT FamilyID FROM LiableParent )
BEGIN
SET @FamilyID = (SELECT floor(RAND()*@n1 +1))
END

INSERT INTO LiableParent
        (FamilyID,CashForChildSupport,Time)
VALUES( @FamilyID,@CashForChildSupport,@Time)

SET @Counter+=1
END

GO

INSERT INTO LiableParent
        (FamilyID,CashForChildSupport,Time)
Exec LiableParentcreation

select * from LiableParent


  