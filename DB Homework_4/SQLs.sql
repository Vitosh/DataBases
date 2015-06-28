Problem 4:
SELECT * FROM Departments

Problem 5:
SELECT Name as "Department" FROM Departments

Problem 6:
SELECT FirstName +' '+ LastName as Name, Salary FROM Employees

Problem 7:
SELECT FirstName +' '+ LastName as "Full Name" FROM Employees

Problem 8:
SELECT Lower(FirstName +'.'+ LastName +'@softuni.bg') as Email FROM Employees

Problem 9:
SELECT DISTINCT Salary FROM Employees

Problem 10:
SELECT * FROM Employees
WHERE Employees.JobTitle = 'Sales Representative'

Problem 11:
SELECT FirstName FROM Employees
WHERE FirstName LIKE 'SA%'

Problem 12:
SELECT LastName FROM Employees
WHERE LastName LIKE '%ei%'

Problem 13:
SELECT LastName, Salary FROM Employees
WHERE Salary <= 30000 AND Salary >= 20000

Problem 14:
SELECT (FirstName +' ' +LastName) AS NAME, Salary FROM Employees
WHERE 
	Salary = 25000
	OR Salary = 14000
	OR Salary = 23600
	OR Salary = 12500

Problem 15:
SELECT (FirstName +' ' +LastName) AS "No Boss For Me", Salary FROM Employees
WHERE 
	ManagerID IS NULL

Problem 16:
SELECT (FirstName +' ' +LastName) AS "Name", Salary FROM Employees
WHERE 
	Salary> 50000
ORDER BY SALARY ASC

Problem 17:
SELECT TOP(5) (FirstName +' ' +LastName) AS "Name", Salary FROM Employees
ORDER BY SALARY DESC

Problem 18:
SELECT FirstName +' '+LastName as Name, Addresses.AddressText as "Emplyee Address" FROM Employees e
INNER JOIN Addresses
ON Addresses.AddressID = e.AddressID

Problem 19:
SELECT FirstName +' '+LastName as Name, a.AddressText as "Emplyee Address" 
FROM Employees e, Addresses a
WHERE a.AddressID = e.AddressID

Problem 20:
SELECT (e2.FirstName +' '+ e2.LastName) AS Employee,  (e1.FirstName +' '+ e1.LastName) AS Boss
FROM Employees AS e1
INNER JOIN Employees e2 ON e1.EmployeeID = e2.ManagerID

Problem 20:
SELECT (e2.FirstName +' '+ e2.LastName) AS Employee,  (e1.FirstName +' '+ e1.LastName) AS Boss
FROM Employees AS e1
RIGHT JOIN Employees e2 ON e1.EmployeeID = e2.ManagerID

Problem 21:
SELECT (e2.FirstName +' '+ e2.LastName) AS Employee,  (e1.FirstName +' '+ e1.LastName) AS Boss, a.AddressText as Address
FROM Employees AS e1
RIGHT JOIN Employees e2 ON e1.EmployeeID = e2.ManagerID
JOIN Addresses a ON e2.AddressID = a.AddressID

Problem 22:
SELECT d.Name FROM Departments d 
UNION 
SELECT t.Name FROM Towns t

Problem 23:
SELECT (e2.FirstName +' '+ e2.LastName) AS Employee,  (e1.FirstName +' '+ e1.LastName) AS Boss
FROM Employees AS e1
RIGHT OUTER JOIN Employees e2 ON e1.EmployeeID = e2.ManagerID

SELECT  (e1.FirstName +' '+ e1.LastName) AS Boss, (e2.FirstName +' '+ e2.LastName) AS Employee
FROM Employees AS e1
LEFT OUTER JOIN Employees e2 ON  e1.EmployeeID = e2.ManagerID  

Problem 24:
SELECT  (e.FirstName +' '+ e.LastName) AS WiseAndNiceEmployees, d.Name as Department, e.HireDate From Employees e
LEFT JOIN Departments d ON e.DepartmentId = d.DepartmentID
WHERE e.HireDate < '2005-01-01' AND e.HireDate > '1995-01-01'


