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
Insert into Departments values (4, 'Admin')
GO

Insert into Employees values (1, 'Mark', 1)
Insert into Employees values (2, 'John', 1)
Insert into Employees values (3, 'Mike', 1)
Insert into Employees values (4, 'Mary', 2)
Insert into Employees values (5, 'Stacy', 3)
Insert into Employees values (6, 'Pam', NULL)
GO

--INNER JOIN returns only the matching rows between the tables involved in the JOIN. Notice that, Pam employee record which does not have a matching DepartmentId in departments table is eliminated from the result-set.
SELECT EmployeeName, DepartmentName
FROM Employees
INNER JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

--LEFT JOIN returns all rows from left table including non-matching rows. Notice that, Pam employee record which does not have a matching DepartmentId in departments table is also included in the result-set. 
SELECT EmployeeName, DepartmentName
FROM Employees
LEFT JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

--RIGHT JOIN returns all rows from Right table including non-matching rows. 
--There is no employee belongs to Admin department but still it is shown in result ..
SELECT EmployeeName, DepartmentName
FROM Employees
RIGHT JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

--FULL JOIN returns all rows from both tables including mathing & non-matching rows. 
--There is no employee belongs to Admin department but still it is shown in result ..
--Also there PAM employee does not belong to any department still its is result
SELECT EmployeeName, DepartmentName
FROM Employees
FULL JOIN Departments
ON Employees.DepartmentID = Departments.DepartmentID

--Difference between inner join and left outer join

--In general there could be several questions on JOINS in a sql server interview. If we understand the basics of JOINS properly, then answering any JOINS related questions should be a cakewalk.
--What is the difference between INNER JOIN and RIGHT JOIN 


--INNER JOIN returns only the matching rows between the tables involved in the JOIN, where as RIGHT JOIN returns all the rows from the right table including the NON-MATCHING rows.

--What is the difference between INNER JOIN and FULL JOIN 
--FULL JOIN returns all the rows from both the left and right tables including the NON-MATCHING rows.

--What is the Difference between INNER JOIN and JOIN
--There is no difference they are exactly the same. Similarly there is also no difference between 
--LEFT JOIN and LEFT OUTER JOIN
--RIGHT JOIN and RIGHT OUTER JOIN
--FULL JOIN and FULL OUTER JOIN

DROP table Employees;
DROP Table Departments;