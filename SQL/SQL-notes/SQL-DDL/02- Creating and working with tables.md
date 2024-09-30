
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
```