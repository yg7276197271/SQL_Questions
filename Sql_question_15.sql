--SQL Script to create the tables

Create table Students
(
     Id int primary key identity,
     StudentName nvarchar(50)
)
Go

Create table Courses
(
     Id int primary key identity,
     CourseName nvarchar(50)
)
Go

Create table StudentCourses
(
     StudentId int not null foreign key references Students(Id),
     CourseId int not null foreign key references Courses(Id)
)
Go
--Students - Id column is identity column
--Courses - Id column is identity column
--StudentCourses - StudentId and CourseId columns are foreign keys referencing Id column in Students and Courses tables
--As you can see, StudentCourses is a bridge table that has many to many relationship with Students and Courses tables. This means a given student can be enrolled into many courses and a given course can have many students enrolled.

--Below is the question asked in an interview for SQL Server Developer role. 



--Write a SQL script to insert data into StudentCourses table. Here are the rules that your script should follow.

--1. There will be 2 inputs for the script 
--Student Name - The name of the student who wants to enrol into a course
--Course Name - The name of the course the student wants to enrol into

--2. If the student is already in the Students table, then use that existing Student Id. If the student is not already in the Students table, then a row for that student must be inserted into the Students table, and use that new student id.

--3. Along the same lines, if the course is already in the Courses table, then use that existing Course Id. If the course is not already in the Courses table, then a row for that course must be inserted into the Courses table, and use that new course id.
--
--4. There should be no duplicate student course enrolments, i.e a given student must not be enrolled in the same course twice. For example, Tom must not be enrolled in C# course twice.

--Answer : To avoid duplicate student course enrolments create a composite primary key on StudentId and CourseId columns in StudentCourses table. With this composite primary key in place, if someone tries to enroll the same student in the same course again we get violation of primary key constraint error.

Alter table StudentCourses
Add Constraint PK_StudentCourses
Primary Key Clustered (CourseId, StudentId)

--Here is the SQL script that inserts data into the 3 tables as expected

Declare @StudentName nvarchar(50) = 'Sam'
Declare @CourseName nvarchar(50) = 'SQL Server'

Declare @StudentId int
Declare @CourseId int

-- If the student already exists, use the existing student ID
Select @StudentId = Id from Students where StudentName = @StudentName
-- If the course already exists, use the existing course ID
Select @CourseId = Id from Courses where CourseName = @CourseName

-- If the student does not exist in the Students table
If (@StudentId is null)
Begin
     -- Insert the student
     Insert into Students values(@StudentName)
     -- Get the Id of the student
     Select @StudentId = SCOPE_IDENTITY()
End

-- If the course does not exist in the Courses table
If (@CourseId is null)
Begin
     -- Insert the course
     Insert into Courses values(@CourseName)
     -- Get the Id of the course
     Select @CourseId = SCOPE_IDENTITY()
End

-- Insert StudentId & CourseId in StudentCourses table

Insert into StudentCourses values(@StudentId, @CourseId)

--If required, we can very easily convert this into a stored procedure as shown below.

Create procedure spInsertIntoStudentCourses
@StudentName nvarchar(50),
@CourseName nvarchar(50)
as
Begin

     Declare @StudentId int
     Declare @CourseId int

     Select @StudentId = Id from Students where StudentName = @StudentName
     Select @CourseId = Id from Courses where CourseName = @CourseName

     If (@StudentId is null)
     Begin
          Insert into Students values(@StudentName)
          Select @StudentId = SCOPE_IDENTITY()
     End

     If (@CourseId is null)
     Begin
          Insert into Courses values(@CourseName)
          Select @CourseId = SCOPE_IDENTITY()
     End

     Insert into StudentCourses values(@StudentId, @CourseId)

End

--Use the following statement to execute the stored procedure
Execute spInsertIntoStudentCourses 'Tom','C#'