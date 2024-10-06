--We have 2 tables - TableA and TableB. Both the tables have just one column each. 
--TableA has 2 rows and TableB has 3 rows.

--sql inner join cross join return same count how

--To join both these tables, we are using ColumnA in TableA and ColumnB in TableB. 
--The following is the SQL Server interview question.

--No matter how you join these 2 tables, the query produces the same result i.e 6 rows - How and Why?

---Inner Join
--Left Outer Join
--Right Outer Join
--Full Outer Join OR
--even Cross Join

--SQL Script to create and populate the tables with test data
Create Table TableA
(
       ColumnA int
)
Go

Create Table TableB
(
       ColumnB int
)
Go

Insert into TableA Values (1)
Insert into TableA Values (1)
Go 

Insert into TableB Values (1)
Insert into TableB Values (1)
Insert into TableB Values (1)
Go

Select ColumnA, ColumnB
from TableA
inner join TableB
on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB
from TableA
left outer join TableB
on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB
from TableA
right outer join TableB
on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB
from TableA
full outer join TableB
on TableA.ColumnA = TableB.ColumnB 

Select ColumnA, ColumnB
from TableA
cross join TableB


--All the above queries return the same row count - 6 rows. 
--How and why all the different types of joins return the same count of rows.

--sql inner left right join same results

--Every row in TableA matches with every row in TableB, 
--so what we get back is a cartesian product 
--i.e the number of rows in TableA multiplied by the number of rows in TableB. So, in essence it's like a cross join. 

--sql inner left right join result same how

--TableA has 2 rows and TableB 3 rows. Every row in TableA matches with every row in TableB. So irrespective of the type of join we get the cartesian product 6, i.e 2 rows in TableA multiplied by 3 rows in TableB.

--What do you think is the result going to be if we add one more row with a value of 1 to TableB.

--Well, the same logic, Cartesian product. 2 rows in TableA multiplied by 4 rows in TableB. So, the answer is 8.

Insert into TableA Values (1)
Go



--Execute all the 5 select queries again and you will get 8 rows as the result.

--Are you still confused? Let's look at another example.

--Drop both the tables

Drop table TableA
Drop table TableB


--Recreate the tables. We now have a second column called SomeValue in both the tables.

Create Table TableA
(
       ColumnA int,
       SomeValue nvarchar(2)
)
Go

Create Table TableB
(
       ColumnB int,
       SomeValue nvarchar(2)
)
Go

--Insert test data.

Insert into TableA Values (1, 'A1')
Insert into TableA Values (1, 'A2')
Go 

Insert into TableB Values (1, 'B1')
Insert into TableB Values (1, 'B2')
Insert into TableB Values (1, 'B3')
Go


--Now, the select queries. In addition to ColumnA and ColumnB we also want to select SomeValue From TableA. Let's give it an alias TableASomeValue. Similarly SomeValue column from TableB as well. Let's call it TableBSomeValue.

--Let's include the same select list on the rest of the 4 queries - that is left join, right join, full join, and cross join.

Select ColumnA, ColumnB, TableA.SomeValue as [TableASomeValue],
TableB.SomeValue as [TableBSomeValue]
from TableA inner join
TableB on TableA.ColumnA = TableB.ColumnB 

Select ColumnA, ColumnB, TableA.SomeValue as [TableASomeValue],
TableB.SomeValue as [TableBSomeValue]
from TableA left outer join
TableB on TableA.ColumnA = TableB.ColumnB 

Select ColumnA, ColumnB, TableA.SomeValue as [TableASomeValue],
TableB.SomeValue as [TableBSomeValue]
from TableA right outer join
TableB on TableA.ColumnA = TableB.ColumnB 

Select ColumnA, ColumnB, TableA.SomeValue as [TableASomeValue],
TableB.SomeValue as [TableBSomeValue]
from TableA full outer join
TableB on TableA.ColumnA = TableB.ColumnB

Select ColumnA, ColumnB, TableA.SomeValue as [TableASomeValue],
TableB.SomeValue as [TableBSomeValue]
from TableA cross join TableB

--It takes that first row in TableA, that is the the row which has the value A1 and returns every row in TableB, so we have A1B1, A1B2, A1B3. The same happends even with the second row in TableA. So we have A2B1, A2B2, A2B3