--Question 1: Can you list different types of JOINS available in SQL Server
--Answer: Inner Join, Left Join, Right Join, Full Join and Cross Join

--Question 2: Can you tell me the purpose of Right Join?
--Answer: Right Join returns all rows from the Right Table irrespective of whether a match exists in the left table or not.

--Question 3: Can you give me an example?
--Answer: Consider the following Departments and Employees tables.
--Real time example for right join

--In this case we use RIGHT JOIN To retrieve all Department and Employee names, irrespective of whether a Department has Employees or not.
--real time example for right join in sql server

Select DepartmentName, EmployeeName
From Employees
Right Join Departments
On Employees.DepartmentID = Departments.DepartmentID


--Question 4: I accept you have understood the purpose of Right Join. Based on the above 2 tables, can you give me any other business case for using Right Join.
--At this point the candidate being interviewed, had no other answer and he simply told the interviewer he can't think of anything else. The good news is that, inspite of not answering the last question, the candidate got this Job. 

--The candidate then emailed me and asked, what do you think that interviewer might be looking for here?
--Here is what I think the interviewer is looking for. I may be wrong. If you can think of anything else, please feel free to leave a comment so it could help someone else.

--Another business case for using RIGHT JOIN on the above 2 tables is to retrieve all the Department Names and the total number of Employees with in each department.
--business case for right join
-- We have to use Count(Employees.DepartmentID) in below query . If we use count(*) it will give wrong output

--COUNT(*) will count all the rows in the table, including NULL values. On the other hand, 
--COUNT(column name) will count all the rows in the specified column while excluding NULL values

--https://learnsql.com/blog/difference-between-count-distinct/#:~:text=(column%20name)%20.-,Is%20there%20any%20difference%3F,column%20while%20excluding%20NULL%20values.

--SQL Query with Right Join
Select DepartmentName, Count(Employees.DepartmentID) as TotalEmployees
From Employees
Right Join Departments
ON Departments.DepartmentID = Employees.DepartmentID
Group By DepartmentName
Order By TotalEmployees

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
Insert into Departments values (4, 'Admin')
GO

Insert into Employees values (1, 'Mark', 1)
Insert into Employees values (2, 'John', 1)
Insert into Employees values (3, 'Mike', 1)
Insert into Employees values (4, 'Mary', 2)
Insert into Employees values (5, 'Stacy', 2)
GO