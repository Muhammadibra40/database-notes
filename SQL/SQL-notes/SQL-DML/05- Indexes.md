Help the query engine to find data from tables quickly, which without the engine will need to do a whole table scan.

Creating an index:
```
CREATE index_type INDEX IX_TBLNAME_COLUMNNAME
ON TBLENAME (COLUMNNAME ASC/DESC)

-- Dropping an index
DROP INDEX tblName.indexName;
```

There is a SP that give the indexes on a table:
```
sp_Helpindex tblName;
```

Index Types:
- Clustered
- Non-Clustered
- Unique 
- Non-Unique

---


--> Clustered:
		- Clustered Index: Determines the **physical** order of the table, For this reason there can be only one clustered index in a table.
		- Primary Key Constraint automatically create a clustered and UNIQUE index **If there is no clustered index in the table before**
		- Even if the records were inputted randomly, they would be physically stored in order.
		- Clustered index can be Composite.
		
-->  Non-Clustered:
		 - A new table will be created with the indexed column and a row address corresponding to each row of indexed column, Which the engine uses to go to the desired record in the actual table.
		 - Table can have more than one Non-Clustered index.
		 - Doesn't affect how the data gets stored physically.

--> Difference:
		- Only one clustered index per table, but you can have more than one Non-clustered index.
		- Clustered index is faster than a non-clustered, because, the non-clustered index has to refer back to the table, if the selected column is not present in the index.
		- Clustered index determines the storage order of rows in the table, so it doesn't require additional disk space but a non-clustered index is stored in a separate table so additional space is required.
--> Unique and Non-Unique:
		- It's an index feature not an index type its self, so a clustered or a non-clustered index can be unique or non-unique
		- 