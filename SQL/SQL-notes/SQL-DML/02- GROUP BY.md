always used with aggregate functions.

EX:
-----
```
-- gives the sum of salary for each city
SELECT city, SUM(salary) 
FROM tblEmployee
GROUP BY city;

-- if the GROUP BY cluase was removed, will give an error
SELECT city, SUM(salary) 
FROM tblEmployee;
-- the city in this situation must be in a aggregate function which in this case can't be applied or adding the GROUP BY cluase.

-- we can group by more than one column, we can switch here city and gender and will give us the same columns
SELECT city, gender, SUM(salary) 
FROM tblEmployee
GROUP BY city, gender;
```

--> HAVING vs. WHERE with GROUP BY:

```
-- using WHERE clause: only the male records are retreived from the table then they are grouped
-- the records are filtered before even the aggreagtion is done
SELECT city, gender, SUM(salary) 
FROM tblEmployee
WHERE gender = 'male'
GROUP BY city, gender;

-- using HAVING clause: all the records are retreived from the table then they are grouped by gender and only male groups are shown filtering female groups.
-- aggregation is done for every row in this table
SELECT city, gender, SUM(salary) 
FROM tblEmployee
GROUP BY city, gender
HAVING gender = 'male';
```
from the performance perspective: no method is better than the other or more efficient but as best practice generally it's better to eliminate the rows that are not needed as early as possible using the WHERE clause. 

 -  HAVING clause: can be used only with SELECT statement /  WHERE clause can be used with other than SELECT like  INSERT or UPDATE 
 -  Aggregate functions can't be used with WHERE clause, unless it's in a sub query contained in a HAVING clause but for sure aggregate functions can be used with HAVING clause
```
-- gives an error
SELECT * FROM tblEmployee WHERE SUM(salary) > 4000 
```