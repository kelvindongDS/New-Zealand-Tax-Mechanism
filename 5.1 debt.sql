USE Tax2
GO

DROP TABLE IF EXISTS Debt;
CREATE TABLE Debt
(
DebtID INT IDENTITY(1,1) PRIMARY KEY,
StartTime DATETIME NOT NULL,
DueDate DATETIME NOT NULL,
EndTime DATETIME NOT NULL,
Value DECIMAL NOT NULL,
Age INT NOT NULL,
Overdue VARCHAR(5) NOT NULL,
Type VARCHAR(50) NOT NULL,

CustomerID INT,
CONSTRAINT FK_fromRider FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID),
);

DROP PROCEDURE IF EXISTS Debtcreation;
GO

CREATE PROCEDURE Debtcreation @total INT
AS
DECLARE @Counter INT=1
DECLARE @Code1 INT
DECLARE @Code2 INT
DECLARE @Code3 INT
DECLARE @Code4 INT
DECLARE @n INT
DECLARE @StartTime DATETIME
DECLARE @DueDate DATETIME
DECLARE @EndTime DATETIME
DECLARE @Value decimal
DECLARE @Age INT
DECLARE @Overdue varchar(5) 
DECLARE @Type VARCHAR(50)
DECLARE @CustomerID INT

DECLARE @CurrentDate DATETIME = '2017-12-01 08:00:00'
DECLARE @start DATETIME = '2015-01-01 08:00:00'
DECLARE @end DATETIME = '2017-01-01 08:00:00'

WHILE @Counter< @total
BEGIN
SET @Code1 =(SELECT floor(RAND()*2 +1))
SET @Code2 =(SELECT floor(RAND()*10 +1))
SET @Code3 =(SELECT floor(RAND()*11 +1))
SET @Code4 =(SELECT floor(RAND()*6 +1))
SET @n= (SELECT COUNT(*) FROM Customer)
SET @StartTime = DATEADD(SECOND, ABS(CHECKSUM(NEWID())) % ( 1 + DATEDIFF(SECOND, @start, @end)), @start)

SET @EndTime = (SELECT CHOOSE(@Code1,NULL,
						DATEADD(MONTH, @Code2, @StartTime)))
SET @DueDate= (SELECT DATEADD(MONTH, 12, @StartTime))

SET @Age= (SELECT CASE @Code1
WHEN 1 THEN (SELECT DATEDIFF(DAY,@StartTime, @CurrentDate))
WHEN 2 THEN (SELECT DATEDIFF(DAY,@StartTime, @EndTime))
END)

SET @Value= @Code3*1150
 
SET @Type = (SELECT CHOOSE(@Code4,'Child Support','GST','Students Loan','Income Tax','PAY E','WfF tax credit'))


IF @Code1=1
	IF (SELECT DATEDIFF(DAY,@CurrentDate, @DueDate)) <0
		 SET @Overdue='Yes'
	ELSE SET @Overdue='No'
ELSE SET @Overdue= 'Paid'

SET @CustomerID= (SELECT floor(RAND()*@n +1))


INSERT INTO Debt
        ( StartTime,Endtime,DueDate,Value,Age,Overdue,Type,CustomerID)
VALUES( @StartTime,@EndTime,@DueDate,@Value,@Age,@Overdue,@Type,@CustomerID)

SET @Counter+=1
END

GO

INSERT INTO Debt
        ( StartTime,Endtime,DueDate,Value,Age,Overdue,Type,CustomerID)
Exec Debtcreation @total= 78501

select * from Debt



