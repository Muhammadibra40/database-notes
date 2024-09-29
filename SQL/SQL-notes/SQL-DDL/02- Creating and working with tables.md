
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
-  By allowing only values in the FK_Column that match the values in the PK_Column in the referenced table.
```
ALTER TABLE FK_TBL_NAME ADD CONSTRAINT constraint_name
FORIEGN KEY FK_COLUMN REFRENCES PK_TBL_NAME(PK_COLUMN)
```