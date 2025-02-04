--Common table expression (CTE) is introduced in SQL server 2005.
--A CTE is a temporary result set, that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement, 
--that immediately follows the CTE.

--Let's create the required Employee and Department tables, that we will be using for this demo.

--SQL Script to create tblEmployee table:
CREATE TABLE tblEmployee
(
  Id int Primary Key,
  Name nvarchar(30),
  Gender nvarchar(10),
  DepartmentId int
)

--SQL Script to create tblDepartment table 
CREATE TABLE tblDepartment
(
 DeptId int Primary Key,
 DeptName nvarchar(20)
)

--Insert data into tblDepartment table
Insert into tblDepartment values (1,'IT')
Insert into tblDepartment values (2,'Payroll')
Insert into tblDepartment values (3,'HR')
Insert into tblDepartment values (4,'Admin')

--Insert data into tblEmployee table
Insert into tblEmployee values (1,'John', 'Male', 3)
Insert into tblEmployee values (2,'Mike', 'Male', 2)


Insert into tblEmployee values (3,'Pam', 'Female', 1)


Insert into tblEmployee values (4,'Todd', 'Male', 4)
Insert into tblEmployee values (5,'Sara', 'Female', 1)
Insert into tblEmployee values (6,'Ben', 'Male', 3)

--Write a query using CTE, to display the total number of Employees by Department Name. The output should be as shown below.


--Before we write the query, let's look at the syntax for creating a CTE.
WITH cte_name (Column1, Column2, ..)
AS
( CTE_query )

--SQL query using CTE:
With EmployeeCount(DepartmentId, TotalEmployees)
as
(
 Select DepartmentId, COUNT(*) as TotalEmployees
 from tblEmployee
 group by DepartmentId
)

Select DeptName, TotalEmployees
from tblDepartment
join EmployeeCount
on tblDepartment.DeptId = EmployeeCount.DepartmentId
order by TotalEmployees
--Names of below columns shouldmatch : DepartmentId in () and DepartmentId in select query .

--We define a CTE, using WITH keyword, followed by the name of the CTE.
--In our example, EmployeeCount is the name of the CTE. 
--Within parentheses, we specify the columns that make up the CTE. 
--DepartmentId and TotalEmployees are the columns of EmployeeCount CTE. 
--These 2 columns map to the columns returned by the SELECT CTE query.
--The CTE column names and CTE query column names can be different.
--Infact, CTE column names are optional.
--However, if you do specify, the number of CTE columns and the CTE SELECT query columns should be same. 
--Otherwise you will get an error stating - 
--'EmployeeCount has fewer columns than were specified in the column list'.
--The column list, is followed by the as keyword, following which we have the CTE query within a pair of parentheses.

--EmployeeCount CTE is being joined with tblDepartment table, in the SELECT query, that immediately follows the CTE.
--Remember, a CTE can only be referenced by a SELECT, INSERT, UPDATE, or DELETE statement, that immediately follows the CTE. 
--If you try to do something else in between, we get an error stating - 'Common table expression defined but not used'. 
--The following SQL, raise an error.

With EmployeeCount(DepartmentId, TotalEmployees)
as
(
 Select DepartmentId, COUNT(*) as TotalEmployees
 from tblEmployee
 group by DepartmentId
)

Select 'Hello'

Select DeptName, TotalEmployees
from tblDepartment
join EmployeeCount
on tblDepartment.DeptId = EmployeeCount.DepartmentId
order by TotalEmployees

--It is also, possible to create multiple CTE's using a single WITH clause.
With EmployeesCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
 Select DeptName, COUNT(Id) as TotalEmployees
 from tblEmployee
 join tblDepartment 
 on tblEmployee.DepartmentId = tblDepartment.DeptId
 where DeptName IN ('Payroll','IT')
 group by DeptName
),
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
 Select DeptName, COUNT(Id) as TotalEmployees
 from tblEmployee
 join tblDepartment 
 on tblEmployee.DepartmentId = tblDepartment.DeptId
 group by DeptName 
)
Select * from EmployeesCountBy_HR_Admin_Dept 
UNION
Select * from EmployeesCountBy_Payroll_IT_Dept