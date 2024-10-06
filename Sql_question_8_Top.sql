--We will be using the following tables (Employees & Departments) to answer this question. In Employees table DepartmentID is the foreign key referencing DepartmentID column in Departments table.
--SQL Query to retrieve department name with maximum employees



--SQL Script to create the required tables
Create Table Departments
(
     DepartmentID int primary key,
     DepartmentName nvarchar(50)
)
GO

Create Table Employees
(
     EmployeeID int primary key,
     EmployeeName nvarchar(50),
     DepartmentID int foreign key references Departments(DepartmentID)
)
GO

Insert into Departments values (1, 'IT')
Insert into Departments values (2, 'HR')
Insert into Departments values (3, 'Payroll')
GO

Insert into Employees values (1, 'Mark', 1)
Insert into Employees values (2, 'John', 1)
Insert into Employees values (3, 'Mike', 1)
Insert into Employees values (4, 'Mary', 2)
Insert into Employees values (5, 'Stacy', 3)
GO

--Scenario asked in the SQL Server Interview
--Based on the above two tables write a SQL Query to get the name of the Department that has got the maximum number of Employees. 
--To answer this question it will be helpful if you the knowledge of JOINS & GROUP BY in SQL Server. We discusses these in Parts 11 & 12 of SQL Server Tutorial video series. 

--SQL query that retrieves the department name with maximum number of employees
SELECT TOP 1 DepartmentName
FROM Employees
JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY DepartmentName
ORDER BY COUNT(*) DESC

drop table Departments
drop table Employees;