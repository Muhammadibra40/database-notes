You need to set the column to **NOT NULL** before making it a Primary Key (PK) as the fundamental constraints and requirements of a Primary Key in a relational database:

### Primary Key Requirements:

1. **Uniqueness**: A primary key ensures that all rows in a table have a unique identifier.
2. **Non-NULL Values**: A primary key column cannot contain `NULL` values because a `NULL` represents the absence of a value, which violates the uniqueness constraint. The database wouldn't be able to ensure uniqueness if `NULL` values were allowed, as `NULL` is not considered equal to any value (including other `NULL` values).

---

### Why Set `NOT NULL` Before Adding a Primary Key

When you declare a column as a Primary Key, the database automatically enforces both **uniqueness** and **non-NULL** constraints. However:

- If the column is already allowed to accept `NULL` values, attempting to make it a primary key will fail because the database cannot enforce the `NOT NULL` requirement on a column that permits `NULL`s.
- To address this, you explicitly set the column to **NOT NULL** to satisfy the primary key’s constraints before defining it as the primary key.

---

### Your Scenario:

Here’s what’s happening step by step in your code:

1. **Modify the column to `NOT NULL`:**
    
    ```sql
    ALTER TABLE dbo.OnlineRetailSales$
    ALTER COLUMN OrderNum float NOT NULL
    ```
    
    This ensures that the `OrderNum` column doesn’t allow any `NULL` values, making it eligible to be part of a primary key.
    
2. **Add the Primary Key constraint:**
    
    ```sql
    ALTER TABLE dbo.OnlineRetailSales$ ADD PRIMARY KEY (OrderNum)
    ```
    
    Now that the column satisfies the `NOT NULL` requirement, the database can enforce the uniqueness constraint and create the primary key.
    

---

### What Happens if You Skip Setting `NOT NULL`?

If you attempt to add a Primary Key constraint on a column that allows `NULL` values, the database will throw an error similar to:

```
Cannot define PRIMARY KEY constraint on nullable column in table 'OnlineRetailSales$'.
```

This is because the database cannot enforce the requirement that every row has a unique, non-NULL identifier when the column is nullable.

---

### Best Practices:

- Always verify or modify columns to meet primary key constraints (`NOT NULL` + uniqueness) before defining the key.
- Consider whether the data type is appropriate for a primary key. In your case, `float` is generally not recommended for primary keys because floating-point precision can lead to inaccuracies. Instead, an integer or numeric type is preferred.
