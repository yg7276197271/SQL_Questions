--All people who are born on a given date (For example, 9th October 2017)
--All people who are born between 2 given dates (For example, all people born between Nov 1, 2017 and Dec 31, 2017)
--All people who are born on the same day and month excluding the year (For example, 9th October)
--All people who are born yesterday, today, tomorrow, last seven days, and next 7 days
--All people whose birth year is the same (For example, all people born in 2017, 2018 etc.)
--Orders placed between 2 given dates or on a given day, month, year etc.
--Customers gained or lost.
--Employees joined or left etc.
--We will use the following Employees table for all our queries

--sql date interview questions
--Here is the SQL Script to create the table and populate it with data
Create Table Employees
(
       ID int identity primary key,
       Name nvarchar(50),
       DateOfBirth DateTime
)

Insert Into Employees Values ('Tom', '2023-11-19 10:36:46.520')
Insert Into Employees Values ('Sara', '2023-11-18 11:36:26.400')
Insert Into Employees Values ('Bob', '2022-12-22 10:40:10.300')
Insert Into Employees Values ('Alex', '2022-12-30 9:30:20.100')
Insert Into Employees Values ('Charlie', '2022-11-25 7:25:14.700')
Insert Into Employees Values ('David', '2022-10-09 8:26:14.800')
Insert Into Employees Values ('Elsa', '2022-10-09 9:40:18.900')
Insert Into Employees Values ('George', '2023-11-15 10:35:17.600')
Insert Into Employees Values ('Mike', '2023-11-16 9:14:17.600')
Insert Into Employees Values ('Nancy', '2023-11-17 11:16:18.600')

--Notice, for the DateOfBirth column we have use DateTime data type.
--When a record is inserted, both the date and time parts are stored in the table.
--If you have used the Date data type instead, you would not have the time part stored and 
--as a result the queries would have been slightly easier. 

--However, in most cases it would be useful to capture the date and time when a transaction has occurred 
--as apposed to just the date part. Hence I have used DateTime data type.



--Write a SQL query to retrieve all people who are born on a given date (For example, 9th October 2017)

--Notice we are using the SQL CAST() method to convert DateTime data type to Date data type
--which returns just the date part and that is compared with the DATE string in the WHERE clause.

SELECT Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM     Employees
WHERE  CAST(DateOfBirth AS DATE) = '2022-10-09'


--sql query same birth date

--Write a SQL query to retrieve all people who are born between 2 given dates
--(For example, all people born between Nov 1, 2017 and Dec 31, 2017)

SELECT Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM     Employees
WHERE  CAST(DateOfBirth AS DATE) BETWEEN '2022-11-01' AND '2022-12-31'


--sql date range query between

--Write a SQL query to retrieve all people who are born on the same day and month excluding the year\
-- (For example, 9th October)

SELECT Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM     Employees
WHERE  DAY(DateOfBirth) = 9 AND Month(DateOfBirth) = 10



--sql select month and day from date

--Write a SQL query to get all people who are born in a given year (Example, all people born in the year 2017)

SELECT Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM    Employees
WHERE  YEAR(DateOfBirth) = 2022

--Write a SQL query to retrieve all people who are born yesterday

--To get the current date/time we use GETDATE() SQL function

SELECT GETDATE()

--To retrieve just the date part use CAST function

SELECT CAST(GETDATE() AS DATE)

--To get yesterday's DATE, use DATEADD() function

SELECT DATEADD(DAY, -1, CAST(GETDATE() AS DATE))

--To get all people who are born yesterday

SELECT Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM    Employees
WHERE CAST(DateOfBirth AS DATE) = DATEADD(DAY, -1, CAST(GETDATE() AS DATE))

--To get yesterday's date, we are adding -1 to the DAY part of the DATE. 
--So if today is Nov 10, 2017, the following DATEADD() function will give us Nov 9, 2017

SELECT DATEADD(DAY, -1, CAST(GETDATE() AS DATE))

--To get all people who will be born tomorrow, add 1 to the DAY part of the DATE as shown below.

SELECT Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM    Employees
WHERE  CAST(DateOfBirth AS DATE) = DATEADD(DAY, 1, CAST(GETDATE() AS DATE))

--To get all people who are born since yesterday (i.e all the people who are born yesterday and today)

SELECT           Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM              Employees
WHERE           CAST(DateOfBirth AS DATE)
BETWEEN       DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
AND                 CAST(GETDATE() AS DATE)

--To get all people who are born in the last 7 days (excluding today)

SELECT         Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM            Employees
WHERE         CAST(DateOfBirth AS DATE)
BETWEEN     DATEADD(DAY, -7, CAST(GETDATE() AS DATE))
AND               DATEADD(DAY, -1, CAST(GETDATE() AS DATE))

--To get all people who are born today

SELECT        Name, DateOfBirth, CAST(DateOfBirth AS DATE) AS [DatePart]
FROM            Employees
WHERE         CAST(DateOfBirth AS DATE) = CAST(GETDATE() AS DATE)