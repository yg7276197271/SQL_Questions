
--primary key on two columns sql server


--What is a primary key

--A primary key uniquely identifies a row in a table. You cannot store NULL or duplicate values in a primary key column.

--In the Books table, BookId column is the primary key.

--what is primary key with example

--Similarly, in the Authors table, AuthorId is the primary key.

--Primary key example in sql


--Why do we need a primary key?
--Well to uniquely identify a table row. Even if we have 2 authors with the same first and last names, 
--we can uniquely identify them using the AuhtorId column.

--In both these examples, primary key contains only one column. In the case of Books table, it is the BookId column and
--in the case of Authors, it is AuthorId.

--What is a composite primary key
--Well, a primary key that is made up of 2 or more columns is called a composite primary key. 
--A common real world use case for this is, when you have a many-to-many relationship between two tables 
--i.e when multiple rows in one table are associated with multiple rows in another table.

--For example, there is a many-to-many relationship between customers and products tables because 
--a customer can purchase many products, and similarly a product like an iPhone for example can be purchased by many customers.

--Another example, is Authors and Books. A single author can write many books and similarly a given book can be 
--authored my multiple authors.

--Relational database systems usually don't allow us to implement a direct many-to-many relationship between two tables.

--sql many to many relationship example


--We need a third table and it is this table that contains the many-to-many relationship rows. 
--This third table is commonly called link, join or junction table.

--sql server composite primary key example

--In a real world this junction table would contain only the 2 foreign key columns and nothing else.
--In our example, those 2 columns are AuthorId and BookId.

--sql composite primary key with foreign key


--The following is the code to create a composite primary key. In our example, we have 2 columns in the composite primary key. We can have more than 2 columns if we want to, just include another comma and your third column. 

--Create composite primary key while creating table
Create table Authors_Books
(
	AuthorId int not null foreign key references Authors(AuthorId),
	BookId int not null foreign key references Books(BookId)

	Constraint PK_Books_Authors Primary Key (AuthorId, BookId)
)
Go
--Create composite primary key after creating table
--In the above example, we are creating the composite primary key along with the table i.e while the table is being created,
--but what if we already have a table and want to create a composite primary key on that existing table. 
--Well, the following is the code for that.

Alter table [Your_table_name]
Add constraint [Meaningful_name_for_the_constraint]
primary key (Column1, Column2, Column3)
--Composite primary key rules
--sql composite primary key example


--A composite primary key is just like a primary key on a single column. All the rules still apply. 
--Doesn't allow null values and cannot contain duplicates.
--Values in an individual column can be duplicated, but across the columns they must be unique. 
--Null values are not allowed in any columns in the composite primary key.

SQL Scripts
Create table Authors
(
	AuthorId int primary key,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Gender nvarchar(20)
)
Go

Create table Books
(
	BookId int primary key,
	BookTitle nvarchar(50),
	Price int,
	Published bit
)
Go

Create table Authors_Books
(
	AuthorId int not null foreign key references Authors(AuthorId),
	BookId int not null foreign key references Books(BookId)

	Constraint PK_Books_Authors Primary Key (AuthorId, BookId)
)
Go

Alter table Authors_Books 
ADD Constraint PK_Books_Authors
Primary Key (AuthorId, BookId)

Insert into Authors values (1, 'Mark', 'Dunn', 'Male')
Insert into Authors values (2, 'Sara', 'Longhorn', 'Female')
Insert into Authors values (3, 'Jessica', 'Dale', 'Female')
Insert into Authors values (4, 'Steve', 'Wicht', 'Male')
Go

Insert into Books values (1, 'Learn SQL', 10, 1)
Insert into Books values (2, 'Learn C#', 20, 1)
Insert into Books values (3, 'Learn CSS', 15, 1)
Insert into Books values (4, 'Learn HTML', 20, 0)
Go

Insert into Authors_Books values (1, 1)
Insert into Authors_Books values (1, 2)
Insert into Authors_Books values (2, 1)


Insert into Authors_Books values (1, 1)




