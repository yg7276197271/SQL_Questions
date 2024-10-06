--Sql server select where in list

--sql server where id in list

--In this video we will discuss, how to use a comma separated list of values in SQL WHERE clause. 
--Consider this Employees table


--sql server select where in list

--I alreeady know the FirstNames of 3 employees and we want to retrieve their respective records.
--This is very straight forward. We include a simple WHERE clause and the query works as expected.
--If we execute the following query, we get 3 the employees as expected.

Select * from Employees where FirstName in ('Mark','John', 'Sara')
--The following is the challenge. At compile time, we don't know the firstnames of the 3 employees,
--we only know them at runtime. So, what do we do? Well, create a variable to hold the list of FIRSTNAMES 
--separated by a delimeter like a comma (,) for example. 
--Finally pass this variable as a parameter.
--Basically the following are the 2 lines of SQL code that we want to be able execute.

Declare @FirstNamesList nvarchar(100) = 'Mark,John,Sara'
Select * from Employees where FirstName in (@FirstNamesList)

--This sounds so simple and easy, but trust me it's not. 
--The first time when someone asked me this question, it took over 30 minutes to figure out what's going on and
--to get it right. If we execute the above query as it is, we get an empty result set. 
--This is because we do not have any employee in the Employees table whose FirstName='Mark,John,Sara'

--STRING_SPLIT() in SQL Server
--The easiest way to get this to work is by using STRING_SPLIT() SQL Server built-in function.
--This function is very easy to use. As the name implies, it splits a given string and returns a single-column table
--whose rows are the substrings. The name of the column is Value

--STRING_SPLIT ( string , separator )
--It has 2 parameters - The string that we want to split and the seprator. In our example, the seprator is a comma (,)

Declare @FirstNamesList nvarchar(100) = 'Mark,John,Sara'
Select * from STRING_SPLIT(@FirstNamesList, ',')
--If you execute the above query, we get the following result as expected.

--string_split in sql server

--Using STRING_SPLIT with IN Clause
Declare @FirstNamesList nvarchar(100) = 'Mark,John,Sara'
SELECT * FROM Employees where FirstName IN (SELECT * FROM STRING_SPLIT(@FirstNamesList, ','))
--Using STRING_SPLIT in a JOIN operation
Declare @FirstNamesList nvarchar(100) = 'Mark,John,Sara'

SELECT Employees.* FROM Employees 
		 JOIN STRING_SPLIT(@FirstNamesList, ',') Result
		 ON Result.VALUE = Employees.FirstName
--SQL Script to create Employees table
Create table Employees
(
	Id int identity primary key,
	FirstName nvarchar(100),
	Gender nvarchar(10)
)
Go

Insert into Employees values ('Mark', 'Male')
Insert into Employees values ('John', 'Male')
Insert into Employees values ('Sara', 'Female')
Insert into Employees values ('Valarie', 'Female')
Insert into Employees values ('David', 'Male')
Insert into Employees values ('Ellie', 'Female')
Insert into Employees values ('Todd', 'Male')
Go