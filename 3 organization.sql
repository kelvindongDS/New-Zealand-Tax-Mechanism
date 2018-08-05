USE Tax2
GO

DROP TABLE IF EXISTS Organization;
CREATE TABLE Organization
(
CustomerID INT PRIMARY KEY,
BusinessSegment VARCHAR(50) NOT NULL,

CONSTRAINT FK_Organization FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
);

DROP PROCEDURE IF EXISTS organizationcreation;
GO

CREATE PROCEDURE organizationcreation @total INT
AS
DECLARE @Counter INT= @total*2/3+1
DECLARE @Code1 INT
DECLARE @CustomerID INT
DECLARE @BusinessSegment varchar(50)

WHILE @Counter< @total
BEGIN
SET @Code1 =(SELECT floor(RAND()*10 +1))

SET @CustomerID= @Counter

SET @BusinessSegment= (SELECT CASE @Code1
WHEN 1 THEN 'Banking'
WHEN 2 THEN 'Pharmaceutical Products'
WHEN 3 THEN 'Computers'
WHEN 4 THEN 'Healthcare'
WHEN 5 THEN 'Shipping Containers'
WHEN 6 THEN 'Tax Agent'
WHEN 7 THEN 'Real Estate'
WHEN 8 THEN 'Insurance'
WHEN 9 THEN 'Entertainment'
WHEN 10 THEN 'Retail'
END)

INSERT INTO Organization
        ( CustomerID,BusinessSegment )
VALUES( @CustomerID,@BusinessSegment)

SET @Counter+=1
END
GO

INSERT INTO Organization
        ( CustomerID,BusinessSegment )
Exec organizationcreation @total= 90001

select * from Organization 

select * from Debt