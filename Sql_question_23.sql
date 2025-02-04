--Sql select most repeated value

--sql select most repeated value

--In this video we will discuss one of the common SQL interview questions. 
--Write a SQL query to select the most repeated column value. 
--If you understand GROUP BY in SQL, this query is very easy to write. 
--After you answer this question, the interviewer may ask the following related question as well to check your understanding 
--of GROUP BY and HAVING.


--Write a SQL query to find a value that is repeated n number of times i.e may be 5 times, 10 times, 1 million times etc.
--sql select most repeated column value

--The key to answer these questions is understanding GROUP BY and HAVING in SQL. 
--If you are new to these 2 concepts, please click here to learn about SQL Group By and Having


CREATE TABLE Students
(	
    Name NVARCHAR(50)
)
GO

INSERT INTO Students VALUES ('Sara')
INSERT INTO Students VALUES ('Tom')
INSERT INTO Students VALUES ('Mike')
INSERT INTO Students VALUES ('Tom')
GO
--SQL query to select the most repeated column value
SELECT		TOP 1 Name
FROM		Students
GROUP BY	Name
ORDER BY	Name DESC

--OR 

SELECT		TOP 1 Name , COUNT(NAME) as TotalRepetition
FROM		Students
GROUP BY	Name
ORDER BY	TotalRepetition DESC

--SQL query to find a value that is repeated n number of times
--n could be any value, 2 times, 5 times, 10 times, 1 million times etc.


--sql query to select most frequent value

--Please note : To filter SQL groups we use HAVING not WHERE

SELECT		TOP 1 Name
FROM		Students
GROUP BY	Name
HAVING		COUNT(Name) = 2

--Select all names whose count is 2
SELECT		Name
FROM		Students
GROUP BY	Name
HAVING		COUNT(Name) = 2



