--SQL Script to create the Students table

Create table Students
(
     ID int primary key identity,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int
)
Go

Insert into Students values ('Mark', 'Male', 60000)
Insert into Students values ('Steve', 'Male', 45000)
Insert into Students values ('James', 'Male', 70000)
Insert into Students values ('Mike', 'Male', 45000)
Insert into Students values ('Mary', 'Female', 30000)

Insert into Students values ('Valarie', 'Female', 35000)

Insert into Students values ('John', 'Male', 80000)
Go

--Interview question : Write a query to select all student rows whose Name starts with letter 'M' without using the LIKE operator

--The output should be as shown below
--sql search without like wildcard

--If the interviewer has not mentioned not to use LIKE operator, we would have written the query using the LIKE operator as shown below.

SELECT * FROM Students WHERE Name LIKE 'M%'

--We can use any one of the following 3 SQL Server functions, to achieve exactly the same thing
--CHARINDEX
--LEFT
--SUBSTRING

--The following 3 queries retrieve all student rows whose Name starts with letter 'M'. Notice none of the queries are using the LIKE operator.

SELECT * FROM Students WHERE CHARINDEX('M',Name) = 1 --Index of 'M' in Name should be 1
SELECT * FROM Students WHERE LEFT(Name, 1) = 'M' -- LEFT of Name should be '1'
SELECT * FROM Students WHERE SUBSTRING(Name, 1, 1) = 'M' --Staring index is 1 . No of chars is 1