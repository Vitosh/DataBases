-- Problem 1A
CREATE DATABASE Bank
GO

CREATE TABLE Persons
(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
FirstName NVARCHAR(255) NOT NULL,
LastName NVARCHAR(255) NOT NULL,
SSN CHAR(10) NOT NULL
)

CREATE TABLE Accounts
(
ID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PersonID INT FOREIGN KEY REFERENCES Persons(ID) NOT NULL,
Balance MONEY NOT NULL
)

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES('Susan', 'Ivanova', 123451);

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES('Kim', 'Academy', 123452);

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES('Lili', 'Ivanova', 123453);

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES('Krasimirka', 'Navova', 123454)


INSERT INTO Accounts(PersonID,  Balance)
VALUES(1, 10)

INSERT INTO Accounts(PersonID,  Balance)
VALUES(2 , 11)

INSERT INTO Accounts(PersonID,  Balance)
VALUES(3, 100)

INSERT INTO Accounts(PersonID,  Balance)
VALUES(4, 101)



-- Problem 1B
USE Bank
GO

CREATE PROC usp_SelectFullNameOfAllPersons
AS
	SELECT FirstName + ' ' + LastName AS [Full Name] 
	FROM Persons
GO

--Problem 1C
EXEC usp_SelectFullNameOfAllPersons
GO

--Problem 2
CREATE PROC usp_WhoHasMoreMoneyThan @number int
AS
	SELECT *
	FROM Persons p 
	INNER JOIN Accounts a
		ON p.ID = a.PersonID
	WHERE a.Balance > @number
GO

--Problem 2 exec
EXEC usp_WhoHasMoreMoneyThan 100
GO

--Problem 3
CREATE FUNCTION ufn_InterestCalculatorPerMonth(@sum money, @yearly_interest float, @months float) RETURNS money
AS
BEGIN
	RETURN (@sum * (@yearly_interest / 100)) * (@months / 12)
END
GO

--Usage
SELECT 5000 [Money], 7 [Percentage], 24[Months], dbo.ufn_InterestCalculatorPerMonth(5000, 2, 1) [Interest]

--Problem 4
CREATE PROC usp_interestoveraccounts @accountid INT, @interestrate FLOAT
AS
	SELECT id, balance, dbo.ufn_InterestCalculatorPerMonth(balance, @interestrate, 1) AS [interest]
	FROM accounts
	WHERE id = @accountid
GO
--Usage
EXEC usp_interestoveraccounts 1,10

--Problem 5
CREATE PROC usp_WithdrawMoney @accountID int, @money money
AS
	BEGIN TRAN
		UPDATE Accounts
		SET Balance = Balance - @money
		WHERE ID = @accountID
	COMMIT TRAN
GO

EXEC usp_WithdrawMoney 1, 1
GO

CREATE PROC usp_DepositMoney @accountID int, @money money
AS
	BEGIN TRAN
		UPDATE Accounts
		SET Balance = Balance + @money
		WHERE ID = @accountID
	COMMIT TRAN
GO

EXEC usp_DepositMoney 2, 20000


--Problem 6
CREATE TABLE Logs
(
LogID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
AccountID INT FOREIGN KEY REFERENCES Accounts(ID) NOT NULL,
OldSum MONEY NOT NULL,
NewSum MONEY NOT NULL
);
GO

CREATE TRIGGER balance_change
ON Accounts
AFTER  UPDATE
AS
	INSERT INTO Logs(AccountID, OldSum, NewSum)
	SELECT d.ID, d.Balance, i.Balance 
	FROM INSERTED i	
	INNER JOIN DELETED d
		ON d.ID = i.ID
GO

--Problem 7
USE SoftUni
GO

CREATE FUNCTION usp_SearchNames(@letterSet NVARCHAR(MAX))
RETURNS @Names TABLE
(
	Name NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE nameCursor CURSOR READ_ONLY FOR
	SELECT FirstName FROM Employees
	UNION
	SELECT LastName FROM Employees
	UNION
	SELECT Name FROM Towns
	OPEN nameCursor
	DECLARE @currentName NVARCHAR(MAX)
	FETCH NEXT FROM nameCursor INTO @currentName
	WHILE @@fetch_status = 0
	BEGIN
		IF dbo.ufn_MatchesTheLetterSet(@currentName, @letterSet) = 1
		BEGIN
			INSERT INTO @Names(Name) VALUES(@currentName)
		END
		FETCH NEXT FROM nameCursor INTO @currentName
	END
	CLOSE nameCursor
	DEALLOCATE nameCursor
RETURN
END
GO

CREATE FUNCTION ufn_MatchesTheLetterSet(@wordToBeChecked NVARCHAR(100), @lettersCheckSet NVARCHAR(100))
RETURNS BIT
AS
BEGIN
	DECLARE @result BIT,
			@currentLetter NVARCHAR(1)
	SET @result = 1
	WHILE @wordToBeChecked <> ''
	BEGIN
		SET @currentLetter = SUBSTRING(@wordToBeChecked, 1, 1)
		IF CHARINDEX(@currentLetter, @lettersCheckSet) = 0
		BEGIN	
			SET @result = 0
			BREAK
		END
		SET @wordToBeChecked = REPLACE(@currentLetter, @wordToBeChecked, '')
	END
	RETURN @result
END
GO
--usage
SELECT * FROM usp_SearchNames('n')
SELECT * FROM ufn_MatchesTheLetterSet('ako')

--Problem 8
--Impossible is nothing ...
DECLARE @FirstEmployeeTable TABLE
(
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	TownID INT,
	TownName NVARCHAR(50)
)

DECLARE @SecondEmployeeTable TABLE
(
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	TownID INT,
	TownName NVARCHAR(50)
)

INSERT INTO @FirstEmployeeTable(FirstName, LastName, TownID, TownName)
SELECT e.FirstName, e.LastName, t.TownID, t.Name
FROM Employees e 
	INNER JOIN Addresses a 
		ON e.AddressID = a.AddressID
	INNER JOIN Towns t
		ON t.TownID = a.TownID
ORDER BY e.FirstName

INSERT INTO @SecondEmployeeTable(FirstName, LastName, TownID, TownName)
SELECT * FROM @FirstEmployeeTable

DECLARE employeesCursor CURSOR READ_ONLY FOR
SELECT fe.FirstName, fe.LastName, se.FirstName, se.LastName, fe.TownName
FROM @FirstEmployeeTable fe
	INNER JOIN @SecondEmployeeTable se
		ON fe.TownID = se.TownID
ORDER BY fe.FirstName

OPEN employeesCursor
DECLARE @FirstEmployeeFirstName NVARCHAR(50),
		@FirstEmployeeLastName NVARCHAR(50),
		@SecondEmployeeFirstName NVARCHAR(50),
		@SecondEmployeeLastName NVARCHAR(50),
		@TownName NVARCHAR(50)

FETCH NEXT FROM employeesCursor INTO @FirstEmployeeFirstName, @FirstEmployeeLastName,
									 @SecondEmployeeFirstName, @SecondEmployeeLastName, @TownName

WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @TownName + ': ' + @FirstEmployeeFirstName + ' ' + @FirstEmployeeLastName + ' ' +
								 @SecondEmployeeFirstName + ' ' + @SecondEmployeeLastName

		FETCH NEXT FROM employeesCursor INTO @FirstEmployeeFirstName, @FirstEmployeeLastName,
			@SecondEmployeeFirstName, @SecondEmployeeLastName, @TownName
	END
CLOSE employeesCursor
DEALLOCATE employeesCursor












































