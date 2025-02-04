--Write a sql query to extract only alphabets from a given alphanumeric string.
--Write a sql query to extract only numbers from a given alphanumeric string.

--This table has only one column and it contains both numbers and alphabets


--Now, the task at hand is to write a query that  extracts numbers and letters into separate columns as you can see below.

--sql query to extract numbers from a string


--If you want to follow along, the following is the SQL script to create the table and populate it with test data.

Create table TestTable
(
	IDName nvarchar(25)
)
Go

Insert into TestTable values('Nir10ma0la1')
Insert into TestTable values('1A0ru0na2')
Insert into TestTable values('S1h00ashi3')
Insert into TestTable values('N100aga4raj')
Insert into TestTable values('Sruj100a5n')
Insert into TestTable values('Sr1u0s0h6ti')
Insert into TestTable values('Ha1n0u0man7th')
Insert into TestTable values('Sh10iva08mma')
Insert into TestTable values('10Sonu09')
Insert into TestTable values('Nim10m1u0')
Go

--User Defined Functions and
--How to use SQL Server built-in functions - PatIndex() and Stuff()
--sql server patindex examples




--Patindex in SQL
--PATINDEX('%Pattern%', Expression)
--Returns the starting position of the first occurrence of a pattern in a specified expression. 
--It takes two arguments, the pattern to be searched and the expression. 
--If the specified pattern is not found, PATINDEX() returns ZERO.
select PATINDEX('%[^0-9]%','1B2C3'); -- Result is 2 . i.e occurance of 1st non numeric char
select PATINDEX('%[0-9]%','1B2C3'); -- Result is 1 . i.e occurance of 1st  numeric char

--Stuff in sql server
--STUFF(Original_Expression, Start, Length, Replacement_expression)
--STUFF() function inserts Replacement_expression, at the start position specified, along with removing the charactes 
--specified using Length parameter.

select STUFF('1B2C3',2,1,''); -- Result is 12C3 Replaced 2nd char i.e B by ''
select STUFF('1B2C3',2,2,'A'); --Result is 1AC3 Replaced 2nd & 3rd char  by 'A'

--SQL function to extract numbers from an alphanumeric string
Create function UDF_ExtractNumbers
(  
  @input varchar(255)  
)  
Returns varchar(255)  
As  
Begin  
  Declare @alphabetIndex int = Patindex('%[^0-9]%', @input)  
  Begin  
    While @alphabetIndex > 0  
    Begin  
      Set @input = Stuff(@input, @alphabetIndex, 1, '' )  
      Set @alphabetIndex = Patindex('%[^0-9]%', @input )  
    End  
  End  
  Return @input
End

--Same function with code explanation
Create function UDF_ExtractNumbers
(  
  -- Input is alphanumeric string
  @input varchar(255)  
)  
-- Returns numbers as a string
Returns varchar(255)  
As  
Begin  
  -- Returns the index of a character that is not a number
  -- If the specified pattern is not found, ZERO is returned
  Declare @alphabetIndex int = Patindex('%[^0-9]%', @input)  
  Begin  
    While @alphabetIndex > 0  
    Begin  
      -- In the input string (@input) at the position (@alphabetIndex) 
	  -- where we have a non-numeric chracter, replace that 1
	  -- character with an empty string ('')
	  Set @input = Stuff(@input, @alphabetIndex, 1, '' )
	  -- Find the next non-numeric character and repeat the above step
	  -- until all non-numeric characters are replaced with an empty string
      Set @alphabetIndex = Patindex('%[^0-9]%', @input )  
    End  
  End  
  Return @input
End


--Using the user defined function in a query
Select dbo.UDF_ExtractNumbers(IDName)  as Numbers from TestTable



--SQL function to extract alphabets from alphanumeric string
Create function UDF_ExtractAlphabets
(  
  @input varchar(255)  
)  
Returns varchar(255)  
As  
Begin  
  Declare @alphabetIndex int = Patindex('%[^a-zA-Z]%', @input)  
  Begin  
    While @alphabetIndex > 0  
    Begin  
      Set @input = Stuff(@input, @alphabetIndex, 1, '' )  
      Set @alphabetIndex = Patindex('%[^a-zA-Z]%', @input )  
    End  
  End  
  Return @input
End

--Same function with code explanation
Create function UDF_ExtractAlphabets
(  
  -- Input is alphanumeric string
  @input varchar(255)  
)  
-- Returns numbers as a string
Returns varchar(255)  
As  
Begin  
  -- Returns the index of a character that is not an alphabet
  -- If an alphabet is not found, ZERO is returned
  Declare @numberIndex int = Patindex('%[^a-zA-Z]%', @input)  
  Begin  
    While @numberIndex > 0  
    Begin  
      -- In the input string (@input) at the position (@numberIndex) 
	  -- where we have an alphabetic chracter, replace that 1 alphabetic
	  -- character with an empty string ('')
	  Set @input = Stuff(@input, @numberIndex, 1, '' )
	  -- Find the next alphabetic character and repeat the above step
	  -- until all alphabetic characters are replaced with an empty string
      Set @numberIndex = Patindex('%[^a-zA-Z]%', @input )  
    End  
  End  
  Return @input
End

--Using the user defined function in a query
Select dbo.UDF_ExtractAlphabets(IDName) as Name from TestTable
--how to extract alphabets from alphanumeric string in sql

--Using both the user defined functions in a SQL query
Select dbo.UDF_ExtractNumbers(IDName) as ID, dbo.UDF_ExtractAlphabets(IDName) as Name from TestTable


drop table TestTable;

drop function UDF_ExtractNumbers;
drop function UDF_ExtractAlphabets;