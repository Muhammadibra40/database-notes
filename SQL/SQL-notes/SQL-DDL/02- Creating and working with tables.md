
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