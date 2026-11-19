DROP DATABASE IF EXISTS sales_db;
CREATE DATABASE sales_db;
USE sales_db;
-- ---------- Table 1: Customer ----------
CREATE TABLE Customer (
CustID INT PRIMARY KEY,
Name VARCHAR(50),
Email VARCHAR(80),
City VARCHAR(50),
Age INT,
JoinDate DATE,
ReferredBy INT NULL -- CustID of the customer who referred this person
);
INSERT INTO Customer VALUES
(1, 'Rahul Menon', 'rahul.menon@shopzone.com', 'Kochi', 34, '2021-02-14', NULL),
(2, 'Sneha Iyer', 'sneha.iyer@shopzone.com', 'Chennai', 28, '2021-06-10', 1),
(3, 'Arjun Nair', 'arjun.nair@shopzone.com', 'Kochi', 41, '2022-01-05', 1),
(4, 'Priya Das', 'priya.das@shopzone.com', 'Bengaluru', 25, '2022-08-19', 2),
(5, 'Kiran Rao', 'kiran.rao@shopzone.com', 'Hyderabad', 37, '2022-11-30', 3),
(6, 'Fathima Beevi', 'fathima.beevi@shopzone.com', 'Kochi', 30, '2023-03-12', 2),
(7, 'Vishnu Raj', 'vishnu.raj@shopzone.com', 'Chennai', 45, '2023-07-25', 4),
(8, 'Ananya Pillai', 'ananya.pillai@shopzone.com', 'Bengaluru', 23, '2024-01-18', 6),
(9, 'Mohit Jain', 'mohit.jain@shopzone.com', 'Mumbai', 39, '2024-05-09', 5), -- no orders
(10, 'Zoya Khan', 'zoya.khan@shopzone.com', 'Hyderabad', 31, '2024-09-21', 8); -- no orders
-- ---------- Table 2: Product ----------
CREATE TABLE Product (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(30),
UnitPrice DECIMAL(10,2)
);
INSERT INTO Product VALUES
(1, 'Laptop', 'Electronics', 55000.00),
(2, 'Smartphone', 'Electronics', 28000.50),
(3, 'Headphones', 'Accessories', 2499.99),
(4, 'Office Chair', 'Furniture', 7200.00),
(5, 'Study Table', 'Furniture', 6400.75),
(6, 'Smart Watch', 'Electronics', 9999.00); -- never sold
-- ---------- Table 3: Orders ----------
CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustID INT NULL, -- NULL = guest checkout (no customer account)
ProductID INT,
Quantity INT,
OrderDate DATE,
DiscountPct INT
);
INSERT INTO Orders VALUES
(5001, 1, 1, 1, '2024-01-15', 5),
(5002, 2, 2, 2, '2024-02-10', 10),
(5003, 3, 3, 3, '2024-03-05', 0),
(5004, 1, 3, 1, '2024-03-22', 0),
(5005, 4, 4, 1, '2024-06-18', 15),
(5006, 5, 2, 1, '2024-06-30', 5),
(5007, 6, 5, 2, '2024-07-14', 10),
(5008, 7, 1, 1, '2024-08-02', 0),
(5009, 2, 3, 4, '2024-11-11', 20),
(5010, NULL, 2, 1, '2025-01-09', 0), -- guest order
(5011, 3, 4, 2, '2025-02-14', 10),
(5012, NULL, 3, 2, '2025-03-03', 5), -- guest order
(5013, 8, 5, 1, '2025-06-21', 0),

(5014, 4, 1, 1, '2025-06-28', 10);
-- ---------- Table 4: Discount_Slab ----------
CREATE TABLE Discount_Slab (
SlabID INT PRIMARY KEY,
SlabName VARCHAR(30),
DiscountPct INT
);
INSERT INTO Discount_Slab VALUES
(1, 'Member', 5),
(2, 'Festive', 10),
(3, 'Clearance', 25);
-- ---------- Table 5: Online_Sales ----------
CREATE TABLE Online_Sales (
SaleID INT PRIMARY KEY,
ProductName VARCHAR(50),
City VARCHAR(50),
Amount DECIMAL(10,2)
);
INSERT INTO Online_Sales VALUES
(1, 'Laptop', 'Kochi', 52250.00),
(2, 'Headphones', 'Chennai', 2499.99),
(3, 'Smartphone', 'Bengaluru', 28000.50),
(4, 'Study Table', 'Kochi', 6400.75);
-- ---------- Table 6: Store_Sales ----------
CREATE TABLE Store_Sales (
SaleID INT PRIMARY KEY,
ProductName VARCHAR(50),
City VARCHAR(50),
Amount DECIMAL(10,2)
);
INSERT INTO Store_Sales VALUES
(5, 'Laptop', 'Kochi', 52250.00), -- same as Online_Sales row (ProductName + City +Amount)
(6, 'Office Chair', 'Chennai', 7200.00),
(7, 'Smartphone', 'Bengaluru', 28000.50), -- same as Online_Sales row (ProductName + City +Amount)
(8, 'Headphones', 'Mumbai', 2499.99);
-- Check the data
SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Discount_Slab;
SELECT * FROM Online_Sales;
SELECT * FROM Store_Sales;

#SELF JOIN
SELECT c.Name AS Custname , R.Name AS REFFERAL_ID
FROM Customer c
INNER JOIN Customer R
ON c.ReferredBy=R.custid;

#Stored Procedure for storing the data
DELIMITER //

CREATE PROCEDURE GetCustomerData1()
BEGIN 
     SELECT * FROM Customer
     WHERE City='Kochi' AND Age > 18;
END //

DELIMITER ;

CALL GetCustomerData1();

#VIEWS(virtual table  creating using exixting table data)
CREATE VIEW Electronics_Product AS
SELECT ProductID, ProductName
FROM Product
WHERE Category='Electronics';

SELECT * FROM Electronics_Product; #here the electronic products is only choosing using view table

# if we want to choose a specific data only
SELECT * FROM Electronics_Product #IT IS JUST LIKE A NORMAL TABLE ONLY
WHERE ProductID=2;


-- Q1. Display OrderID, Customer Name and OrderDate for all orders placed by registered customers.
SELECT o.OrderID ,
o.OrderDate,
c.Name
FROM Orders o
INNER JOIN Customer c
ON o.CustID=c.CustID;

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Discount_Slab;
SELECT * FROM Online_Sales;
SELECT * FROM Store_Sales;

-- Q2. Display Customer Name, ProductName and Quantity for every order. (Join Customer, Orders and Product)
SELECT c.Name,
p.ProductName,
o.Quantity
FROM Customer c
INNER JOIN Orders o
ON c.CustID=o.CustID
INNER JOIN Product p 
ON O.ProductID=P.ProductID;

-- Q3. Display orders of the Electronics category along with the Customer Name and City.
SELECT c.Name,
c.City,
p.Category 
FROM Customer c
INNER JOIN Orders o
ON c.CustId=o.CustID
INNER JOIN Product p
ON p.ProductID=o.ProductID
WHERE p.Category='Electronics';

#COMPLEX VIEW
CREATE VIEW  CustDetail_Customer AS
SELECT c.Name,
o.OrderID
FROM Customer c 
JOIN Orders o
ON c.CustID=o.CustId;

SELECT * FROM CustDetail_Customer;

CREATE VIEW Prod_det AS
SELECT p.ProductName,
o.Quantity
FROM Product p
JOIN Orders o
ON p.ProductID=o.ProductID;

SELECT * FROM Prod_det;


-- Q4. Display the Customer Name and total amount spent on each order (Quantity x UnitPrice) for orders
-- where the amount is greater than 50000.
SELECT c.Name,
(o.Quantity * p.UnitPrice) AS TotalAmount
FROM Customer c
INNER JOIN Orders o
ON c.CustID=o.CustID
INNER JOIN Product p
ON o.ProductID=P.ProductID
WHERE (o.Quantity * p.UnitPrice) > 50000;

-- Q5. Display all customers with their OrderID. Customers who never ordered should show NULL.
SELECT o.OrderID,
c.Name
FROM Customer c
LEFT JOIN Orders o
ON o.CustID=c.CustID;

-- Q6. Find the customers who have NEVER placed an order (use LEFT JOIN + IS NULL).
SELECT o.OrderID,
c.Name
FROM Customer c
LEFT JOIN Orders o
ON o.CustID=c.CustID
WHERE o.OrderID IS NULL;

-- Q7. Display all customers with the number of orders they have placed (0 for customers with no orders).
SELECT 
c.Name,
COUNT(o.OrderID) AS NumberOfOrders
FROM Customer c
LEFT JOIN Orders o
ON c.CustID = o.CustID
GROUP BY c.CustID, c.Name;

-- Q8. Display all customers with OrderID. Show &#39;No Order&#39; instead of NULL. (Hint: IFNULL / COALESCE)
SELECT 
c.Name,
IFNULL(o.OrderID, 'No Order') AS OrderID
FROM Customer c
LEFT JOIN Orders o
ON c.CustID = o.CustID;

-- Q9. Display all products with the OrderID in which they were sold. Products that were never sold must also appear.
SELECT 
p.ProductName,
o.OrderID
FROM Orders o
RIGHT JOIN Product p
ON o.ProductID = p.ProductID;

-- Q10. Find the products that have never been sold (use RIGHT JOIN + IS NULL).
SELECT 
p.ProductName,
o.OrderID
FROM Orders o
RIGHT JOIN Product p
ON o.ProductID = p.ProductID
WHERE o.OrderID IS NULL;

-- Q11. Display each ProductName with the total quantity sold, including products with 0 sales.
SELECT
p.ProductName,
IFNULL(SUM(o.Quantity), 0) AS TotalQuantitySold
FROM Product p
LEFT JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ProductName;

#FULL JOIN
SELECT o.OrderID,
c.Name
FROM Customer c
LEFT JOIN Orders o
ON o.CustID=c.CustID

UNION

SELECT 
p.ProductName,
o.OrderID
FROM Orders o
RIGHT JOIN Product p
ON o.ProductID = p.ProductID;

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Discount_Slab;
SELECT * FROM Online_Sales;
SELECT * FROM Store_Sales;


-- Q12. Display all customers and all orders, whether or not they have a match.
SELECT c.Name,
o.OrderID
FROM Customer c
RIGHT JOIN Orders o
ON c.CustID=o.CustID

UNION

SELECT c.Name,
o.OrderID
FROM Customer c
LEFT JOIN Orders o
ON c.CustID=o.CustID;

-- Q13. From the FULL JOIN result, show only the rows that have NO match on either side (customers without orders and orders without customers).
SELECT c.Name,
o.OrderID
FROM Customer c
LEFT JOIN Orders o
ON o.CustID=c.CustID
WHERE c.CustID IS NULL

UNION

SELECT c.Name,
o.OrderID
FROM Customer c
LEFT JOIN Orders o
ON o.CustID=c.CustID
WHERE o.OrderID IS NULL;

SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Discount_Slab;
SELECT * FROM Online_Sales;
SELECT * FROM Store_Sales;

#UNION Topic
-- Q21. Display ProductName, City and Amount of all online and store sales without duplicates (UNION).
SELECT ProductName, City, Amount
FROM Online_Sales

UNION

SELECT ProductName, City, Amount
FROM Store_Sales;

-- Q22. Display ProductName, City and Amount of all online and store sales keeping duplicates (UNION ALL).
SELECT ProductName, City, Amount
FROM Online_Sales

UNION ALL

SELECT ProductName, City, Amount
FROM Store_Sales;

-- Q23. Compare the row counts of Q21 and Q22. Why are they different?
SELECT COUNT(*) AS TotalRows
FROM (
    SELECT ProductName, City, Amount
    FROM Online_Sales

    UNION

    SELECT ProductName, City, Amount
    FROM Store_Sales
) AS A;

SELECT COUNT(*) AS TotalRows
FROM (
    SELECT ProductName, City, Amount
    FROM Online_Sales

    UNION ALL

    SELECT ProductName, City, Amount
    FROM Store_Sales
) AS B;


-- Q24. Add an extra column &#39;Channel&#39; with values &#39;Online&#39; / &#39;Store&#39; to the UNION ALL result.
SELECT
    ProductName,
    City,
    Amount,
    'Online' AS Channel
FROM Online_Sales

UNION ALL

SELECT
    ProductName,
    City,
    Amount,
    'Store' AS Channel
FROM Store_Sales;

-- Q25. Find the total sales Amount of all channels combined. (Hint: UNION ALL inside a subquery)
SELECT SUM(Amount) AS TotalSales
FROM
(SELECT Amount
FROM Online_Sales

UNION ALL

SELECT Amount
FROM Store_Sales
) AS Channel;

-- Q26. Show the list of distinct cities where sales happened (online + store) in alphabetical order.
SELECT City
FROM Online_Sales

UNION

SELECT City
FROM Store_Sales

ORDER BY City ASC;

-- Q27. Display ProductName and UnitPrice rounded to 0 decimal places. (ROUND)
SELECT ProductName,
ROUND(UnitPrice,0)
FROM Product;

-- Q28. Display ProductName and UnitPrice rounded UP and DOWN to the nearest integer. (CEIL, FLOOR)
SELECT productName,
CEIL(UnitPrice),
FLOOR(UnitPrice)
FROM Product;

-- Q29. Calculate the final amount of each order: Quantity x UnitPrice - discount, rounded to 2 decimals.
SELECT o.OrderID,
ROUND((o.Quantity * p.UnitPrice) - o.DiscountPct, 2) AS FinalAmount
FROM Orders o
INNER JOIN Product p
ON o.ProductID = p.ProductID;


SELECT * FROM Customer;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM Discount_Slab;
SELECT * FROM Online_Sales;
SELECT * FROM Store_Sales;



-- Q30. Calculate the GST amount (18%) on every product&#39;s UnitPrice, rounded to 2 decimals.
SELECT ROUND(UnitPrice*18/100,2) AS GstAmount
FROM Product;

-- Q31. Display Customer Name and the absolute difference between the customer&#39;s Age and 35. (ABS)
SELECT Name,
ABS(Age-35) AS AgeDifference
FROM Customer;

-- Q32. Display Quantity and the square of Quantity for every order using POWER().
SELECT Quantity,
POWER(Quantity,2) AS SquareQuantity
FROM Orders;

-- Q33. Display the average UnitPrice of all products rounded to 2 decimals.
SELECT ROUND(AVG(UnitPrice),2) AS Average
FROM Product;

-- Q34. Display Customer Name in UPPERCASE and City in lowercase.
SELECT UPPER(Name),
LOWER(City)
FROM Customer;

-- Q35. Display Customer Name and the number of characters in the Name. (LENGTH)
SELECT Name,LENGTH(Name) AS CharNumber
FROM Customer;

-- Q36. Display the customer with the longest name.
SELECT Name,
LENGTH(Name) AS NameLength
FROM Customer
ORDER BY LENGTH(Name) DESC
LIMIT 1;

-- Q37. Combine Name and City into one column in the format: Rahul Menon - Kochi (CONCAT)
SELECT CONCAT(Name,' - ',City)
FROM Customer;

-- Q38. Display the first 3 characters of each ProductName. (SUBSTRING / LEFT)
SELECT SUBSTRING(ProductName,1,3)
FROM Product;

-- Q39. Extract the username part of the customer Email (the text before &#39;@&#39;). (Hint: SUBSTRING_INDEX)
SELECT Email,
       SUBSTRING_INDEX(Email, '@', 1) AS Username
FROM Customer;

-- Q40. Display customers whose Email ends with 'shopzone.com' and whose Name starts with 'A' or 'P'.
SELECT Name, Email
FROM Customer
WHERE Email LIKE '%shopzone.com'
AND (Name LIKE 'A%' OR Name LIKE 'P%');

-- Q41. Display today's date, current time and current timestamp in one query.
SELECT CURDATE() AS TodayDate,
       CURTIME() AS CurrentTime,
       NOW() AS CurrentTimestamp;
       
-- Q42. Display OrderID, OrderDate, YEAR, MONTH and DAY separately.
SELECT OrderID,
       OrderDate,
       YEAR(OrderDate) AS OrderYear,
       MONTH(OrderDate) AS OrderMonth,
       DAY(OrderDate) AS OrderDay
FROM Orders;

-- Q43. Display all orders placed in the year 2024.
SELECT *
FROM Orders
WHERE YEAR(OrderDate) = 2024;

-- Q44. Display all orders placed in the month of June.
SELECT *
FROM Orders
WHERE MONTH(OrderDate) = 6;

-- Q45. Count how many orders were placed in each year.
SELECT YEAR(OrderDate) AS OrderYear,
       COUNT(*) AS TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate);

-- Q46. Display Customer Name and number of years since the customer joined.
SELECT Name,
       YEAR(CURDATE()) - YEAR(JoinDate) AS YearsSinceJoined
FROM Customer;

-- Q47. Display OrderID, Customer Name in UPPERCASE, ProductName, final amount and Order Year for all registered-customer orders, sorted by final amount in descending order.
SELECT o.OrderID,
       UPPER(c.Name) AS CustomerName,
       p.ProductName,
       ROUND(
           o.Quantity * p.UnitPrice * (1 - o.DiscountPct / 100),
           2
       ) AS FinalAmount,
       YEAR(o.OrderDate) AS OrderYear
FROM Orders o
INNER JOIN Customer c
ON o.CustID = c.CustID
INNER JOIN Product p
ON o.ProductID = p.ProductID
ORDER BY FinalAmount DESC;

-- Q48. Display each Category with total sales revenue (Quantity × UnitPrice) rounded to 2 decimals.
SELECT p.Category,
       ROUND(SUM(o.Quantity * p.UnitPrice), 2) AS TotalRevenue
FROM Product p
INNER JOIN Orders o
ON p.ProductID = o.ProductID
GROUP BY p.Category;

-- Q49. Display each customer City with the total number of orders placed from that city, highest first.
SELECT c.City,
       COUNT(o.OrderID) AS TotalOrders
FROM Customer c
LEFT JOIN Orders o
ON c.CustID = o.CustID
GROUP BY c.City
ORDER BY TotalOrders DESC;

-- Q50. Write the difference between JOIN and UNION with one example query for each. Difference:
#JOIN-Combines columns from two or more tables.
-- Uses a related column to connect tables.

#UNION-Combines rows from two or more SELECT queries.
-- Each SELECT must have the same number of columns and compatible data types.

-- JOIN Example
SELECT c.Name, o.OrderID
FROM Customer c
INNER JOIN Orders o
ON c.CustID = o.CustID;
-- UNION Example 
SELECT ProductName, City
FROM Online_Sales

UNION

SELECT ProductName, City
FROM Store_Sales;

-- Q51. Why is UNION ALL faster than UNION? When would you choose UNION instead?
- -- UNION ALL is faster because it does not check for or remove duplicate rows.
-- - UNION removes duplicate rows, so it needs additional processing.
-- - Use UNION when you want only unique records.
-- - Use UNION ALL when you want to keep all records, including duplicates.
