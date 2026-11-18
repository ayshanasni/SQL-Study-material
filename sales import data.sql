USE assignment;
SELECT * FROM sales;
ALTER TABLE sales
MODIFY COLUMN SaleDate datetime;
#Q1Show all the records in the Sales table.
SELECT * FROM sales;
#Q2Show only the Customer, Product and Price of every sale
SELECT Customer , Product , Price
FROM sales;
#Q3List the cities where sales were made, with no city repeated.
SELECT DISTINCT City
FROM  sales;
#Q4List all the different products that were sold, with no product repeated.
SELECT DISTINCT Product
FROM sales
WHERE Status='Delivered';
#Q5Show Customer as Buyer and Product as Item_Sold for every sale.
SELECT Customer AS Buyer , Product AS Item_Sold
FROM sales;
#Q6Show all sales made in Kochi.
SELECT * FROM sales
WHERE City='Kochi';
#Q7Show all sales where the Price is more than 5000.
SELECT * FROM sales
WHERE Price>5000;
#Q8Show all sales where 5 or more items were bought.
SELECT * FROM sales
WHERE Quantity>=5;
#Q9Show all sales that were not delivered.
SELECT * FROM sales
WHERE NOT Status='Delivered';
#Q10Show all Electronics sales where more than 1 item was bought.
SELECT * FROM sales
WHERE Category='Electronics' and Quantity>1;
#Q11Show all sales paid by UPI or by Card.
SELECT * FROM sales
WHERE PaymentMode='UPI' OR PaymentMode='Card';
#Q12Show all sales that were not paid in Cash.
SELECT * FROM sales
WHERE NOT PaymentMode='Cash';
#Q13Show all sales from Kochi, Calicut and Thrissur.
SELECT * FROM sales
WHERE City IN('Kochi','Calicut','Thrissur');
#Q14Show all sales from every city except Kochi, Calicut and Trivandrum.
SELECT * FROM sales
WHERE City NOT IN('Kochi','Calicut','Trivandrum');
#Q15Show all sales made in March 2026 (from 1 March to 31 March).
SELECT * FROM sales
WHERE SaleDate BETWEEN '2026-03-01' and '2026-03-31';
#Q16Show all sales where the Price is below 1000 or above 10000.
SELECT * FROM sales
WHERE Price<1000 or Price>10000;
#Q17Show Product and the total amount (Price multiplied by Quantity) as TotalAmount for every sale.
SELECT Product,Price * Quantity AS TotalAmount
FROM sales;
#Q18Show Customer and the discount amount as DiscountAmount. The Discount column is a percentage of the total amount.
SELECT Customer , (Price * Quantity) *Discount/100 AS DiscountAmount
FROM sales;
#Q19Show Customer, Product and the final amount after discount as FinalAmount
SELECT Customer,Product,(Price*Quantity)-Discount AS FinalAmount
FROM sales;
#Q20Show Product and the price with 18% GST added as PriceWithGST for Electronics products only.
SELECT Product,Price+(Price*18/100) AS PriceWithGST
FROM sales
WHERE Category='Electronics';
#Q21Show Customer, Product and TotalAmount for delivered sales where the total amount is more than 10000.
SELECT Customer,Product,Price*Quantity AS TotalAmount
FROM sales
WHERE Status='Delivered' and Price*Quantity>10000;
#Q22Show all sales where the customer's email is missing.
SET SQL_SAFE_UPDATES=0;
UPDATE sales SET email=NULL WHERE email='';
SET SQL_SAFE_UPDATES=1;
SELECT*FROM sales;
SELECT * FROM sales
WHERE email IS NULL;
#Q23Show all sales where the customer's email is available.
SELECT * FROM sales
WHERE email IS NOT NULL;
#Q24Show all sales where the Customer name starts with S.
SELECT * FROM sales
WHERE 




