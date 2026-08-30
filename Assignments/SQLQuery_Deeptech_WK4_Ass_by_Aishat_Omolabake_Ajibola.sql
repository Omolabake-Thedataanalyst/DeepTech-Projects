# Use created schema - deeptech_ass_week4
USE deeptech_ass_week4;

# Original csv dataset added to database using Table data import wizard

/* 1.	Convert this dataset into 1NF: Remove duplicate values and ensure atomicity.
2.	Transform into 2NF: Eliminate partial dependencies by creating separate tables.
3.	Achieve 3NF: Remove transitive dependencies and ensure all non-key attributes depend only on the primary key.
4.	Transform the data by updating employee salaries with a 10% increase for employees in the IT department. */

-- To achieve 3NF, the dataset will be splitted in four tables (department, location, branches and employees) which will also satisfy 1NF and 2NF

# Create departments table that contains all attributes depending on department
CREATE TABLE departments(
	department_id INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(50) UNIQUE,
    manager_id INT
     );

# Set Auto_increment starting point for the department_id
ALTER TABLE departments
AUTO_INCREMENT = 101;

# Insert data into departments
INSERT INTO departments(department, manager_id)
SELECT DISTINCT department, manager_id
FROM `sql for data analysis and automation assignment 1`;

# confirm data entry into departments
SELECT * FROM departments;

# Create location table to contain unique location details of the departments
CREATE TABLE locations(
	location_id INT AUTO_INCREMENT PRIMARY KEY,
    department_location VARCHAR(50));

# Set location_id to start from 1001
ALTER TABLE locations
AUTO_INCREMENT = 1001;

# Insert data into locations
INSERT INTO locations(
department_location)
SELECT DISTINCT department_location
FROM `sql for data analysis and automation assignment 1`;

# Confirm data entry
SELECT * FROM locations;

# Create a department_branch table to serve as bridge table linking department and locations together
CREATE TABLE department_branches(
	department_branch_id INT AUTO_INCREMENT PRIMARY KEY,
    department_id INT,
	location_id INT,
    UNIQUE(department_id, location_id),
	FOREIGN KEY (department_id)
		REFERENCES departments(department_id),
	FOREIGN KEY (location_id)
		REFERENCES locations(location_id)
        );

# Insert data into department_branches
INSERT INTO department_branches(
	 department_id, location_id)
SELECT DISTINCT d.department_id, l.location_id 
FROM `sql for data analysis and automation assignment 1` s
JOIN departments d
ON s.department = d.department
JOIN locations l
ON s.department_location = l.department_location;

# Confirm data entry in department_branches
SELECT * FROM department_branches;

# Create employees table
CREATE TABLE employees(
	emp_id INT PRIMARY KEY,
    emp_name VARCHAR (50),
    salary DECIMAL (10,2),
    department_branch_id INT NOT NULL,
    FOREIGN KEY (department_branch_id)
		REFERENCES department_branches(department_branch_id)
        );

# Insert data into employees
INSERT INTO employees(
emp_id, emp_name, salary, department_branch_id)
SELECT s.emp_id, s.emp_name, s.salary, db.department_branch_id
FROM `sql for data analysis and automation assignment 1` s
JOIN departments d
ON s.department = d.department
JOIN locations l
ON s.department_location = l.department_location
JOIN department_branches db
ON d.department_id = db.department_id
AND l.location_id = db.location_id;

# Confirm data entry into employees
SELECT * FROM employees;

# Transform the data by updating employee salaries with a 10% increase for employees in the IT department.

# Check previous data 
SELECT e.emp_id, e.emp_name, d.department, e.salary
FROM employees e
JOIN department_branches db
    ON e.department_branch_id = db.department_branch_id
JOIN departments d
    ON db.department_id = d.department_id
WHERE d.department = 'IT';

# Update new data
UPDATE employees
SET salary = salary * 1.10
WHERE emp_id IN
(
    SELECT e.emp_id
    FROM employees e
    JOIN department_branches db
        ON e.department_branch_id = db.department_branch_id
    JOIN departments d
        ON db.department_id = d.department_id
    WHERE d.department = 'IT'
);

# Confirm new salary
SELECT
    e.emp_id,
    e.emp_name,
    d.department,
    e.salary
FROM employees e
JOIN department_branches db
    ON e.department_branch_id = db.department_branch_id
JOIN departments d
    ON db.department_id = d.department_id
WHERE d.department = 'IT'
ORDER BY e.emp_id;

#Assignment 2
/*1. Explain the importance of data warehousing in decision-making.
2.	Write an SQL View that retrieves customers who have spent more than 300,000 Naira in total purchases.
3.	Create a Materialized View that summarizes total sales per month.
4.	Write a stored procedure called update_product_price that increases the price of Phones by 10%. */

/* Data warehousing is important in decision-making because it provides a centralized repository where organizations can store, 
integrate, and analyze large volumes of historical and current data from different sources. 
Unlike operational databases that are designed for daily transactions, data warehouses are optimized for analysis and reporting.
Due to their non-volatile nature, data warehouses preserve historical records, allowing organizations to identify trends, compare past and present 
performance, and discover patterns that support strategic decision-making. They enable managers and analysts to generate meaningful reports, 
perform business intelligence analysis, forecast future outcomes, and make informed decisions based on reliable data rather than assumptions.
Therefore, data warehousing improves decision-making by providing accurate, consistent, and accessible information that helps organizations 
monitor performance, identify opportunities, and develop effective strategies. */

# Create new schema for assignment 2
CREATE SCHEMA deeptech_ass2_week4;

USE `deeptech_ass2_week4`;

# Create Customer Table
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	name VARCHAR (50),
	location VARCHAR(20),
	age INT,
	gender VARCHAR (15)
);

# Insert data into customers
INSERT INTO customers(
customer_id, name, location, age, gender)
VALUES 	
(1, 'John Doe',	'Lagos', 30, 'Male'),	
(2, 'Jane Smith', 'Abuja', 28, 'Female'),
(3,	'Peter Adams', 'Port Harcourt', 40, 'Male'),	
(4,	'Sarah Johnson', 'Kano', 35, 'Female');	

# Create products table
CREATE TABLE products(
	product_id INT PRIMARY KEY,
	product_name VARCHAR(50),
	category VARCHAR (20),
	price DECIMAL(10,2)
);					

# Insert data into products
INSERT INTO products(					
product_id, product_name, category, price)
VALUES		
(101, 'Laptop', 'Electronics', 350000),
(102, 'Phone', 'Electronics', 150000),		
(103, 'Printer', 'Office', 85000);		
					
# Create sales table
CREATE TABLE sales(
	sale_id INT PRIMARY KEY,
	customer_id INT,
	product_id INT,
	sale_date DATE,
	quantity INT,
	total_amount DECIMAL(10,2),
	FOREIGN KEY (customer_id)
		REFERENCES customers(customer_id),
	FOREIGN KEY (product_id)
		REFERENCES products(product_id)
);

# Insert data into sales
INSERT INTO sales(		
sale_id, customer_id, product_id, sale_date, quantity, total_amount)
VALUES
(5001, 1, 101, '2024-01-10', 1, 350000),
(5002, 2, 102, '2024-02-15', 2, 300000),
(5003, 3, 103, '2024-03-20', 1, 85000),
(5004, 4, 101, '2024-03-25', 1, 350000);

# 2.	Write an SQL View that retrieves customers who have spent more than 300,000 Naira in total purchases.
CREATE VIEW CustomersSpentOver300000 AS
	SELECT c.customer_id, c.name, c.location, s.total_amount
	FROM customers c
	JOIN sales s
	ON c.customer_id = s.customer_id
	GROUP BY c.customer_id, c.name
	HAVING SUM(s.total_amount) > 300000
	ORDER BY total_amount DESC;

# Run query using saved view
SELECT * FROM CustomersSpentOver300000;

# 3.	Create a Materialized View that summarizes total sales per month.

CREATE TABLE monthly_sales_summary (
    sales_month DATE PRIMARY KEY,
    total_sales DECIMAL(12,2),
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
    
## create a procedure to refresh the materialized view
DELIMITER $$

CREATE PROCEDURE refresh_monthly_sales_summary()

BEGIN

REPLACE INTO monthly_sales_summary
(
    sales_month,
    total_sales
)

SELECT
    DATE_FORMAT(sale_date, '%Y-%m-01') AS sales_month,
    SUM(total_amount) AS total_sales

FROM sales

GROUP BY DATE_FORMAT(sale_date, '%Y-%m');

END $$

DELIMITER ;

## call Materialized view for testing
CALL refresh_monthly_sales_summary();
SELECT * 
FROM monthly_sales_summary;

# 4.	Write a stored procedure called update_product_price that increases the price of Phones by 10%.
# Create procedure
DELIMITER $$

CREATE PROCEDURE update_product_price()
BEGIN
    UPDATE products
    SET price = price * 1.10
    WHERE product_name = 'Phone';
END $$

DELIMITER ;

# Call stored procedure
SET SQL_SAFE_UPDATES = 0;
CALL update_product_price();
SET SQL_SAFE_UPDATES = 1;

# Verify update
SELECT *
FROM products
WHERE product_name = 'Phone';

## Assignment 3
/* 1.	Write a SQL script to create the tables with constraints.
2.	Write a SQL transaction to handle an order purchase. If the product is out of stock, the transaction should rollback.
3.	Partition the Orders table based on OrderDate using RANGE partitioning (e.g., orders before 2023 go to one partition, and 2023+ orders go to another).
4.	Explain how indexing improved query performance. */

# Create schema for Ass 3
CREATE SCHEMA `deeptech_ass3_week4`;

USE `deeptech_ass3_week4`;

# 1.	Write a SQL script to create the tables with constraints.
-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    CHECK (Phone REGEXP '^[0-9]{10,15}$')
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    StockQuantity INT,
    CHECK (Price > 0),
    CHECK (StockQuantity >= 0)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),
    CHECK (TotalAmount > 0)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Subtotal DECIMAL(10,2),
    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON DELETE CASCADE,
    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),
    CHECK (Quantity > 0),
    CHECK (Subtotal > 0)
);

# 2.	Write a SQL transaction to handle an order purchase. If the product is out of stock, the transaction should rollback.

# Start the transaction
DELIMITER $$

CREATE PROCEDURE ProcessOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE available_stock INT;
    DECLARE product_price DECIMAL(10,2);
    DECLARE total_price DECIMAL(10,2);
    
    -- Start transaction
    START TRANSACTION;
    
    -- Check product stock and get price
    SELECT 
        StockQuantity,
        Price
    INTO 
        available_stock,
        product_price
    FROM Products
    WHERE ProductID = p_product_id;
    
    -- Check if enough stock is available
    IF available_stock < p_quantity THEN
        -- Cancel transaction
        ROLLBACK;

        SELECT 'Transaction Failed: Insufficient Stock' AS Message;
    ELSE
        -- Calculate total amount
        SET total_price = product_price * p_quantity;

        -- Insert order record
        INSERT INTO Orders
        (
            CustomerID,
            OrderDate,
            TotalAmount
        )
        VALUES
        (
            p_customer_id,
            CURDATE(),
            total_price
        );

        -- Insert order details
        INSERT INTO OrderDetails
        (
            OrderID,
            ProductID,
            Quantity,
            Subtotal
        )
        VALUES
        (
            LAST_INSERT_ID(),
            p_product_id,
            p_quantity,
            total_price
        );

        -- Reduce product stock
        UPDATE Products
        SET StockQuantity = StockQuantity - p_quantity
        WHERE ProductID = p_product_id;

        -- Save all changes permanently
        COMMIT;

        SELECT 'Order Completed Successfully' AS Message;
    END IF;

END $$

DELIMITER ;

#3.	Partition the Orders table based on OrderDate using RANGE partitioning (e.g., orders before 2023 go to one partition, and 2023+ orders go to another).
CREATE TABLE Orders_partition_by_range (
    OrderID INT AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) CHECK (TotalAmount > 0),
	PRIMARY KEY(OrderID, OrderDate)
)
PARTITION BY RANGE (YEAR(OrderDate)) (
    PARTITION p_before_2023 
        VALUES LESS THAN (2023),
    PARTITION p_2023_plus 
        VALUES LESS THAN MAXVALUE
);

# Insert data into Orders_partition_by_range to check partitioning
INSERT INTO Orders_partition_by_range(CustomerID, OrderDate, TotalAmount)
VALUES
(1,'2022-05-10',50000),
(2,'2024-01-15',80000);

SELECT *
FROM Orders_partition_by_range PARTITION(p_before_2023);

SELECT *
FROM Orders_partition_by_range PARTITION(p_2023_plus);

# 4.	Explain how indexing improved query performance.

/* Indexing improves query performance by creating a faster lookup structure for frequently searched columns, reducing the need for the 
database to scan every row in a table. Instead of performing a full table scan, the database uses the index to quickly locate the required records, 
which improves the speed of filtering, sorting, and joining operations.For example, creating an index on the CustomerID or DepartmentID column 
allows queries that search for specific customers or departments to execute faster, especially when working with large datasets. 
However, indexes also require additional storage and can slow down insert, update, and delete operations because the index must be updated whenever 
the data changes. Therefore, indexes should be created on columns that are frequently used in queries. */

#Assignment done by Aishat Omolabake Ajibola using MySQL









