--Write a SQL query to retrieve rows that contain only numerical data. The output of the query should be as shown below.
--retrieve only integer data from a column in a sql server table

--SQL Script to create the TestTable
Create Table TestTable
(
     ID int identity primary key,
     Value nvarchar(50)
)

Insert into TestTable values ('123')
Insert into TestTable values ('ABC')
Insert into TestTable values ('DEF')
Insert into TestTable values ('901')
Insert into TestTable values ('JKL')

--This is very easy to achieve. If you have used ISNUMERIC() function in SQL Server, then you already know the answer. Here is the query
Select Value from TestTable Where ISNUMERIC(Value) = 1

Select Value from TestTable Where ISNUMERIC(Value) = 0

--ISNUMERIC function returns 1 when the input expression evaluates to a valid numeric data type,
--otherwise it returns 0. For the list of all valid numeric data types in SQL

DROP TABLE TestTable;