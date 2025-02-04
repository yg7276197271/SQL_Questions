--Create Departments and Employees tables using the SQL script below
Create table Departments
(
     ID int not null,
     Name nvarchar(50),
     Location nvarchar(50)
)
GO

Create table Employees
(
     ID int,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int
)
GO

Insert into Departments values (1, 'IT', 'New York')
Insert into Departments values (2, 'HR', 'London')
Insert into Departments values (3, 'Payroll', 'Sydney')
GO

Insert into Employees values (1, 'Mark', 'Male', 60000, 1)
Insert into Employees values (2, 'Steve', 'Male', 45000, 3)
Insert into Employees values (3, 'Ben', 'Male', 70000, 1)
Insert into Employees values (4, 'Philip', 'Male', 45000, 2)

Insert into Employees values (5, 'Mary', 'Female', 30000, 2)

Insert into Employees values (6, 'Valarie', 'Female', 35000, 3)
Insert into Employees values (7, 'John', 'Male', 80000, 1)
GO

--Notice that ID column in Departments table is not the primary Key and DepartmentId column in Employees table is not the foreign key. But we can still join these tables using ID column from Departments table and DepartmentId column from Employees table, as both the columns involved in the join have same data type i.e int.
Select Employees.Name as EmployeeName, Departments.Name as DepartmentName
from Employees
join Departments on Departments.ID = Employees.DepartmentId

--The above query produces the following output
--Can we join two tables without primary foreign key relation

--The obious next question is, if primary foreign key relation is not mandatory for 2 tables to be joined then what is the use of these keys?
--Primary key enforces uniqueness of values over one or more columns. Since ID is not a primary key in Departments table, 2 or more departments may end up having same ID value, which makes it impossible to distinguish between them based on the ID column value.

--Foreign key enforces referential integrity. Without foreign key constraint on DepartmentId column in Employees table, it is possible to insert a row into Employees table with a value for DepartmentId column that does not exist in Departments table.

--The following insert statement, successfully inserts a new Employee into Employees table whose DepartmentId is 100. But we don't have a department with ID = 100 in Departments table. This means this employee row is an orphan row, and the referential integrity is lost as result
Insert into Employees values (8, 'Mary', 'Female', 80000, 100)

--If we have had a foreign key constraint on DepartmentId column in Employees table, the following insert statement would have failed with the following error.
--Msg 547, Level 16, State 0, Line 1
--The INSERT statement conflicted with the FOREIGN KEY constraint. The conflict occurred in database "Sample", table "dbo.Departments", column 'ID'.

--Let's now see how to enforces referential integrity using foreign key constraint.
--Step 1 : Delete the employee record from Employees table where DepartmentId = 100
Delete from Employees where DepartmentId = 100

--Step 2 : Mark ID column as primary key in Departments table
alter table Departments
add primary key (ID)

--Setp 3 : Mark DepartmentId column as foreign key in Employees table
Alter table Employees
add foreign key(DepartmentId)
references Departments(ID)

--Step 4 : Execute the following insert statement. Notice that an error is raised.
Insert into Employees values (8, 'Mary', 'Female', 80000, 100)

--Other SQL Queries used in the demo
Create Table T1
(
     ID int,
     T1Column1 nvarchar(20)
)
GO

Insert into T1 values (1, 'T1 Value 1')
Insert into T1 values (2, 'T1 Value 2')
GO

Create Table T2
(
     ID decimal,
     T2Column1 nvarchar(20)
)
GO

Insert into T2 values (1, 'T2 Value 1')
Insert into T2 values (2, 'T2 Value 2')
GO

Select T1.T1Column1, T2.T2Column1
from T1
join T2 on T1.ID = T2.ID

Alter Table T2 Alter Column ID nvarchar(3)

Insert into T2 values('XX', 'T2 Value 3')

--Values of int & decimal data type are convertible from one formatto other..So it will not give any error
--also int and nvarchar values if they are numbers then convertiable
--it will error only when we INSERT XX in nvarchar column as it can not be converted to number  