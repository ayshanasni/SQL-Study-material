 -- Sales dataset for Views, Triggers and Indexes practice
-- Running this script again resets everything (tables, views, triggers, logs).
DROP DATABASE IF EXISTS sales_db;
CREATE DATABASE sales_db;
USE sales_db;

CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category    VARCHAR(30),
    Price       INT
);

CREATE TABLE Sales (
    SaleID       INT PRIMARY KEY,
    SaleDate     DATE,
    CustomerName VARCHAR(50),
    City         VARCHAR(30),
    ProductID    INT,
    Quantity     INT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
    (1, 'Laptop', 'Electronics', 55000),
    (2, 'Smartphone', 'Electronics', 18000),
    (3, 'Tablet', 'Electronics', 22000),
    (4, 'Headphones', 'Accessories', 1500),
    (5, 'Keyboard', 'Accessories', 800),
    (6, 'Mouse', 'Accessories', 500),
    (7, 'Notebook', 'Stationery', 60),
    (8, 'Pen Pack', 'Stationery', 120);

INSERT INTO Sales (SaleID, SaleDate, CustomerName, City, ProductID, Quantity) VALUES
    (1, '2026-10-01', 'Arjun Nair', 'Kochi', 2, 1),
    (2, '2026-10-01', 'Sneha Menon', 'Thrissur', 4, 2),
    (3, '2026-10-02', 'Rahul Varma', 'Kozhikode', 1, 1),
    (4, '2026-10-03', 'Fathima Noor', 'Kannur', 5, 1),
    (5, '2026-10-04', 'Divya Raj', 'Kochi', 7, 10),
    (6, '2026-10-05', 'Mohammed Ashraf', 'Kozhikode', 6, 3),
    (7, '2026-10-07', 'Anjali Krishnan', 'Thrissur', 3, 1),
    (8, '2026-10-08', 'Suresh Kumar', 'Kochi', 8, 5),
    (9, '2026-10-10', 'Remya Thomas', 'Kannur', 4, 1),
    (10, '2026-10-12', 'Nikhil George', 'Kochi', 2, 2),
    (11, '2026-10-15', 'Aisha Beegum', 'Kozhikode', 7, 20),
    (12, '2026-10-18', 'Joseph Mathew', 'Thrissur', 5, 2),
    (13, '2026-10-20', 'Meera Nambiar', 'Kochi', 1, 1),
    (14, '2026-10-22', 'Hari Krishnan', 'Kannur', 6, 4),
    (15, '2026-10-25', 'Neha Sharma', 'Kozhikode', 2, 1),
    (16, '2026-10-28', 'Adil Rahman', 'Kochi', 8, 3),
    (17, '2026-11-02', 'Priya Das', 'Thrissur', 4, 3),
    (18, '2026-11-05', 'Kiran Babu', 'Kochi', 3, 1),
    (19, '2026-11-08', 'Arjun Nair', 'Kochi', 6, 2),
    (20, '2026-11-10', 'Sneha Menon', 'Thrissur', 2, 1);

SELECT * FROM Products;
SELECT * FROM Sales;

-- Q1. Create a view named Electronics_Products that shows ProductID, 
-- ProductName and Price of all products in the 'Electronics' category. Then display all rows from the view.
CREATE VIEW detail_prod AS
SELECT ProductID, ProductName, Price
FROM Products
WHERE Category='Electronics';

SELECT * FROM detail_prod;

-- Q2. Create a view named Kochi_Sales that shows SaleID, CustomerName, ProductID and
--  Quantity for all sales made in the city 'Kochi'. Then display the view.
CREATE VIEW kochi_sales AS
SELECT SaleID , CustomerName , ProductID , Quantity
FROM Sales 
WHERE City='Kochi';

SELECT * FROM kochi_sales;

-- Q3. Create a view named Bulk_Sales that shows SaleID, CustomerName, City and Quantity 
-- for sales where the Quantity is 3 or more. Then display the view.
CREATE VIEW Bulk_Sales AS
SELECT SaleID, CustomerName,City ,Quantity
FROM Sales
WHERE Quantity >= 3;

SELECT * FROM Bulk_Sales;

-- Q4. Use the view Electronics_Products to display only the products whose Price is greater than 20000.
SELECT ProductName,Price
FROM detail_prod
WHERE Price > 20000;

-- Q5. Delete the view Bulk_Sales. Then try to display it again. What happens? 
DROP VIEW Bulk_Sales;

SELECT * FROM Bulk_Sales;
#shows bulk_sales doesnt exist

-- Q6. Create a view named Sales_Details that shows SaleID, CustomerName, ProductName, Quantity, Price and a 
-- calculated column TotalAmount (Quantity × Price). Use a JOIN between Sales and Products. Then display the view.
CREATE VIEW Sales_Details AS
SELECT s.SaleID , s.CustomerName,
p.ProductName , s.Quantity , p.Price,
s.Quantity * p.Price AS TotalAmount
FROM Sales s
INNER JOIN Products p
ON s.ProductID=p.ProductID;

SELECT * FROM Sales_Details;

-- Q7. Using the view Sales_Details, find the total sales amount of all sales. Name the column TotalSales.
SELECT SUM(TotalAmount)  As TotalSales
FROM Sales_Details;

-- Q8. Create a view named Category_Sales that shows each Category 
-- and its total sales amount (TotalSales). Then display the view.
CREATE VIEW Category_Sales AS 
SELECT p.Category, SUM(p.Price * s.Quantity) AS TotalSales 
FROM Sales s
JOIN Products p
ON p.ProductID=s.ProductID
GROUP BY p.Category;

SELECT  * FROM Category_Sales;

-- Q9. Create a view named City_Sales that shows each City with the number of sales (TotalOrders) and 
-- the total quantity sold (TotalQuantity). Then display the view.
CREATE VIEW City_Sales AS
SELECT s.City,
COUNT(s.SaleID) AS TotalOrders,
SUM(s.Quantity) AS TotalQuantity
FROM Sales s
GROUP BY s.City;

SELECT * FROM City_Sales;

-- Q10. Create a table sales_log with the columns SaleID (INT), CustomerName (VARCHAR(50)) and Action (VARCHAR(50)). Then create an AFTER INSERT
-- trigger named after_sale_insert on the Sales table that adds a row to sales_log with the text 'Sale Added' every time a new sale is inserted.
CREATE TABLE sales_log( SaleID INT, CustomerName VARCHAR(50), 
Action VARCHAR(50));

DELIMITER //

CREATE TRIGGER after_sale_insert
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
     INSERT INTO sales_log
     VALUES (NEW.SaleID,
     NEW.CustomerName, 
     'Sale Added'
	);
END //
DELIMITER ;

INSERT INTO Sales
VALUES(
     21, '2026-11-23', 'Aysha', 'Kozhikode', 2, 1);
     
	SELECT * FROM sales_log;
 DELETE FROM sales_log WHERE SaleID = 21;

DELETE FROM Sales WHERE SaleID = 21;
   
-- Q11. Test the trigger: insert a new sale with SaleID 21, date '2026-11-12', customer 'Aisha Beegum', 
-- city 'Kozhikode', ProductID 4 and Quantity 2. Then display sales_log. You did not insert anything into sales_log yourself. Who did?
INSERT INTO Sales
VALUES
(21, '2026-11-12', 'Aisha Beegum', 'Kozhikode', 4, 2);

SELECT * FROM sales_log;
-- The AFTER INSERT trigger named after_sale_insert automatically inserted the record into
-- sales_log when a new sale was added to the Sales table.


-- Q12. Create a BEFORE INSERT trigger named check_quantity on the Sales table.
-- If the Quantity of a new sale is less than 0, the trigger must change it to 0 before the row is saved.
-- Test it by inserting SaleID 22, date '2026-11-13', customer 'Test Customer', city 'Kochi', ProductID 6 and Quantity -5,
-- and then display that row from the Sales table (SaleID, CustomerName, Quantity).
DELIMITER //

CREATE TRIGGER check_quantity
BEFORE INSERT ON Sales
FOR EACH ROW
BEGIN
    IF NEW.Quantity < 0 THEN
        SET NEW.Quantity = 0;
    END IF;
END //

DELIMITER ;

INSERT INTO Sales
VALUES(22,'2024-11-13','Test Costumer','Kochi',6,-5);

SELECT SaleID, CustomerName, Quantity
 FROM Sales;

-- Q13. Create a table price_log with the columns ProductID (INT), Old_Price (INT) and New_Price (INT). 
-- Then create an AFTER UPDATE trigger named price_update_log on the Products table that records OLD.Price and NEW.Price whenever a 
-- product is updated. Test it by changing the price of the Keyboard (ProductID 5) to 900, and then display price_log.

CREATE TABLE price_log (ProductID INT, Old_Price INT,New_Price INT);
DELIMITER //

CREATE TRIGGER price_update_log
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO price_log
    VALUES (
        OLD.ProductID,
        OLD.Price,
        NEW.Price
    );
END //
DELIMITER ;

UPDATE Products
SET Price = 900
WHERE ProductID = 5;

SELECT * FROM price_log;

-- Q14. Answer in 2 to 3 lines each: (a) What is the difference between a BEFORE trigger and an AFTER trigger? 
-- (b) What do OLD and NEW mean inside a trigger?
-- a)A BEFORE trigger executes before an INSERT, UPDATE or DELETE operation takes place.
-- An AFTER trigger executes after the operation is successfully completed.
-- OLD refers to the previous values of a row before it is updated or deleted.
-- NEW refers to the new values of a row being inserted or updated.

-- Q15. Delete the trigger check_quantity. Then run SHOW TRIGGERS and check that it is no longer in the list.
DROP TRIGGER check_quantity;

SHOW TRIGGERS;

-- Q16. Create an index named idx_customer_name on the CustomerName column of the Sales table.
CREATE INDEX idx_customer_name
ON Sales(CustomerName);

-- Q17. Write a normal SELECT query to display all sales of the customer 'Arjun Nair'. Do not write the index name in the query.
SELECT * FROM Sales
WHERE CustomerName='Arjun Nair';


-- Q18. Create a composite index named idx_city_product on the City and ProductID columns of the Sales table.
-- Then display the sales made in 'Kochi' for ProductID 2.
CREATE INDEX idx_city_product
ON Sales(City,ProductID);

SELECT * FROM 
Sales
WHERE City='Kochi'
AND ProductID=2;

-- Q19. Run EXPLAIN on the query from Question 17 (sales of 'Arjun Nair'). Which index is shown in the key column?
-- Then delete the index idx_customer_name using DROP INDEX and run EXPLAIN again. What changes in the key column?
EXPLAIN
SELECT * FROM Sales
WHERE CustomerName = 'Arjun Nair';

DROP INDEX idx_customer_name ON Sales;

EXPLAIN
SELECT * FROM Sales
WHERE CustomerName = 'Arjun Nair';

-- Q20. Answer in 2 to 3 lines: What is an index, and why should we not create an index on every column of a table?
-- An index is a database object that helps retrieve data from a table faster, similar to an index in a book.
-- We should not create an index on every column because indexes require extra storage space and can slow down INSERT, UPDATE and DELETE operations.

