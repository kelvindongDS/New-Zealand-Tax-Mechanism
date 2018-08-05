USE Tax2
GO

DROP TABLE IF EXISTS Individual;
CREATE TABLE Individual
(
CustomerID INT PRIMARY KEY,
TaxCode VARCHAR(10) NOT NULL,
Occupation VARCHAR(20),
Gender VARCHAR(5)

CONSTRAINT FK_Individual FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
);

DROP PROCEDURE IF EXISTS individualcreation;
GO

CREATE PROCEDURE individualcreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code1 INT
DECLARE @Code2 INT
DECLARE @CustomerID INT
DECLARE @TaxCode VARCHAR(10)
DECLARE @Occupation VARCHAR(20)
DECLARE @Gender VARCHAR(5)

WHILE @Counter< @total*2/3+1
BEGIN
SET @Code1 =(SELECT floor(RAND()*4 +1))
SET @Code2 =(SELECT floor(RAND()*10 +1))

SET @CustomerID= @Counter

SET @TaxCode= (SELECT CASE @Code1
WHEN 1 THEN 'M'
WHEN 2 THEN 'M SL'
WHEN 3 THEN 'ME'
WHEN 4 THEN 'ME SL'
END)

SET @Occupation = (SELECT CASE @Code2
WHEN 1 THEN 'IT'
WHEN 2 THEN 'Accountant'
WHEN 3 THEN 'Agricultural Engineer'
WHEN 4 THEN 'student'
WHEN 5 THEN 'Ambulance Officer'
WHEN 6 THEN 'Chef'
WHEN 7 THEN 'Chemical Engineer'
WHEN 8 THEN 'Cleaners'
WHEN 9 THEN 'Courier'
WHEN 10 THEN 'Officer'
END)

SET @Gender= (SELECT CASE @Counter%2
WHEN 1 THEN 'Males'
WHEN 0 THEN 'Females'
END)

INSERT INTO Individual
        ( CustomerID,TaxCode,Occupation,Gender )
VALUES( @CustomerID,@TaxCode,@Occupation,@Gender)

SET @Counter+=1
END
GO

INSERT INTO Individual
        ( CustomerID,TaxCode,Occupation )
Exec individualcreation @total= 90001

select * from Individual;

 