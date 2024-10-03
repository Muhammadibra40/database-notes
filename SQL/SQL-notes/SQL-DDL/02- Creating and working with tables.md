
--> ***Create a Table***

```
CREATE TABLE TBL_NAME
(
	COLUMN_NAME DATA_TYPE CONSTRAINT
);

EX:
CREATE TABLE GENDER
(
	ID INT PRIMARY KEY,
	GENDER NVARCHAR(10) NOT NULL
);
	
```
--> ***Foreign key references***

-  foreign keys used to enforce DB integrity.
-  By allowing only values in the FK_Column that match the values in the PK_Column in the referenced table so, FK prevents inserting non-valid values.
-  FK in a table points towards a PK in another table.
```
ALTER TABLE FK_TBL_NAME ADD CONSTRAINT constraint_name
FORIEGN KEY FK_COLUMN REFRENCES PK_TBL_NAME(PK_COLUMN)
```

--> ***Constraints***

**1- Default constraint**
```
-- Adding a default constaint for an exisiting column.
ALTER TABLE TBL_NAME
ADD CONSTAINT CONST_NAME
DEFAULT DEF_VALUE FOR EXISTING_COLUMN_NAME

-- Adding a default constaint while adding the column.
ALTER TABLE TBL_NAME
ADD COLUMN DATA_TYPE (NULL | NOT NULL)
CONSTRAINT CONST_NAME DEFAULT DEF_VALUE

-- Dropping a constraint.
ALTER TABLE TBL_NAME
DROP CONSTRAINT CONST_NAME
```
- If we insert a record to the table without specifying the value for a column with a DEFAULT constraint, the default value will be added automatically.
-  If we insert a record to the table with a null value for a column with a DEFAULT constraint, the default value won't be inserted automatically but there would be a null value.
ex:
INSERT INTO TBL_NAME (COL1, COL2, DEFAULT_COL, ....)
VALUES (VAL1, VAL2, NULL, ....)

--> ***Cascading referential integrity constraint***
- Defining the actions taken if a user attempts to delete or update a key which exists as a FK in another table.
- There are fours options when setting the referential integrity constraint:
		1-  No Action --> an error is raised and the DELETE or UPDATE is rolled back.
		2- Cascade: all rows containing those foreign keys are also deleted or updated.
		3- set NULL: all rows containing those foreign keys are set to NULL.
		4- set Default: all rows containing those foreign keys are set to default values.
```
-- syntax to add the No Action option
ALTER TABLE TBL_NAME 
ADD CONSTRAINT fk_TBL_NAME_REF_TBL_NAME_FK_COLUMN_NAME -- name convention for constraint
FOREIGN KEY (FK_COLUMN_NAME)
REFERENCES genres (id)
ON DELETE RESTRICT/NO ACTION;

-- syntax to add the Cascade option
ALTER TABLE TBL_NAME 
ADD CONSTRAINT fk_TBL_NAME_REF_TBL_NAME_FK_COLUMN_NAME
FOREIGN KEY (FK_COLUMN_NAME)
REFERENCES warehouses (PK_COLUMN_NAME)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- syntax to add the set NULL option
ALTER TABLE TBL_NAME 
ADD CONSTRAINT fk_TBL_NAME_REF_TBL_NAME_FK_COLUMN_NAME
FOREIGN KEY (FK_COLUMN_NAME)
REFERENCES genres (PK_COLUMN_NAME)
ON DELETE SET NULL

ALTER TABLE TBL_NAME 
ADD CONSTRAINT fk_TBL_NAME_REF_TBL_NAME_FK_COLUMN_NAME
FOREIGN KEY (FK_COLUMN_NAME)
REFERENCES genres (PK_COLUMN_NAME)
ON UPDATE SET NULL

-- syntax to add the set Default option
ALTER TABLE child_table
ADD CONSTRAINT fk_name
FOREIGN KEY (child_column)
REFERENCES parent_table (parent_column)
ON DELETE SET DEFAULT
ON UPDATE SET DEFAULT;

```

--> ***CHECK Constraint***
- If the condition is true the value is allowed to be written otherwise it doesn't.
```
ALTER TABLE TBL_NAME
ADD CONSTRAINT CONST_NAME (CHECK EXPRESSION)

or
during the creation of the table just add:
CHECK ()

CREATE TABLE Persons (  
    ID int NOT NULL,  
    LastName varchar(255) NOT NULL,  
    FirstName varchar(255),  
    Age int,  
    CHECK (Age>=18)  
);
```

--> ***Identity Column - Not every PK is an identity column and vice versa***

- ***The IDENTITY property effectively creates an auto-incrementing default value for a column. That column does not have to be unique though, so an IDENTITY column isn't necessarily a key.***
  
  two things need to be specified when making a column an identity column:
  1- Identity Increment --> step that is made every time a record is added (usually 1).
  2- Identity Seed --> The initial value of the column (usually 1).

	A column can definitely be an identity without being a PK.

	An identity is simply an auto-increasing column.
	
	A primary key is the unique column or columns that define the row.
	
	These two are often used together, but there's no requirement that this be so.

- Adding a value to an identity column ***Explicitly*** can't be done without specifying an option which is called IDENTITY_INSERT which needs to be ON firstly and when inserting the record, a column list must be used.
```
SET INDENTITY_INSERT tbl_name ON

INSERT INTRO tbl_name (col1, col2, ...) VALUES (val1, val2, ...)
```
- So in order to return the identity property to the column as it was deactivated when we wanted to add a value explicitly, we can activate it again by:
```
SET INDENTITY_INSERT tbl_name OFF
```
- There is a case when we want to add a value explicitly is when we delete records so, there are gaps in the column values and we want to fill them so we add them and then return to the original state.
- If we delete all the records in the table, the values doesn't get reset automatically, so if we need it to start from the seed identity that previously defined again:
  
```
  DBCC CHECKIDENT(tbl_name, RESEED, 0)
```

--> ***Retrieving the last generated identity value:***
```
-- same session, same scope "most used"
SELECT SCOPE_IDENTITY() 
or
-- same session, across any scope
SELECT @@IDENTITY
```
The difference is explained through the following example query:

```
-- assume we have two tabels both with an identity column tbl1, tbl2

-- trigger for each insert in tbl1 leads to an insert in tbl2
CREATE TRIGGER trig_name ON tbl1 FOR INSERT
AS
BEGIN
	INSERT INTO tbl2 VALUES('X')
END

-- Just inserting a value to tbl1
INSERT INTO tbl1 VALUES('Y')

-- Getting the last generated value for an identity key

-- will return the last value for identity column in tbl1
SELECT SCOPE_IDENTITY()

-- will return the last value for identity column in tbl2
SELECT @@IDENTITY
```
- As the insertion operation happened to tbl1 and done explicitly by a command so, **SCOPE_IDENTITY()** will return its last identity value as it works for the scope
- but **@@IDENTITY** returns the last identity value generated and it doesn't matter which scope but only it's concerned only about the session. 

There is a command for **specific table, any session, any scope**

```
IDENT_CURRENT('tbl_name')
```

--> ***Unique constraint***
-  Enforce uniqueness to a column, so if we need to make a column unique but it's not a primary key we apply the unique constraint to it.

**Table can have more than one unique key (constraint) but,
only one primary key**

- primary key doesn't allow nulls at all while unique key allows one and only one null.
```
-- During the creation of the table
CREATE TABLE Persons (  
    ID int NOT NULL UNIQUE,  
    LastName varchar(255) NOT NULL,  
    FirstName varchar(255),  
    Age int  
);

-- If the table is already created
ALTER TABLE tbl_name 
ADD CONSTRAINT const_name UNIQUE(column_name)

-- Dropping a constraint
ALTER TABLE tbl_nae
DROP CONSTRAINT const_name
```

