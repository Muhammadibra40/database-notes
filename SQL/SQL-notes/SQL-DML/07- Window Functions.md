1- ROW_NUMBER( )

The **`ROW_NUMBER()`** function is a **window function** in SQL that assigns a unique sequential number to rows within a result set. The numbering starts at 1 and increments by 1 for each row in the defined window.

**Deleting all duplicate rows except one.**

```
WITH employees_cte AS(
	SELECT  *,
			ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS RowNum
	FROM employees
)

DELETE FROM employees_cte WHERE RowNum > 1
```

---

### Syntax

```sql
ROW_NUMBER() OVER ([PARTITION BY column_name] [ORDER BY column_name])
```

- **`PARTITION BY`**: Divides the result set into partitions (optional). The row numbering restarts at 1 for each partition.
- **`ORDER BY`**: Specifies the order of rows within each partition, determining the sequence of the row numbers.

---

### Key Points

1. **Sequential Numbering**: Each row gets a unique number based on the specified `ORDER BY`.
2. **Partitioning (Optional)**: If you use `PARTITION BY`, the row numbers restart for each partition.
3. **Non-Duplicating**: Unlike `RANK()` or `DENSE_RANK()`, `ROW_NUMBER()` does not handle ties differently—it assigns a distinct number to each row, even for identical values in the `ORDER BY`.

---

### Example Scenarios

#### 1. Assign Row Numbers to All Rows

```sql
SELECT 
    EmployeeID, 
    Name, 
    ROW_NUMBER() OVER (ORDER BY EmployeeID) AS RowNumber
FROM Employees;
```

- This assigns a unique row number to all employees, ordered by their `EmployeeID`.

---

#### 2. Assign Row Numbers by Group (Partitioned)

```sql
SELECT 
    DepartmentID, 
    EmployeeID, 
    Name, 
    ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNumber
FROM Employees;
```

- Row numbers are assigned **per department**, ordered by descending salary. Row numbering resets for each department.

---

#### 3. Fetch the Top-N Rows per Group

Use `ROW_NUMBER()` with a **common table expression (CTE)** to filter rows based on the generated row numbers.

```sql
WITH RankedEmployees AS (
    SELECT 
        DepartmentID, 
        EmployeeID, 
        Name, 
        ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNumber
    FROM Employees
)
SELECT 
    DepartmentID, 
    EmployeeID, 
    Name, 
    RowNumber
FROM RankedEmployees
WHERE RowNumber = 1;
```

- Retrieves the highest-paid employee (`RowNumber = 1`) from each department.

---

#### 4. Paginate Results

You can use `ROW_NUMBER()` for pagination in applications.

```sql
WITH NumberedRows AS (
    SELECT 
        EmployeeID, 
        Name, 
        ROW_NUMBER() OVER (ORDER BY EmployeeID) AS RowNumber
    FROM Employees
)
SELECT 
    EmployeeID, 
    Name
FROM NumberedRows
WHERE RowNumber BETWEEN 11 AND 20;
```

- This fetches rows **11 to 20**, enabling pagination.

---

### Comparison to Other Ranking Functions

|Function|Handles Ties|Restarts for Partitions|Use Case|
|---|---|---|---|
|**ROW_NUMBER()**|No|Yes|Assign unique row numbers to rows.|
|**RANK()**|Yes|Yes|Ranks rows; ties get the same rank; gaps occur.|
|**DENSE_RANK()**|Yes|Yes|Ranks rows; ties get the same rank; no gaps.|

---

2- RANK() and DENSE_RANK()

### **`RANK()` and `DENSE_RANK()`**

Both `RANK()` and `DENSE_RANK()` are **ranking functions** in SQL, often used with the `OVER` clause. They assign a rank to each row based on the order specified in the query. However, the way they handle ties differs.

---

### **1. `RANK()`**

- Assigns ranks to rows, starting at 1.
- **Handles Ties**: Rows with the same value (based on `ORDER BY`) get the same rank, but the next rank **skips numbers** to account for the tie.

#### Syntax:

```sql
RANK() OVER ([PARTITION BY column_name] [ORDER BY column_name])
```

#### Example:

```sql
SELECT 
    EmployeeID,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees;
```

#### Output:

|EmployeeID|Salary|Rank|
|---|---|---|
|101|10000|1|
|102|10000|1|
|103|8000|3|
|104|7000|4|

- The two employees with the highest salary (`10000`) both get **rank 1**, but the next rank is **3** (skipping **2**).

---

### **2. `DENSE_RANK()`**

- Assigns ranks to rows, starting at 1.
- **Handles Ties**: Rows with the same value (based on `ORDER BY`) get the same rank, but the next rank **does not skip numbers**.

#### Syntax:

```sql
DENSE_RANK() OVER ([PARTITION BY column_name] [ORDER BY column_name])
```

#### Example:

```sql
SELECT 
    EmployeeID,
    Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;
```

#### Output:

|EmployeeID|Salary|DenseRank|
|---|---|---|
|101|10000|1|
|102|10000|1|
|103|8000|2|
|104|7000|3|

- The two employees with the highest salary (`10000`) both get **rank 1**, and the next rank is **2** (no gap).

---

### **Comparison Between `RANK()` and `DENSE_RANK()`**

|Feature|`RANK()`|`DENSE_RANK()`|
|---|---|---|
|**Ties**|Same rank for ties, skips ranks.|Same rank for ties, no gaps in ranks.|
|**Ranking**|Numbers may have gaps.|Numbers are consecutive.|
|**Use Case**|When gaps in ranking are acceptable or needed.|When consecutive ranks are required.|

---

### **3. Use Cases**

#### a) Find Top N Salaries with Gaps

If gaps in ranks are acceptable:

```sql
SELECT 
    EmployeeID, 
    Salary, 
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees
WHERE Rank <= 3;
```

#### b) Find Top N Salaries Without Gaps

If consecutive ranking is required:

```sql
SELECT 
    EmployeeID, 
    Salary, 
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees
WHERE DenseRank <= 3;
```

---

### **4. With Partitioning**

Both `RANK()` and `DENSE_RANK()` can restart ranks for each group when used with `PARTITION BY`.

```sql
SELECT 
    DepartmentID, 
    EmployeeID, 
    Salary, 
    RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RankByDept,
    DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS DenseRankByDept
FROM Employees;
```

---
The difference between `RANK()` and `DENSE_RANK()` when identifying the **second-highest salary** becomes clear when there are ties in the data. Let’s break it down with an example.

---

### **Sample Data**

|EmployeeID|Salary|
|---|---|
|101|10000|
|102|10000|
|103|8000|
|104|8000|
|105|7000|

---

### **Using `RANK()`**

```sql
SELECT 
    EmployeeID, 
    Salary, 
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees;
```

#### Result:

|EmployeeID|Salary|Rank|
|---|---|---|
|101|10000|1|
|102|10000|1|
|103|8000|3|
|104|8000|3|
|105|7000|5|

- The highest salary (`10000`) is ranked **1** (shared by two employees).
- The second-highest salary (`8000`) is ranked **3**, **skipping rank 2** due to the tie at the top.

To find the **second-highest salary** using `RANK()`:

```sql
SELECT 
    Salary 
FROM (
    SELECT 
        Salary, 
        RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM Employees
) RankedSalaries
WHERE Rank = 3;
```

This query will return `8000` as the second-highest salary.

---

### **Using `DENSE_RANK()`**

```sql
SELECT 
    EmployeeID, 
    Salary, 
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;
```

#### Result:

|EmployeeID|Salary|DenseRank|
|---|---|---|
|101|10000|1|
|102|10000|1|
|103|8000|2|
|104|8000|2|
|105|7000|3|

- The highest salary (`10000`) is ranked **1** (shared by two employees).
- The second-highest salary (`8000`) is ranked **2**, with no gaps in the ranking.

To find the **second-highest salary** using `DENSE_RANK()`:

```sql
SELECT 
    Salary 
FROM (
    SELECT 
        Salary, 
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
    FROM Employees
) DenseRankedSalaries
WHERE DenseRank = 2;
```

This query will also return `8000` as the second-highest salary.

---

### **Key Differences in Output**

|Function|Rank for Second-Highest Salary|Skips Ranks?|
|---|---|---|
|**`RANK()`**|`3`|Yes|
|**`DENSE_RANK()`**|`2`|No|

---

### **Which One to Use?**

- Use **`RANK()`** if you want to keep track of gaps caused by ties (e.g., to reflect how many distinct ranks exist).
- Use **`DENSE_RANK()`** if you want ranks to be consecutive, ignoring gaps caused by ties.

### **Difference Between `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()`**

These are all **ranking/window functions** in SQL, and while they seem similar, they behave differently in how they assign ranks or numbers to rows, especially when there are **ties** (i.e., rows with the same `ORDER BY` value).

---

### **1. ROW_NUMBER()**

- **Behavior**: Assigns a unique, sequential number to each row in the result set.
- **Ties**: Does **not allow ties**; even if two rows have the same value, they get different row numbers based on their order.
- **Gap in Numbers**: No gaps, even when rows have the same value.

#### Example:

```sql
SELECT 
    EmployeeID, 
    Salary, 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber
FROM Employees;
```

|EmployeeID|Salary|RowNumber|
|---|---|---|
|101|10000|1|
|102|10000|2|
|103|8000|3|
|104|8000|4|
|105|7000|5|

---

### **2. RANK()**

- **Behavior**: Assigns the same rank to rows with the same value (ties).
- **Ties**: Rows with the same value receive the same rank.
- **Gap in Numbers**: There are **gaps** in the ranking after ties.

#### Example:

```sql
SELECT 
    EmployeeID, 
    Salary, 
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees;
```

|EmployeeID|Salary|Rank|
|---|---|---|
|101|10000|1|
|102|10000|1|
|103|8000|3|
|104|8000|3|
|105|7000|5|

- Two employees with the highest salary (`10000`) share **rank 1**, and the next rank is **3**, skipping **2**.

---

### **3. DENSE_RANK()**

- **Behavior**: Similar to `RANK()` but does **not leave gaps** in the ranking after ties.
- **Ties**: Rows with the same value receive the same rank.
- **Gap in Numbers**: No gaps; ranks are **dense**.

#### Example:

```sql
SELECT 
    EmployeeID, 
    Salary, 
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;
```

|EmployeeID|Salary|DenseRank|
|---|---|---|
|101|10000|1|
|102|10000|1|
|103|8000|2|
|104|8000|2|
|105|7000|3|

- Two employees with the highest salary (`10000`) share **rank 1**, and the next rank is **2** (no gaps).

---

### **Key Differences**

|Feature|ROW_NUMBER()|RANK()|DENSE_RANK()|
|---|---|---|---|
|**Ties**|No ties (unique numbers).|Ties share the same rank.|Ties share the same rank.|
|**Gaps in Ranks**|No gaps.|Gaps after ties.|No gaps after ties.|
|**Ranking Style**|Sequential numbering.|Traditional ranking.|Dense ranking.|
|**Use Case**|Assign unique IDs to rows for pagination or deduplication.|When rank order matters, but gaps are okay.|When rank order matters, and gaps are not allowed.|

---

### **Example Use Cases**

#### 1. **ROW_NUMBER()**

- Used for **pagination** or deduplication:
    
    ```sql
    WITH RankedRows AS (
        SELECT 
            EmployeeID, 
            ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RowNum
        FROM Employees
    )
    SELECT * 
    FROM RankedRows
    WHERE RowNum = 1;
    ```
    
    - Finds the **top salary** in each department.

---

#### 2. **RANK()**

- Used to rank rows when **gaps in ranking are okay**:
    
    ```sql
    SELECT 
        EmployeeID, 
        Salary, 
        RANK() OVER (ORDER BY Salary DESC) AS Rank
    FROM Employees;
    ```
    
    - Identifies the rank of employees while keeping gaps after ties.

---

#### 3. **DENSE_RANK()**

- Used to rank rows when **gaps in ranking are not acceptable**:
    
    ```sql
    SELECT 
        EmployeeID, 
        Salary, 
        DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
    FROM Employees;
    ```
    
    - Ensures ranking is consecutive even with ties.

---

If there are **no duplicate rows** in the dataset (i.e., all rows have unique values in the column(s) being ranked by), then **`ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()` will all produce the same results**.

This is because, in the absence of ties, every row is assigned a distinct number, and there are no gaps or shared ranks.

---

### **Example**

Let’s assume the dataset has no duplicate salaries:

|EmployeeID|Salary|
|---|---|
|101|10000|
|102|9000|
|103|8000|
|104|7000|
|105|6000|

---

#### **Using `ROW_NUMBER()`**

```sql
SELECT 
    EmployeeID, 
    Salary, 
    ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber
FROM Employees;
```

|EmployeeID|Salary|RowNumber|
|---|---|---|
|101|10000|1|
|102|9000|2|
|103|8000|3|
|104|7000|4|
|105|6000|5|

---

#### **Using `RANK()`**

```sql
SELECT 
    EmployeeID, 
    Salary, 
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees;
```

|EmployeeID|Salary|Rank|
|---|---|---|
|101|10000|1|
|102|9000|2|
|103|8000|3|
|104|7000|4|
|105|6000|5|

---

#### **Using `DENSE_RANK()`**

```sql
SELECT 
    EmployeeID, 
    Salary, 
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employees;
```

|EmployeeID|Salary|DenseRank|
|---|---|---|
|101|10000|1|
|102|9000|2|
|103|8000|3|
|104|7000|4|
|105|6000|5|

---

### **Key Observations**

- **`ROW_NUMBER()`**: Simply assigns sequential numbers. No effect of duplicates since there aren’t any.
- **`RANK()`**: Works just like `ROW_NUMBER()` when there are no ties, as there are no skipped ranks.
- **`DENSE_RANK()`**: Also works just like `ROW_NUMBER()` because ranks remain consecutive in the absence of ties.

---

### **Key Difference Emerges When Duplicates Exist**

When duplicates exist, the differences between these functions become apparent:

- **`ROW_NUMBER()`**: Never assigns the same number to two rows.
- **`RANK()`**: Assigns the same rank to tied rows, but skips numbers after ties.
- **`DENSE_RANK()`**: Assigns the same rank to tied rows but keeps ranks consecutive.
