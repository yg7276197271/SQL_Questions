--SQL Script to create the required tables
Create Table Departments
(
     DepartmentID int primary key,
     DepartmentName nvarchar(50)
)
GO

Create Table Genders
(
     GenderID int primary key,
     Gender nvarchar(50)
)
GO

Create Table Employees
(
     EmployeeID int primary key,
     EmployeeName nvarchar(50),
     DepartmentID int foreign key references Departments(DepartmentID),
     GenderID int foreign key references Genders(GenderID)
)
GO

Insert into Departments values (1, 'IT')
Insert into Departments values (2, 'HR')
Insert into Departments values (3, 'Payroll')
GO

Insert into Genders values (1, 'Male')
Insert into Genders values (2, 'Female')
GO

Insert into Employees values (1, 'Mark', 1, 1)
Insert into Employees values (2, 'John', 1, 1)
Insert into Employees values (3, 'Mike', 2, 1)
Insert into Employees values (4, 'Mary', 2, 2)
Insert into Employees values (5, 'Stacy', 3, 2)
Insert into Employees values (6, 'Valarie', 3, 2)
GO

--Write a query to join 3 the tables and retrieve EmployeeName, DepartmentName and Gender. The output should be as shown below.
--joining 3 or more tables in sql server

--Query:
SELECT EmployeeName, DepartmentName, Gender
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
JOIN Genders ON Employees.GenderID = Genders.GenderID


--Write a query to show the total number of employees by DEPARTMENT and by GENDER. The output should be as shown below.
--group by 2 columns sql server

--Query:
SELECT DepartmentName, Gender, COUNT(*) as TotalEmployees
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
JOIN Genders ON Employees.GenderID = Genders.GenderID
GROUP BY DepartmentName, Gender
ORDER BY DepartmentName, Gender