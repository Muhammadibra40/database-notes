***Stored Procedures Introduction***
--
A stored procedure is a group of SQL statements.
Motivation: If you have a situation where you can write the same query over and over.

```
-- creation of a stored procedure
CREATE PROCEDURE sp_name 
AS 
BEGIN
.
.
.
END

-- Excution can be done by
1- sp_name
2- EXEC sp_name
3- EXECUTE sp_name
```

***Stored Procedures with input Parameters***
--
--> Parameters can be passed to SPs just as functions in any other language:

```
CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
@Gender nvarcher(20),
@DepartmentID int
AS
BEGIN
SELECT  Name,
		Gender,
		DepartmentID
FROM tblEmployee
WHERE Gender = @Gender
AND DepartmentID = @DepartmentID
END

-- Order in passing the parameters is important.
spGetEmployeesByGenderAndDepartment 'Male', 1
spGetEmployeesByGenderAndDepartment 1, 'Male' --> will throw an error 
spGetEmployeesByGenderAndDepartment @DepartmentID = 1, @Gender = 'Male'
```

-  What was defined above is called User Defined Stored Procedure and there are also in SQL server system SPs which can be used by the user either. 
-  System SPs has a convention name starting with 'sp_' so, it's not recommended by SQL server to create a user defined SP name starting with 'sp_' as it might cause ambiguity and it might cause a conflict in newer versions of SQL server with new system SPs. 
-  To change the definition of the SP we use ALTER PROCEDURE statement.
-  To change the definition of the SP we use DROP PROCEDURE 'SPName'.
-  We can see the text of a SP by using the system SP 'sp_helptext'.
-  Bur we can encrypt the SP by using 'WITH ENCRYPTION' int the SP definition body. 
---
***Stored Procedures with output Parameters***
--
--> Output parameters allow us to return a value from the SP.
```
CREATE PROCEDURE spGetEmployeeCountByGender
@Gender VARCHAR(20), -- by default an input parameter
@EmployeeCount INT OUTPUT 
AS 
BEGIN 
SELECT 
	@EmployeeCount = COUNT(id)
FROM
	tblEmployee
WHERE 
	Gender = @Gender
END


-- Here there is a returned value from the SP, So there must be a variable -to expect this value.
The datatype of the created variable must match the SP output parameter.

DECLARE @EmployeeTotal INT
-- must put OUTPUT beside variable in SP excution or it will be null if the variable wasn't intialized or it will return the value that the variable is holding.
EXCUTE spGetEmployeeCountByGender 'Male', @EmployeeTotal OUTPUT
PRINT @EmployeeTotal
```

---

***Useful System Stored Procedures***
--

-  sp_help: Shows info about the SP (or with any db object).
-  sp_helptext: Gives the definition text of the SP.
-  sp_depends: View the dependencies of the stored procedure.
---

***Output Parameters or Return Values***
--
-  When a SP is executed, it returns an integer status variable:
			- 0 indicates Success
			-  non-zero indicates Failure
- ==Return Value must be an INTEGER== So, in case that the return value is rather than an INTEGER the output parameter is to be used in this case.
Example of a Return SP instead of using an output parameter:

```
CREATE PROCEDURE spGetTotalCountOfEmployee
AS
BEGIN
	RETURN (SELECT COUNT(id) FROM Employees)
END

DECLARE @TotalEmployees INT
EXECUTE @TotalEmployees = spGetTotalCountOfEmployee
SELECT @TotalEmployees 
```

---
***Advantages of using Stored Procedures***

1- Execution plan reusability but in normal ad-hoc queries a slight change in the query changes the execution plan.

```
CREATE PROCEDURE spGetNameBId
@Id int
AS
BEGIN
	SELECT Name
	FROM tblEmployee
	WHERE Id = @Id
END

-- Changing the parameter passed here won't change the execution plan.
EXECUTE spGetNameBId 1
EXECUTE spGetNameBId 2

-- normal ad-hoc Queries, if i change 1 to 2 or even s simple space, it will create a whole new exxcution plan
SELECT Name FROM tblEmployee WHERE id = 1  
```

2- Reduces Network Traffic
-  As when execute the SP query from an external Application we only pass 'EXECUTE spGetNameBId 1', but if we use normal queries the whole query needs to be sent which creates an impact on the network traffic.
3- Code reusability and better maintainability.
4- Better Security: As i can grant access to a SP to a specific dep that only needs to be exposed to certain data(Like VIEWS).
5- Avoids SQL Injection Attack.

