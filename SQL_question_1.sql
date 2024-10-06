Create table Employees
(
     ID int primary key identity,
     FirstName nvarchar(50),
     LastName nvarchar(50),
     Gender nvarchar(50),
     Salary int
)
GO

Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Mark', 'Hastings', 'Male', 60000)
Insert into Employees values ('Steve', 'Pound', 'Male', 45000)
Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Philip', 'Hastings', 'Male', 45000)
Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000)
Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000)

Insert into Employees values ('John', 'Stanmore', 'Male', 80000)
GO

--To find the highest salary it is straight forward. We can simply use the Max() function as shown below.
Select Max(Salary) from Employees

--To get the second highest salary use a sub query along with Max() function as shown below.
Select Max(Salary) from Employees where Salary < (Select Max(Salary) from Employees)

--To find nth highest salary using Sub-Query
SELECT TOP 1 SALARY
FROM (
      SELECT DISTINCT TOP 2 SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      ) RESULT
ORDER BY SALARY

--To find nth highest salary using CTE
--Dense Rank function gives same rank if salary is equal
--Here 7000 is repeated so it will get same rank
WITH RESULT AS
(
    SELECT SALARY,
           DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DENSERANK
    FROM EMPLOYEES
)
SELECT TOP 1 SALARY
FROM RESULT
WHERE DENSERANK = 2;

----With ROW_NUMBER function (will fail to give proper result if we have multiple records with same salary)

WITH RESULT AS
(
    SELECT SALARY,
           ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RowNum
    FROM EMPLOYEES
)
SELECT TOP 1 SALARY
FROM RESULT
WHERE RowNum = 3;

--expected is 6000 but we get 7000
--As row_number functions gives different number even if salary is same

drop table EMPLOYEES;