


USE Tax2
GO

DROP TABLE IF EXISTS ReceiveingFamily
DROP TABLE IF EXISTS LiableParent
DROP TABLE IF EXISTS FamilyWithChild;
CREATE TABLE FamilyWithChild
(
FamilyID INT  PRIMARY KEY,
WorkingForFamilyTaxEntitlement  decimal NOT NULL,
WorkingForFamilyTaxType  VARCHAR(50) NOT NULL,
ChildSupport VARCHAR(5) NOT NULL

CONSTRAINT FK_Family FOREIGN KEY (FamilyID)
    REFERENCES Family1(FamilyID),

);

DROP PROCEDURE IF EXISTS FamilyChildcreation;
GO

CREATE PROCEDURE FamilyChildcreation 
AS
DECLARE @n INT
DECLARE @n1 INT
SET @n= (SELECT COUNT(*) FROM Family1)
SET @n1= (SELECT COUNT(*) FROM Family1 WHERE NumberOfChild !=0)

DECLARE @Counter INT= 1
DECLARE @Counter1 INT= 1
DECLARE @Code INT
DECLARE @Code1 INT
DECLARE @Code2 INT

DECLARE @ChildSupport VARCHAR(5)
DECLARE @WorkingForFamilyTaxEntitlement DECIMAL 
DECLARE @WorkingForFamilyTaxType VARCHAR(50)
DECLARE @FamilyID INT

WHILE @Counter< @n1 +1
BEGIN

SET @Code =(SELECT floor(RAND()*4 +1))
SET @Code1 =(SELECT floor(RAND()*13 +1))
SET @Code2 =(SELECT floor(RAND()*2 +1))

SET @WorkingForFamilyTaxType = (SELECT CHOOSE(@Code,'FTC-Family Tax Credit','IWTC In-work Tax Credit','PTC-Parental Tax Credit','MFTC-Minimum Family Tax Credit'))
SET @WorkingForFamilyTaxEntitlement= @Code1*135

SET @FamilyID = (SELECT floor(RAND()*@n +1))
While @FamilyID not  in (SELECT FamilyID FROM Family1 WHERE NumberOfChild !=0) or
	  @FamilyID in ( SELECT FamilyID FROM FamilyWithChild )
BEGIN
SET @FamilyID = (SELECT floor(RAND()*@n +1))
END

SET @ChildSupport = (SELECT CHOOSE(@Code2,'Yes','No'))

INSERT INTO FamilyWithChild
        (FamilyID,WorkingForFamilyTaxEntitlement,WorkingForFamilyTaxType,ChildSupport)
VALUES( @FamilyID,@WorkingForFamilyTaxEntitlement,@WorkingForFamilyTaxType,@ChildSupport)

SET @Counter+=1
END
GO

INSERT INTO FamilyWithChild
        (FamilyID,WorkingForFamilyTaxEntitlement,WorkingForFamilyTaxType)
Exec FamilyChildcreation

select * from FamilyWithChild



  