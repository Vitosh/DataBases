Problem 1
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary =
	(SELECT MIN(Salary) FROM Employees)
	
Problem 2
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary <=
	(SELECT MIN(Salary) *1.1 FROM Employees)
ORDER BY FirstName DESC

Problem 3
SELECT e.FirstName, e.LastName, e.Salary, d.Name
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = d.DepartmentID
WHERE Salary =
	(SELECT MIN(Salary) FROM Employees)
ORDER BY d.DepartmentID

Problem 4
SELECT TOP(1) e.FirstName, e.LastName, e.Salary, d.Name
FROM Employees e
INNER JOIN Departments d ON d.DepartmentID = d.DepartmentID
WHERE e.Salary >
		(SELECT AVG(Salary) FROM Employees
		WHERE Employees.DepartmentID = 1)
		AND d.DepartmentID = 1
ORDER BY Salary

Problem 5
SELECT AVG(e.Salary) [Average Salary for Sales Department] FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

Problem 6
SELECT COUNT(*) [Number of employees] FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

Problem 7
SELECT COUNT(e.EmployeeID) [Employees with manager] FROM Employees e
WHERE e.ManagerID IS NOT NULL

Problem 8
SELECT COUNT(e.EmployeeID) [Employees without manager] FROM Employees e
WHERE e.ManagerID IS NULL

Problem 9
SELECT d.Name [Department], AVG(e.Salary) [Average Gehalt]
FROM Departments d
INNER JOIN Employees e 
		ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name
ORDER BY d.Name

Problem 10
SELECT t.Name, d.Name,COUNT(*) [Employees count] FROM Towns t
INNER JOIN Addresses a ON a.TownID = t.TownID
INNER JOIN Employees e ON e.AddressID = a.AddressID
INNER JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY d.Name, t.Name
ORDER BY d.Name

Problem 11
SELECT e.FirstName, e.LastName, m.[Employees count]
FROM Employees e
	INNER JOIN 
		(SELECT ManagerID, COUNT(ManagerID) AS [Employees count]
		FROM Employees
		GROUP BY ManagerID) m
	ON m.ManagerID = e.EmployeeID
WHERE m.[Employees count] = 5

Problem 11
SELECT m.FirstName, m.LastName, COUNT(e.ManagerID) AS [Employees count]
FROM Employees e 
	JOIN Employees m
		ON m.EmployeeID = e.ManagerID
GROUP BY m.ManagerID, m.FirstName, m.LastName
HAVING COUNT(e.ManagerID) = 5


Problem 12
Select e1.FirstName +' '+ e1.LastName [Employee], ISNULL(e2.FirstName +' '+ e2.LastName,'No manager') [Manager]FROM Employees e1
LEFT JOIN Employees e2 ON e2.EmployeeID = e1.ManagerID

Problem 13
Select FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

Problem 14
SELECT CONVERT(VARCHAR(23), GETDATE(), 121) AS [DateTime]

Problem 15
CREATE TABLE Users 
(
  [UserID] int IDENTITY(1,1),
  [Username] nvarchar(100) NOT NULL,
  [Password] nvarchar(100) NOT NULL,
  [FullName] nvarchar(100) NOT NULL,
  [LastLoginTime] smalldatetime DEFAULT GETDATE(),
  CONSTRAINT PK_UserID PRIMARY KEY(UserID),
  CONSTRAINT chk_Password CHECK (LEN(Password) > 5)
)
GO

Problem 16
SELECT * FROM Users
WHERE DATEDIFF(day, LastLoginTime, GETDATE()) <1

Problem 17
CREATE TABLE Groups 
(
  [Id] int IDENTITY(1,1) NOT NULL,
  [Name] nvarchar(100) NOT NULL,
  CONSTRAINT PK_Id PRIMARY KEY(Id),
  CONSTRAINT UK_Name UNIQUE(Name)
)

Problem 18
 ALTER TABLE Users 
 ADD GroupId int FOREIGN KEY REFERENCES Groups(Id)

 Problem 19
 INSERT INTO Groups 
VALUES ('A')
INSERT INTO Groups
VALUES ('B')
INSERT INTO Groups
VALUES ('C')
INSERT INTO Groups
VALUES ('D')
INSERT INTO Users (Username, Password, FullName, LastLoginTime, GroupId)
VALUES ('Ivan', '123456', 'pepi pepov', GETDATE(), 1)
INSERT INTO Users (Username, Password, FullName, LastLoginTime, GroupId)
VALUES ('Stoyan', '123456', 'Stoyan Stoyanov',GETDATE(), 2)
INSERT INTO Users (Username, Password, FullName, LastLoginTime, GroupId)
VALUES ('Parvan', '123456', 'Parvan', '2015-06-25', 3)

Problem 20
UPDATE Groups 
SET Name = 'Your aunt''s group'
WHERE Name = 'A'

UPDATE Users 
SET Password = 'NeverUseAnEasyPassword'
WHERE Password = '123456'

Problem 21
Delete Users
WHERE UserID = 5

Delete Groups
WHERE Id = 4

Problem 22
INSERT INTO Users
SELECT LOWER(LEFT(FirstName, (LEN(FirstName)/2))) + LOWER(LEFT(LastName, (LEN(LastName)/2))) AS UserName,
	 LOWER(LEFT(FirstName, 1) + LEFT(LastName, 1)+ 'ChangeYourPasswordPlease') AS Password,
	 FirstName + ' ' + LastName AS FullName,
	 GETDATE() AS LastLoginTime,
	 ABS(Checksum(NewID()) % 2) + 1 AS GroupId
FROM Employees

Problem 23
UPDATE Users SET Password = NULL
WHERE LastLoginTime <= '2010-03-10'

Problem 24
DELETE FROM Users
WHERE Password IS NULL

Problem 25
SELECT d.Name, e.JobTitle, AVG(Salary) AS [Average Employee Salary]
FROM Employees e
	INNER JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle
ORDER BY [Average Employee Salary] DESC

Problem 26
SELECT e.FirstName, e.LastName, d.Name[Department Name], e.Salary 
FROM Employees e
INNER JOIN Departments d
	ON e.DepartmentID = d.DepartmentID
WHERE Salary =
	(SELECT MIN(Salary) FROM Employees
	where DepartmentID = e.DepartmentID)
ORDER BY d.Name

Problem 27
SELECT TOP(1) * 
FROM (SELECT t.Name, COUNT(*) AS [EmployeeCount] 
	FROM Employees e
		INNER JOIN Addresses a ON a.AddressID = e.AddressID
		INNER JOIN Towns t ON t.TownID = a.TownID
	GROUP BY t.Name) ec
ORDER BY ec.EmployeeCount DESC

Problem 28
SELECT mt.Town, COUNT(*) AS [Number of managers]
FROM 
(SELECT DISTINCT e.EmployeeID, e.FirstName, e.LastName, t.Name AS Town
FROM Employees e 
	JOIN Employees m
		ON m.ManagerID = e.EmployeeID
	JOIN Addresses a
		ON  a.AddressID = e.AddressID
	JOIN Towns t
		ON a.TownID = t.TownID) AS mt
GROUP BY mt.Town
ORDER BY mt.Town

Problem 29
CREATE TABLE WorkHours
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
	TaskDate DATETIME NULL DEFAULT GETDATE(),
	Task NVARCHAR(150) NOT NULL,
	Hours SMALLINT NOT NULL,
	Comments NVARCHAR(MAX) NULL
)
GO

Problem 30
INSERT INTO WorkHours (EmployeeID, Task, Hours, Comments)
VALUES(10, 'Have fun dude', 4, 'Fun is important!');

INSERT INTO WorkHours (EmployeeID, Task, Hours, Comments)
VALUES(11, 'Have More fun', 4, 'Take a break');

UPDATE WorkHours
SET EmployeeID = 5
WHERE EmployeeID = 10

DELETE FROM WorkHours
WHERE Id = 1

INSERT INTO WorkHours (EmployeeID, Task, Hours, Comments)
VALUES(10, 'No idea what to write here', 4, 'Look at some cat''s pictures');


Problem 31
CREATE TABLE WorkHoursLogs
(
	Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ChangeDate DATETIME DEFAULT GETDATE() NOT NULL,
	Command NCHAR(6) NOT NULL,
	OldEmployeeId INT NULL,
	NewEmployeeId INT NULL,
	OldTaskDate DATETIME NULL,
	NewTaskDate DATETIME NULL,
	OldTask NVARCHAR(150) NULL,
	NewTask NVARCHAR(150) NULL,
	OldHours SMALLINT NULL,
	NewHours SMALLINT NULL,
	OldComments NVARCHAR(MAX) NULL,
	NewComments NVARCHAR(MAX) NULL
)
GO

CREATE TRIGGER workhours_change
ON WorkHours
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @operation CHAR(6)
		SET @operation = CASE
				WHEN EXISTS(SELECT * FROM inserted) AND EXISTS(SELECT * FROM deleted)
					THEN 'Update'
				WHEN EXISTS(SELECT * FROM inserted)
					THEN 'Insert'
				WHEN EXISTS(SELECT * FROM deleted)
					THEN 'Delete'
				ELSE NULL
		END
	IF @operation = 'Delete'
			INSERT INTO WorkHoursLogs (Command, ChangeDate, OldTaskDate, OldTask, OldHours, OldComments)
			SELECT @operation, GETDATE(), d.TaskDate, d.Task, d.Hours, d.Comments
			FROM deleted d
	IF @operation = 'Insert'
			INSERT INTO WorkHoursLogs (Command, ChangeDate, NewTaskDate, NewTask, NewHours, NewComments)
			SELECT @operation, GETDATE(), i.TaskDate, i.Task, i.Hours, i.Comments
			FROM inserted i
	IF @operation = 'Update'
			INSERT INTO WorkHoursLogs (Command, ChangeDate, OldTaskDate, OldTask, OldHours, OldComments,
						NewTaskDate, NewTask, NewHours, NewComments)
			SELECT @operation, GETDATE(), d.TaskDate, d.Task, d.Hours, d.Comments,
										  i.TaskDate, i.Task, i.Hours, i.Comments
			FROM deleted d, inserted i
END
GO

UPDATE WorkHours
SET TaskDate = DATEADD(MONTH, 3, GETDATE()) 
WHERE Id = 2

UPDATE WorkHours
SET Comments = 'F*CK YEAH. LET''S GO'
WHERE Id = 3

INSERT INTO WorkHours (EmployeeID, Task, Hours, Comments)
VALUES (21, 'WORK HARD', 24 , 'Work hard - play hard')


Problem 32
BEGIN TRAN
ALTER TABLE Departments
DROP CONSTRAINT FK_Departments_Employees

DELETE Employees
WHERE DepartmentID =
		(SELECT DepartmentID 
		FROM Departments 
		WHERE Name = 'Sales')

SELECT * FROM Employees e
		 INNER JOIN Departments d
				ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ROLLBACK TRAN


Problem 33
BEGIN TRAN
DROP TABLE EmployeesProjects
ROLLBACK TRAN

SELECT * FROM EmployeesProjects

-- Problem 34.	Find how to use temporary tables in SQL Server.
SELECT * INTO ##TempTableProjects
FROM EmployeesProjects
 
 DROP TABLE EmployeesProjects
 
 CREATE TABLE EmployeesProjects
  (
   EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
   ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID) NOT NULL,
  )
 
 INSERT INTO EmployeesProjects
 SELECT * FROM  ##TempTableProjects



































































































