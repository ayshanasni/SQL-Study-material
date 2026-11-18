USE assignment;
SELECT * FROM Employee1;
#1. Display all employees sorted by Salary from highest to lowest.
SELECT * FROM
Employee1
ORDER BY Salary DESC,Name;

#2. Display all employees sorted by Department (A to Z), then by Salary (highest first) within each department.
SELECT * FROM
Employee1
ORDER BY Department ASC,Salary DESC;

#3. Display only the top 3 highest-paid employees.
SELECT * FROM
Employee1
ORDER BY Salary DESC
LIMIT 3;

#4. Display the 2 lowest-paid employees.
SELECT * FROM
Employee1
ORDER BY Salary ASC
LIMIT 2;

#5. Find the total number of employees.
SELECT COUNT(*) AS TotalEmployee
FROM Employee1;

#6. Find the total, average, minimum and maximum salary. Use aliases for each column.
#Total Salary
SELECT SUM(Salary) AS SumOfSalary
FROM Employee1;

#Average Salary
SELECT AVG(Salary) AS AverageSalary
FROM Employee1;

#minimum salary
SELECT MIN(Salary) AS MinimumSalary
FROM Employee1;

#maximum salary
SELECT MAX(Salary) AS MaximumSalary
FROM Employee1;

-- 7. Show the number of employees in each department.
SELECT Department,
COUNT(*) AS EmployeeCount
FROM Employee1
GROUP  BY Department;

-- 8. Show the total salary paid in each department.
SELECT Department,
SUM(Salary) AS TotalSalary
FROM Employee1
GROUP BY Department;

-- 9. Show the average salary of each department, but only for departments with an average
--    above 55000.
SELECT Department,
AVG(Salary) AS AverageSalary
FROM Employee1
GROUP BY department
HAVING AVG(Salary)>55000;

-- 10. Show departments that have more than 3 employees.
SELECT Department,
COUNT(*) AS EmployeeCount
FROM Employee1
GROUP BY Department
HAVING COUNT(*) > 3;

-- 11. Write one query that uses both WHERE and HAVING. First filter out employees earning
-- below 48000, then show only departments whose total salary is above 100000.
SELECT Department,
SUM(Salary) AS TotalSalary
FROM Employee1
WHERE Salary>=48000
GROUP BY department
HAVING SUM(Salary)>100000;

-- 12. Add a column RowNum that numbers the employees from highest to lowest salary using
--     ROW_NUMBER().
SELECT Name,
Salary,
ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RowNum
FROM Employee1;

-- 13. Rank employees by salary (highest first) using RANK() and DENSE_RANK() in the same
-- query. Compare the two columns for the tied salaries.
SELECT Name,
Salary,
RANK() OVER(ORDER BY Salary DESC) AS RankOfSalary , DENSE_RANK() OVER(ORDER BY Salary DESC) AS DenseRank
FROM Employee1;

-- 14. Rank employees within each department by salary using PARTITION BY. Then show only
-- the top-paid employee in each department (hint: use a subquery or CTE).
SELECT Name,
Department,
Salary,
RANK() OVER(PARTITION BY Department ORDER BY
Salary DESC) AS DeptRank
FROM Employee1;

-- 15. Display each employee&#39;s salary along with the previous salary (LAG) and the next salary
-- (LEAD), ordered by salary. Add a column showing the difference between the current and
-- previous salary.
SELECT Name,Salary,LEAD(Salary) OVER(ORDER BY Salary) AS NextSalary,
LAG(Salary) OVER(ORDER BY Salary) AS Previous_Salary,
Salary-LAG(Salary) OVER(ORDER BY Salary) AS Salary_Difference
FROM Employee;

-- 16. What is the difference between WHERE and HAVING?
-- WHERE: Filters individual rows before grouping.
-- HAVING: Filters groups after GROUP BY.
-- 17. What is the difference between GROUP BY and a window function?
-- GROUP BY: Combines rows into groups and returns one result per group.
-- Window Function: Performs calculations without combining or removing individual rows.
-- 18. Why does RANK() skip numbers while DENSE_RANK() does not?
-- RANK(): Skips the next rank when there is a tie.
-- DENSE_RANK(): Does not skip ranks after a tie.
-- 19. What does PARTITION BY do inside OVER()?
-- Divides rows into separate groups and performs calculations within each group without combining the rows.



