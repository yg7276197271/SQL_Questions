--Here is the recursive CTE that gets the organization hierarchy based on an EmployeeId. Notice that the recursive CTE has got 2 parts (Anchor & Recursive Member)
Declare @ID int;
Set @ID = 7;

WITH EmployeeCTE AS
(
     -- Anchor
     Select EmployeeId, EmployeeName, ManagerID
     From Employees
     Where EmployeeId = @ID
    
     UNION ALL
    
     -- Recursive Member
     Select Employees.EmployeeId , Employees.EmployeeName, Employees.ManagerID
     From Employees
     JOIN EmployeeCTE
     ON Employees.EmployeeId = EmployeeCTE.ManagerID
)

Select E1.EmployeeName, ISNULL(E2.EmployeeName, 'No Boss') as ManagerName
From EmployeeCTE E1
LEFT Join EmployeeCTE E2
ON E1.ManagerID = E2.EmployeeId

--When David's EmployeeId is passed the query produces the following output
--how does a recursive cte work

--Let's now discuss how the CTE executes line by line.
--Step 1: Execute the anchor part and get result R0
--Step 2: Execute the recursive member using R0 as input and generate result R1
--Step 3: Execute the recursive member using R1 as input and generate result R2
--Step 4: Recursion goes on until the recursive member output becomes NULL
--Step 5: Finally apply UNION ALL on all the results to produce the final output

---------------------------------
WITH EmployeeCTE AS
(
     -- Anchor
     Select EmployeeId, EmployeeName, ManagerID
     From Employees
     Where EmployeeId = 7
    
     UNION ALL
    
     -- Recursive Member
     Select Employees.EmployeeId , Employees.EmployeeName, Employees.ManagerID
     From Employees
     JOIN EmployeeCTE
     ON Employees.EmployeeId = EmployeeCTE.ManagerID
)
select * from EmployeeCTE;