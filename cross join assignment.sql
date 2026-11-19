USE assignment;
CREATE TABLE colors(color_id INT, color_name VARCHAR(20));
INSERT INTO colors VALUES (1,'Red'),(2,'Blue'),(3,'Black');
SELECT * FROM colors;

CREATE TABLE sizes(size_id INT, size_name VARCHAR(5));
INSERT INTO sizes VALUES (1,'S'),(2,'M'),(3,'L');
SELECT * FROM sizes;

-- Q1. List all possible color and size combinations of a T-shirt.
SELECT color_name, size_name
FROM colors
CROSS JOIN sizes;
----------------

CREATE TABLE students1(student_id INT, student_name VARCHAR(30));
INSERT INTO students1 VALUES (101,'Anu'),(102,'Ravi'),(103,'Meera');

CREATE TABLE subjects1(subject_id INT, subject_name VARCHAR(30));
INSERT INTO subjects1 VALUES (1,'Maths'),(2,'Science'),(3,'English');

-- Q2. Display every student against every subject, ordered by student name.
SELECT s.student_name,
       sub.subject_name
FROM students1 s
CROSS JOIN subjects1 sub
ORDER BY s.student_name ASC;

--------------

CREATE TABLE products(product_id INT, product_name VARCHAR(30), price INT);
INSERT INTO products VALUES (1,'Laptop',50000),(2,'Phone',20000),(3,'Tablet',15000);

CREATE TABLE discounts(discount_name VARCHAR(30), percent INT);
INSERT INTO discounts VALUES ('Festival',10),('Student',15);

-
-- - Q3. Show the final price of every product under every discount offer.
SELECT p.product_name,
       d.discount_name,
       p.price,
       d.percent,
       p.price - (p.price * d.percent / 100) AS FinalPrice
FROM products p
CROSS JOIN discounts d;