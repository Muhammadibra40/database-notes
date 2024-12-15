
The **`OVER`** clause in SQL is used in conjunction with window functions to define a "window" or subset of rows for a query. It allows you to perform calculations across a specific range of rows related to the current row, without collapsing the result into a single row as aggregate functions normally do. This is particularly useful for analytical tasks.

### Common Use Cases

The **`OVER`** clause is used with functions like:

- **Aggregate functions** (e.g., `SUM`, `AVG`, `COUNT`, `MAX`, `MIN`)
- **Ranking functions** (e.g., `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `NTILE`)
- **Window functions** (e.g., `LAG`, `LEAD`, `FIRST_VALUE`, `LAST_VALUE`)

---

### Syntax

```sql
function() OVER ([PARTITION BY column_name] [ORDER BY column_name])
```

- **PARTITION BY**: Divides the result set into partitions (like a `GROUP BY`, but for the window function).
- **ORDER BY**: Defines the order of rows within each partition.
- If no **PARTITION BY** is specified, the function operates on the entire result set as one partition.

---

### Examples

#### 1. **Running Total**

```sql
SELECT
    EmployeeID,
    Salary,
    SUM(Salary) OVER (ORDER BY EmployeeID) AS RunningTotal
FROM Employees;
```

- Calculates a cumulative sum of salaries in the order of `EmployeeID`.

---

#### 2. **Ranking**

```sql
SELECT
    EmployeeID,
    Salary,
    RANK() OVER (ORDER BY Salary DESC) AS Rank
FROM Employees;
```

- Assigns a rank based on descending salary.

---

#### 3. **Partitioning**

```sql
SELECT
    DepartmentID,
    EmployeeID,
    Salary,
    AVG(Salary) OVER (PARTITION BY DepartmentID) AS AvgSalaryByDept
FROM Employees;
```

- Computes the average salary **within each department**.

---

#### 4. **Lag and Lead**

```sql
SELECT
    EmployeeID,
    Salary,
    LAG(Salary) OVER (ORDER BY EmployeeID) AS PreviousSalary,
    LEAD(Salary) OVER (ORDER BY EmployeeID) AS NextSalary
FROM Employees;
```

- **LAG**: Fetches the salary from the previous row.
- **LEAD**: Fetches the salary from the next row.

---

### Key Points

1. **Doesn’t Collapse Rows**: Unlike aggregate functions, window functions retain the original number of rows.
2. **Flexible Calculation**: Can work across entire datasets or specific partitions of data.
3. **Combination**: Can be used with `GROUP BY`, but the window function itself does not require it.
