CREATE DATABASE praticedemo_db;
USE praticedemo_db;
 #syantax=create table tablename(column1 datatype,column2 datatype...column datatype);
CREATE TABLE Customers (customer_id INT PRIMARY KEY, customer_name VARCHAR(100), city VARCHAR(100), age INT);
CREATE TABLE Products (product_id INT PRIMARY KEY, product_name VARCHAR(100), price DECIMAL(10, 2));
CREATE TABLE Sales (sale_id INT PRIMARY KEY, customer_id INT, product_id INT, quantity INT, FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id));
    drop table sales;
    #insert synatx=insert into tablename(column1,column2,...columnn)values(value1,value2,...value n);
INSERT INTO Customers VALUES(1, 'Rahul', 'Pune', 24), (2, 'Priya', 'Mumbai', 28),(3, 'Amit', 'Pune', 22),(4, 'Sneha', 'Nashik', 26),(5, 'Neha', 'Mumbai', 30);
INSERT INTO Products VALUES(101, 'Laptop', 55000),(102, 'Mouse', 500),(103, 'Keyboard', 1200),(104, 'Monitor', 10000),(105, 'Headphones', 2000);
INSERT INTO Sales VALUES(1, 1, 101, 1),(2, 2, 102, 2),(3, 3, 103, 1),(4, 1, 104, 2),(5, 4, 105, 1);

#select syntax=select * from tablename;
SELECT * FROM Customers;

#select=select *from tablename where condition;
SELECT *FROM Customers WHERE city = 'Pune';

#syntax=select *from tablename order by columnname asc or desc;
SELECT *FROM Products ORDER BY price DESC;

 #syntax = select distinct (column) from tablename;
SELECT DISTINCT city FROM Customers;

#syntax=SELECT column_name AS alias_name FROM table_name;
SELECT customer_name AS name, city AS customer_city FROM Customers;


#syntax=A filtering condition >,<,AND, OR, IN
SELECT *FROM Customers WHERE age >= 25;
SELECT *FROM Customers WHERE city = 'Mumbai' AND age > 25;
SELECT *FROM Customers WHERE city = 'Mumbai' OR age > 25;

SELECT *FROM Customers WHERE city IS NULL;

SELECT Sales.sale_id,Customers.customer_name,Products.product_name,Sales.quantity
FROM Sales JOIN Customers ON Sales.customer_id = Customers.customer_id
JOIN Products ON Sales.product_id = Products.product_id;

SELECT *FROM Products WHERE price BETWEEN 1000 AND 10000;

SELECT *FROM Products WHERE product_name LIKE '%head%';

SELECT city, COUNT(*) AS customer_count FROM Customers GROUP BY city;

SELECT *FROM Customers WHERE customer_id = 1;

SELECT *FROM Products WHERE product_id = 101;

SELECT *FROM Sales WHERE sale_id = 1;






CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Sales VALUES
(1, 1, 101, 1, '2026-01-05'),
(2, 2, 102, 2, '2026-01-10'),
(3, 1, 103, 3, '2026-02-15'),
(4, 3, 101, 1, '2026-02-20'),
(5, 4, 104, 2, '2026-03-05'),
(6, 2, 103, 2, '2026-03-12'),
(7, 3, 105, 5, '2026-03-18'),
(8, 1, 102, 1, '2026-04-02'),
(9, 4, 102, 1, '2026-04-10');


SELECT c.customer_name, s.product_id,s.quantity,s.sale_date FROM Customers c
INNER JOIN Sales s ON c.customer_id = s.customer_id;


SELECT c.customer_id,c.customer_name,s.sale_id FROM Customers c LEFT JOIN Sales s ON c.customer_id = s.customer_id;


SELECT p.product_name, SUM(s.quantity * p.price) AS total_sales FROM Products p INNER JOIN Sales s ON 
p.product_id = s.product_id GROUP BY p.product_id, p.product_name ORDER BY total_sales DESC;



SELECT c.customer_name,SUM(s.quantity * p.price) AS total_spent FROM Customers c INNER JOIN Sales s ON c.customer_id = s.customer_id
INNER JOIN Products p ON s.product_id = p.product_id GROUP BY c.customer_id, c.customer_name HAVING SUM(s.quantity * p.price) > 10000;




SELECT COUNT(*) AS total_sales FROM Sales;

SELECT SUM(quantity) AS total_quantity FROM Sales;

SELECT AVG(price) AS average_price FROM Products;

SELECT MIN(price) AS minimum_price FROM Products;

SELECT MAX(price) AS maximum_price FROM Products;


SELECT product_name,price,CASE WHEN price >= 20000 THEN 'Expensive'
WHEN price >= 2000 THEN 'Medium Price'
ELSE 'Budget' END AS price_category FROM Products;


SELECT product_name, price FROM Products WHERE price > (SELECT AVG(price) FROM Products);


WITH AveragePrice AS (
SELECT AVG(price) AS avg_price FROM Products)
SELECT p.product_name,p.price
FROM Products p CROSS JOIN AveragePrice a WHERE p.price > a.avg_price;


SELECT p.product_name,SUM(s.quantity * p.price) AS total_sales FROM Products p
INNER JOIN Sales s ON p.product_id = s.product_id GROUP BY p.product_id, p.product_name;


SELECT c.customer_name, SUM(s.quantity * p.price) AS total_spent FROM Customers c
INNER JOIN Sales s ON c.customer_id = s.customer_id 
INNER JOIN Products p ON s.product_id = p.product_id GROUP BY c.customer_id, c.customer_name;


SELECT DATE_FORMAT(s.sale_date, '%Y-%m') AS sales_month, SUM(s.quantity * p.price) AS monthly_sales
FROM Sales s INNER JOIN Products p ON s.product_id = p.product_id GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m') ORDER BY sales_month;










