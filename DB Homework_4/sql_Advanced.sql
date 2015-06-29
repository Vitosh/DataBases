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


