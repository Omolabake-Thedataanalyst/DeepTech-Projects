-- create database for first assignment
CREATE DATABASE Deeptech_Ass_Wk3;

USE Deeptech_Ass_Wk3;

-- create customer table
CREATE TABLE customers
			(Customer_ID INT PRIMARY KEY,
			Name VARCHAR (50),
			State VARCHAR (50),
			Income INT);

-- Insert data into customer table
INSERT into customers
(Customer_ID, Name, State, Income)
Values
(3021, 'Kolawale Saidu', 'Lagos', 5000),
(3028, 'Ade Abu',	'Edo', 120000),
(3067,	'Imabong Udo',	'Akwa Ibom', 	65000),
(3078,	'Diana Ross',	'Cross River',	95000),
(3097,	'Adullahi Usman',	'Yobe', 70000),
(3043,	'Jefferson Chris',	'Taraba',	51000),
(3056,	'Chidinma Ikena', 'Abia',	67000);

-- confirm data entry
SELECT * 
FROM customers;

-- Create transaction table
CREATE TABLE transactions
    (Transaction_ID VARCHAR (50) PRIMARY KEY,
    Customer_ID INT,
    Amount INT,
    Transaction_Type VARCHAR (50),
    Date DATE,
    FOREIGN KEY (Customer_ID)
	    REFERENCES Customers (Customer_ID)
);

-- Insert data into transactions table
INSERT INTO transactions
(Transaction_ID, Customer_ID, Amount, Transaction_Type,	Date)
VALUES
('T001',	3021,	8000,	'Credit',	'2024-12-01'),
('T002',	3028,	1000,	'Debit',	'2024-12-02'),
('T003',	3078,	4000,	'Credit',	'2024-12-03'),
('T004',	3067,	1500,	'Credit',	'2024-12-03'),
('T005',	3021,	15000,	'Debit',	'2024-12-04'),
('T006',	3097,	30000,	'Debit',	'2024-12-05'),
('T007',	3028,	90000,	'Credit',	'2024-12-05'),
('T008',    3056,	7600, 	'Debit',	'2024-12-06'),
('T009',	3043,	5800,	'Credit',	'2024-12-06');


/*1.	Write a query to list all customers and their transaction details. 
Ensure customers without transactions and transactions without matching customers are included.*/
SELECT c.Name,
	t.Transaction_ID,
	t.Amount,
	t.Transaction_Type,
	t.Date
FROM Customers c
FULL OUTER JOIN transactions t
ON c.Customer_ID = t.Customer_ID
ORDER BY c.Name;

-- 2.	Identify the customer(s) who have the highest total transaction amount using a subquery.
SELECT 
    c.Name,
    SUM(t.Amount) AS Total_Transaction_Amount
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
GROUP BY c.Name
HAVING SUM(t.Amount) = 
(
    SELECT MAX(Total_Amount)
    FROM
    (
        SELECT SUM(Amount) AS Total_Amount
        FROM Transactions
        GROUP BY Customer_ID
    ) AS Customer_Total
);
		

-- 3.	Write a query to combine the list of customers from Lagos and Edo using UNION, excluding duplicates.
SELECT c.Name,
		c.State
FROM customers c
WHERE c.State = 'Lagos'

UNION

SELECT c.Name,
		c.State
FROM customers c
WHERE c.State = 'Edo';

/*4.	Assign a rank to each transaction based on the transaction amount in descending order. 
Additionally, use lead and lag to display the previous and next transaction amount for each transaction, ordered by date.*/

Select c.Customer_ID,
		c.Name,
		t.Transaction_ID,
		c.State,
		t.Amount,
		RANK() OVER (ORDER BY Amount DESC) AS rank_num
FROM Customers c
JOIN transactions t
ON c.Customer_ID = t.Customer_ID;

SELECT 
    c.Customer_ID,
    c.Name,
    t.Transaction_ID,
    c.State,
    t.Amount,
    t.Date,
    LAG(t.Amount) OVER (ORDER BY t.Date) AS Previous_Transaction_Amount,
    LEAD(t.Amount) OVER (ORDER BY t.Date) AS Next_Transaction_Amount
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID;

-- Create DB for second assignment
CREATE DATABASE  Deeptech_Ass_Wk3_2;

USE Deeptech_Ass_Wk3_2;

-- create order table
CREATE Table Orders
    (OrderID INT PRIMARY KEY,
    CustomerName VARCHAR (50),	
    OrderDate DATE,
    Product VARCHAR (50),
    Quantity INT,
    Price INT,
    State VARCHAR (50)
);				

-- Insert data into orders table
INSERT INTO Orders
(OrderID, CustomerName, OrderDate, Product, Quantity, Price, State)
VALUES
(1, 'Gabriel Aliyu', '2023-01-15', 'Laptop', 2, 350000, 'Sokoto'),
(2, 'Brown Abu', '2023-02-10', 'Phone', 5, 250000, 'Cross River'),
(3, 'Janet Ugo', '2023-03-20', 'Tablet', 3, 700000, 'Imo'),
(4, 'Abi Jude', '2023-01-20', 'Phone', 1, 150000, 'Kogi'),
(5, 'Garba Shehu', '2023-04-05', 'Laptop', 1, 500000, 'Borno');
						
-- Verify the data entry
SELECT * 
FROM Orders;

-- Create Payments table
CREATE TABLE Payments
	(PaymentID INT PRIMARY KEY,	
	OrderID INT, 
	PaymentDate DATE, 
	PaymentAmount INT, 
	PaymentMethod VARCHAR (50),
	FOREIGN KEY (OrderID)
		REFERENCES Orders (OrderID)
);

-- Insert data into Payments table
INSERT INTO Payments
(PaymentID,	OrderID, PaymentDate, PaymentAmount, PaymentMethod)	
VALUES
(101, 1, '2023-01-16', 700000, 'Card'),
(102, 2, '2023-02-11', 1250000, 'Cash'),
(103, 3, '2023-03-21', 2100000, 'Bank Transfer'),
(104, 4, '2023-01-21', 150000, 'Card'),
(105, 5, '2023-04-06', 500000, 'Cash');

-- Verify data entry
SELECT *
FROM Payments;

/*1.	Create a CTE to calculate the total amount spent by each customer across all their orders, 
including the customer's name, and sort the results by the total amount in descending order.*/

WITH Customer_orders AS (SELECT 
			o.CustomerName,  
			SUM(p.PaymentAmount) AS total_amount
			FROM Orders o
			JOIN Payments p
			ON o.OrderID = p.OrderID
			GROUP BY o.CustomerName)
Select * 
FROM Customer_orders
ORDER BY total_amount DESC;

/*2.	Use GROUPING SETS, ROLLUP, or CUBE to analyze the total revenue grouped by State and Product, 
and include subtotals for each state and product combination.*/

-- Using ROLLUP
SELECT
    ISNULL(State, 'All States') AS State,
    ISNULL(Product, 'All Products') AS Product,
    SUM(Quantity * Price) AS Total_Revenue
FROM Orders
GROUP BY ROLLUP (State, Product);

-- Using CUBE
SELECT
    ISNULL(State, 'All States') AS State,
    ISNULL(Product, 'All Products') AS Product,
    SUM(Quantity * Price) AS Total_Revenue
FROM Orders
GROUP BY CUBE (State, Product);

-- Using Grouping sets
SELECT
    ISNULL(State, 'All States') AS State,
    ISNULL(Product, 'All Products') AS Product,
    SUM(Quantity * Price) AS Total_Revenue
FROM Orders
GROUP BY GROUPING SETS (
	(State, Product),
	(State),
	(Product),
	()
	);


/* 3. Extract the year and month from the OrderDate column in the Orders Table and display them as OrderYear and OrderMonth.*/
SELECT
    OrderID,
    CustomerName,
    OrderDate,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;

-- Using Datepart
SELECT
    OrderID,
    CustomerName,
    OrderDate,
    DATEPART(YEAR, OrderDate) AS OrderYear,
    DATEPART(MONTH, OrderDate) AS OrderMonth
FROM Orders;


-- Create DB for third assignment
CREATE DATABASE  Deeptech_Ass_Wk3_3;

USE Deeptech_Ass_Wk3_3;

-- Create customers table
CREATE TABLE customers
    (customer_id INT PRIMARY KEY,
    name VARCHAR (50),
    loyalty_points INT,
    registration_date DATE,
    age INT);

-- Insert data into customers table
INSERT INTO customers
(customer_id, name,	loyalty_points,	registration_date, age)
VALUES
(101, 'Shehu Salihu', 150, '2019-05-15', 35),
(201, 'Job Timothy', 200, '2020-06-20',	42),
(305, 'Agnes Pam', 300, '2018-08-10', 29),
(405, 'Esther James', 120, '2022-01-05', 50),
(509, 'Larry Adams', 250, '2021-10-12',	32);

-- Verify data entry
SELECT *
FROM customers;

-- Create transactions table
CREATE TABLE transactions
    (transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount_spent INT,
    transaction_date DATE,
    FOREIGN KEY (customer_id)
	    REFERENCES customers(customer_id)
);

-- Insert data into transactions
INSERT INTO transactions
(transaction_id, customer_id, amount_spent, transaction_date)
VALUES
(1,	101, 100, '2023-05-10'),
(2,	201, 200, '2023-05-11'),
(3,	305, 300, '2023-05-12'),
(4,	405, 400, '2023-05-13'),
(5,	509, 150, '2023-05-14'),
(6,	305, 500, '2023-05-15');
				
-- Verify data entry
SELECT * 
FROM transactions;

-- Create products table
CREATE TABLE products
    (product_id INT PRIMARY KEY,
    product_name VARCHAR (50),
    price INT,
    category VARCHAR (50)
);

-- Insert data into	products table
INSERT INTO products
(product_id, product_name, price, category)
VALUES
(102, 'Laptop',	200000,	'Electronics'),	
(201, 'Smartphone',	500000,	'Electronics'),	
(203, 'Blender', 120000, 'Home Appliance'),	
(104, 'Sofa', 450000, 'Furniture'),	
(107, 'Desk Lamp', 350000, 'Furniture');	

-- Verify data entry
SELECT *
FROM products;

/*1.	Using CASE Statements and Conditional Aggregation.
Write a query to display the total amount spent by customers below 40 years old. 
Use a CASE statement to group the data into these categories.*/
SELECT
    CASE
        WHEN c.Age < 40 THEN 'Below 40'
        ELSE '40 and Above'
    END AS Age_Group,
    SUM(t.Amount_Spent) AS Total_Amount_Spent
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
GROUP BY
    CASE
        WHEN c.Age < 40 THEN 'Below 40'
        ELSE '40 and Above'
    END;	

-- 2.	Create an index on the transaction_date column in the Transactions table.
CREATE INDEX idx_tdate ON transactions(transaction_date);


/*3.	Write a query to display the total sales (amount_spent) and the number of transactions for each customer.
o	Use the GROUP BY clause
o	Use the EXPLAIN command to analyze the query execution plan and identify bottlenecks.*/

SELECT
    c.customer_id,
    c.name,
    SUM(t.amount_spent) AS Total_Sales,
    COUNT(t.transaction_id) AS Number_of_Transactions
FROM customers c
JOIN transactions t
ON c.customer_ID = t.customer_ID
GROUP BY
    c.customer_ID,
    c.name;

-- MSSQL Server does not support the EXPLAIN command
SET SHOWPLAN_ALL ON;
GO

SELECT
    c.Customer_ID,
    c.Name,
    SUM(t.Amount_Spent) AS Total_Sales,
    COUNT(t.Transaction_ID) AS Number_of_Transactions
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Name;
GO

SET SHOWPLAN_ALL OFF;
GO

/*The execution plan shows that SQL Server used Clustered Index Scans on both the Customers and Transactions tables because the dataset is small. 
The tables were joined using a Nested Loops (Inner Join), which is an efficient join method for small datasets. 
A Stream Aggregate operator was used to calculate the SUM of Amount_Spent and the COUNT of Transaction_ID for each customer. 
Finally, a Compute Scalar operator performed internal calculations required for the output. 
No significant bottlenecks were observed due to the small size of the data. 
However, for larger datasets, the clustered scan on the Transactions table could become a performance bottleneck.
Creating an index on Transactions(Customer_ID) would help SQL Server locate matching rows more efficiently and improve query performance.*/


-- Assignment done by Aishat Omolabake Ajibola using MSSQL database server
