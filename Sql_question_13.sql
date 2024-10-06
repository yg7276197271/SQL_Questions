--SQL Script to create the tables and populate them with test data
Create table TableA
(
 Id int identity primary key,
 Name nvarchar(50)
)
Go

Insert into TableA values ('Mark')
Go

Create table TableB
(
 Id int identity primary key,
 Name nvarchar(50)
)
Go

Insert into TableB values ('Mary')
Go

--Blocking : Occurs if a transaction tries to acquire an incompatible lock on a resource that another transaction has already locked. The blocked transaction remains blocked until the blocking transaction releases the lock. 

--Example : Open 2 instances of SQL Server Management studio. From the first window execute Transaction 1 code and from the second window execute Transaction 2 code. Notice that Transaction 2 is blocked by Transaction 1. Transaction 2 is allowed to move forward only when Transaction 1 completes.

--Transaction 1
Begin Tran
Update TableA set Name='Mark Transaction 1' where Id = 1
Waitfor Delay '00:00:10'
Commit Transaction

--Transaction 2
Begin Tran
Update TableA set Name='Mark Transaction 2' where Id = 1
Commit Transaction

--Deadlock : Occurs when two or more transactions have a resource locked, and each transaction requests a lock on the resource that another transaction has already locked. Neither of the transactions here can move forward, as each one is waiting for the other to release the lock. So in this case, SQL Server intervenes and ends the deadlock by cancelling one of the transactions, so the other transaction can move forward.

--Example : Open 2 instances of SQL Server Management studio. From the first window execute Transaction 1 code and from the second window execute Transaction 2 code. Notice that there is a deadlock between Transaction 1 and Transaction 2.

-- Transaction 1
Begin Tran
Update TableA Set Name = 'Mark Transaction 1' where Id = 1

-- From Transaction 2 window execute the first update statement

Update TableB Set Name = 'Mary Transaction 1' where Id = 1

-- From Transaction 2 window execute the second update statement
Commit Transaction

-- Transaction 2
Begin Tran
Update TableB Set Name = 'Mark Transaction 2' where Id = 1

-- From Transaction 1 window execute the second update statement

Update TableA Set Name = 'Mary Transaction 2' where Id = 1

-- After a few seconds notice that one of the transactions complete 
-- successfully while the other transaction is made the deadlock victim
Commit Transaction