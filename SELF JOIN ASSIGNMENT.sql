USE assignment;
CREATE TABLE Employee_Table( EmpID INT , Name VARCHAR(50) , 
Salary INT , ManagerID INT);
SELECT * FROM Employee_Table;

INSERT INTO Employee_Table
VALUES
(1,'Arun',90000,NULL),
(2,'Meera',60000,1),
(3,'Rahul',50000,1),
(4,'Anu',65000,2),
(5,'John',40000,2);
 
-- Q1. Write a query to show each employee's name along with their manager's name. 
SELECT e.Name AS EmployeeName,
       m.Name AS ManagerName
FROM Employee_Table e
JOIN Employee_Table m
ON e.ManagerID = m.EmpID;

-- Q2Write a query to show all employees, including the ones who have no manager. For them, the manager's name should show as NULL.
SELECT e.Name AS EmployeeName,
       m.Name AS ManagerName
FROM Employee_Table e
LEFT JOIN Employee_Table m
ON e.ManagerID = m.EmpID;

-- Q3. Write a query to find the employees who earn more than their manager.
SELECT e.Name AS EmployeeName,
       e.Salary AS EmployeeSalary,
       m.Name AS ManagerName,
       m.Salary AS ManagerSalary
FROM Employee_Table e
INNER JOIN Employee_Table m
ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;