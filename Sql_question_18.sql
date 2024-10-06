




--The question in the interview goes like this - We have two tables - Table A and Table B. If I delete a row from table A, all the related rows in table B must also get deleted. How do we achieve this in SQL Server.

--sql query to delete parent child records


--To give it a bit more context and clarity, instead of Table A and Table B, let's use Departments and Employees tables.

--delete from multiple tables sql server

--When a row from Departments table is deleted, all the related rows from the Employees table must also be deleted.
--For example, if we delete the IT department row from the Departments table,
--we also want all the employees of the IT department to be deleted from the Employees table as well.

--Delete parent child rows in SQL
--DeptId column in the Employees table is a foreign key referencing Id column in the Departments table.

--sql server foreign key cascade delete

--So, when a row is deleted from the Departments table, 
--we also want all that department employees to be deleted from the Employees table. 
--Considering the fact that DeptId is a foreign key, the correct way to achieve this is by enforcing cascade deletes.


--Error - DELETE statement conflicted with the REFERENCE constraint
--If we try to delete a row from the Departments table and if that department has related rows in the Employees table, 
--by default, we get the following REFERENCE CONSTRAINT error

--The DELETE statement conflicted with the REFERENCE constraint "FK__Employees__DeptI__38996AB5".
--The conflict occurred in database "TestDB", table "dbo.Employees", column 'DeptId'.

--SQL Server Foreign Key Constraint Cascade Delete
--First, drop the existing foreign key constraint

Alter table Employees drop constraint FK__Employees__DeptI__125EB334

--Recreate the foreign key constraint with cascading deletes

Alter table Employees
add constraint FK_Dept_Employees_Cascade_Delete
foreign key (DeptId) references Departments(Id) on delete cascade

delete from Departments where Id=1;

--With foreign key constraint cascade deletes in place, when we delete a row from the Departments table, all the related rows from the Employees table are also automatically deleted.

--Same foreign key in multiple tables
--What if we have the same foreign key in multiple tables? In the following example, in both the tables (Teachers and Students) GenderId is foreign key referencing Id column from the Gender table.

--same foreign key in multiple tables


--Well, same idea, with foreign key cascading deletes on, when a row from the Gender table is deleted, 
--all the related rows from both the tables (i.e Teachers and Students) are also deleted automatically.

--What if we do not have a foreign key constraint or we do not want to turn on cascade deletes
--Well, in that case you can use a sql query like the following to do the deletes yourself.
--First delete the rows from the child tables and then from the parent table. 
--We are using a SQL transaction to treat all the DELETE queries as one unit.
--All of the DELETES should succeed. If one of the DELETE query fails for some reason, 
--rollback the transaction and UNDO the deletes.

Begin Try

       Begin Tran 

       Declare @GenderToDelete int = 2 

       -- Delete first from child tables
       Delete from Teachers where GenderId = @GenderToDelete
       Delete from Students where GenderId = @GenderToDelete 

       -- Finally Delete from parent table
       Delete from Gender where Id = @GenderToDelete 

       Commit Tran
End Try 

Begin Catch

       Rollback Tran

End Catch

--Please note : Always delete child records before deleting parent record, otherwise if a foreign key constraint is introduced later, your queries will start to fail.

--SQL Script for tables (Departments and Employees)
Create table Departments
(
       Id int primary key identity,
       [Name] nvarchar(50)
)
Go

Create table Employees
(
       Id int primary key identity,
       [Name] nvarchar(50),
       DeptId int foreign key references Departments(Id)
)
Go 

Insert into Departments values ('IT')
Insert into Departments values ('HR')
Go 

Insert into Employees values ('Mark', 1)
Insert into Employees values ('Mary', 1)
Insert into Employees values ('John', 2)
Insert into Employees values ('Sara', 2)
Insert into Employees values ('Steve', 2)


--SQL Script for tables (Gender, Teachers and Students)
Create table Gender
(
       Id int primary key identity,
       Gender nvarchar(20)
)
Go 

Create table Teachers
(
       Id int primary key identity,
       [Name] nvarchar(50),
       GenderId int foreign key references Gender(Id) on delete cascade
)
Go

Create table Students
(
       Id int primary key identity,
       [Name] nvarchar(50),
       GenderId int foreign key references Gender(Id) on delete cascade
)
Go

Insert into Gender values ('Male')
Insert into Gender values ('Female')
Go

Insert into Teachers values ('Mark', 1)
Insert into Teachers values ('John', 1)
Insert into Teachers values ('Mary', 2)
Insert into Teachers values ('Sara', 2)
Insert into Teachers values ('Flo', 2)
Go

Insert into Students values ('David', 1)
Insert into Students values ('Ron', 1)
Insert into Students values ('Jess', 2)
Insert into Students values ('Tara', 2)
Insert into Students values ('Innes', 2)
Go

select * from Students;
select * from Teachers;
select * from Gender;

delete from Gender where Id= 1;

Alter table Teachers
add constraint FK_Gender_Employees
foreign key (GenderId) references Gender(Id)

Alter table Students
add constraint FK_Gender_Students
foreign key (GenderId) references Gender(Id)

