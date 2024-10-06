--https://csharp-video-tutorials.blogspot.com/2012/08/joins-in-sql-server-part-12.html
Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go




Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
)
Go


Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron')
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')


Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)

select * from tblEmployee;
select * from tblDepartment;
--LEFT JOIN returns Matching and non-matching rows from left table
--But if we want only non-matching rows then use below query.

----NON MATCHING ROWS FROM LEFT TABLE
select tblEmployee.Name,tblEmployee.Gender,tblEmployee.Salary,tblDepartment.DepartmentName from tblEmployee LEFT JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID
where tblEmployee.DepartmentId IS NULL



----NON MATCHING ROWS FROM RIGHT TABLE
select tblEmployee.Name,tblEmployee.Gender,tblEmployee.Salary,tblDepartment.DepartmentName from tblEmployee RIGHT JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID where
tblEmployee.DepartmentId IS NULL


--NON matching ROWS from LEFT & RIGHT Table

select tblEmployee.Name,tblEmployee.Gender,tblEmployee.Salary,tblDepartment.DepartmentName from tblEmployee FULL JOIN tblDepartment
ON tblEmployee.DepartmentId = tblDepartment.ID where
tblEmployee.DepartmentId IS NULL OR
tblDepartment.ID IS NULL


