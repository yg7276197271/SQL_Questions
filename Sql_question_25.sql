--Can we replace right join with left join

--why is right join required when we have left join

--SQL Scripts if you want to follow along with the example.


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
     GenderID int foreign key references Genders(GenderID)
)
GO

Insert into Genders values (1, 'Male')
Insert into Genders values (2, 'Female')
Insert into Genders values (3, 'Not Specified')
GO

Insert into Employees values (1, 'Mark', 1)
Insert into Employees values (2, 'Sara', 2)
Insert into Employees values (3, 'Tom', null)
GO
--In this video we will discuss if we can replace a RIGHT JOIN with a LEFT JOIN and vice-versa. 
--Before that, let's quickly understand what a LEFT and RIGHT JOIN would do?


--LEFT JOIN
--Left vs right sql join

--LEFT JOIN returns all rows from the left table, and the matching rows from the right table.

--RIGHT JOIN
--why is right join required

--RIGHT JOIN returns all rows from the right table, and the matching rows from the left table.


--Why are the tables called LEFT and RIGHT tables


--Employees and Genders tables are bring joined in this query.
--With respect to the JOIN keyword, Employees table is present on the left hand side and Genders table on the right hand side.
--So in this query Employees is the LEFT TABLE and Genders is the RIGHT TABLE.

--JOIN or INNER JOIN
--The JOIN TYPE we have here is INNER JOIN. We can use INNER JOIN or just JOIN. 
--In both the cases we get only the matching rows from both the tables (LEFT and RIGHT).

--sql inner join example

--LEFT JOIN or LEFT OUTER JOIN
--We can use either LEFT JOIN or LEFT OUTER JOIN. They are the same, returns all rows from the left table, 
--and the matching rows from the right table.

--sql left join example


--RIGHT JOIN or RIGHT OUTER JOIN
--We can use either RIGHT JOIN or RIGHT OUTER JOIN. They are the same, returns all rows from the right table, and
--the matching rows from the left table.

--sql right join example

--Inner, Left and Right Joins
--sql inner left right join


--Can we replace RIGHT JOIN with a LEFT JOIN
--Well, we can. For example, the following 2 queries produce the same result.

SELECT EmployeeID, EmployeeName, Gender
FROM   Employees RIGHT JOIN Genders 
ON     Employees.GenderID = Genders.GenderID

SELECT EmployeeID, EmployeeName, Gender
FROM   Genders LEFT JOIN Employees 
ON     Employees.GenderID = Genders.GenderID

--Just switch the table positions and use LEFT JOIN instead of RIGHT JOIN and you get the same result. 
--Even from performance standpoint there should be no difference. We do not really need a RIGHT JOIN. 

--rewrite right join query with left join

--So you may be wondering, then why do we have a RIGHT JOIN when we can produce the same result by using a LEFT JOIN? 

--Well, it's sort of asking why do we need LESS THAN (<) when we already have GREATER THAN (>).
--Sometimes depending on the output you want, especially when you are joining three or more tables, 
--it may be easier to use a combination of LEFT and RIGHT JOINS instead of only LEFT JOINS.
--Like English, we read most languages from LEFT to RIGHT, but there are languages that are read from RIGHT to LEFT as well.
--So depending on how you read, some people may find LEFT JOINS easier and others RIGHT JOINS. 
--So, it's purely a matter of personal preference.
--I think every query that uses a right join can be rewritten to use a left join.