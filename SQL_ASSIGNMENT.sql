------TASK_01
CREATE DATABASE TECHSHOP ---Q1

USE TECHSHOP
---------------Q2
CREATE TABLE customers(--------------CUSTOMER TABLE
	customerID INT PRIMARY KEY,-----PRIMARY KEY
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	email VARCHAR(100),
	phone INT,
	address VARCHAR(200)
	);

CREATE TABLE products (
    productID INT PRIMARY KEY,
    productname VARCHAR(100),
    description VARCHAR(200),
    price DECIMAL(10,2)
);

CREATE TABLE orders(
	orderID INT PRIMARY KEY,
	customerID INT,
	orderdate DATE,
	totalamount DECIMAL(10,4),
	FOREIGN KEY(customerID) REFERENCES customers(customerID)
	);

CREATE TABLE orderetails (
    orderetailID INT PRIMARY KEY,
    orderID INT,
    productID INT,
    quantity INT,
    FOREIGN KEY (orderID) REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

CREATE TABLE inventory (
    inventoryID INT PRIMARY KEY,
    productID INT,
    quantityinstock INT,
    laststockupdate DATE,
    FOREIGN KEY (productID) REFERENCES products(productID)
);
--------forgot to name it as varchar
ALTER TABLE customers
ALTER COLUMN phone VARCHAR(30);
------------------Q4
INSERT INTO customers VALUES
(1, 'Uma', 'Maheswari', 'uma@gmail.com', '9994449664', 'Theni Main Road, Madurai'),
(2, 'Murali', 'Krishnan', 'murali@gmail.com', '9884456721', 'Kamarajar Salai, Madurai'),
(3, 'Siva', 'Kumar', 'siva@gmail.com', '9876543210', 'KK Nagar, Madurai'),
(4, 'Jaya', 'Lakshmi', 'jaya@gmail.com', '9966554433', 'Anna Nagar, Chennai'),
(5, 'Harish', 'R', 'harish@gmail.com', '9944556677', 'Thirunagar, Madurai'),
(6, 'Hari', 'Babu', 'hari@gmail.com', '9900887766', 'Kalavasal, Madurai'),
(7, 'Nithish', 'S', 'nithish@gmail.com', '9988776655', 'Mattuthavani, Madurai'),
(8, 'Selva', 'Rajan', 'selva@gmail.com', '9877788899', 'Villapuram, Chennai'),
(9, 'Sana', 'Begum', 'sana@gmail.com', '9844556677', 'Goripalayam, Madurai'),
(10, 'Sai', 'Vignesh', 'sai@gmail.com', '9798798989', 'Simmakkal, Madurai');

SELECT * FROM customers

INSERT INTO products VALUES
(101, 'Laptop', '15-inch laptop with 16GB RAM', 75000),
(102, 'Smartphone', 'Android phone with 128GB storage', 20000),
(103, 'Headphones', 'Noise cancelling headphones', 5000),
(104, 'Monitor', '24-inch LED monitor', 12000),
(105, 'Keyboard', 'Mechanical keyboard', 3000),
(106, 'Mouse', 'Wireless mouse', 1500),
(107, 'Router', 'Dual-band WiFi router', 2500),
(108, 'Webcam', 'HD webcam', 4000),
(109, 'Tablet', '10-inch Android tablet', 15000),
(110, 'Printer', 'All-in-one printer', 8500);

SELECT * FROM products
-------------Q5
INSERT INTO orders VALUES
(201, 1, '2025-06-01', 10000),
(202, 2, '2025-06-02', 8500),
(203, 3, '2025-06-03', 16000),
(204, 4, '2025-06-04', 12000),
(205, 1, '2025-06-05', 2000),
(206, 6, '2025-06-06', 11000),
(207, 2, '2025-06-07', 3000),
(208, 2, '2025-06-08', 7500),
(209, 9, '2025-06-09', 1500),
(210, 10, '2025-06-10', 9500);

INSERT INTO orderetails VALUES
(301, 201, 101, 1),  -- Uma
(302, 202, 102, 1),-- Murali
(303, 203, 103, 2), -- Siva
(304, 204, 104, 1),  -- Jaya
(305, 205, 106, 1), -- Uma again
(306, 206, 105, 2), -- Hari
(307, 207, 107, 1),  -- Murali
(308, 208, 109, 1), -- Murali again
(309, 209, 110, 1),  -- Sana
(310, 210, 108, 2);  -- Sai

INSERT INTO inventory VALUES
(401, 101, 25, '2025-06-01'), -- Laptop
(402, 102, 40, '2025-06-01'),  -- Smartphone
(403, 103, 60, '2025-06-01'),  -- Headphones
(404, 104, 15, '2025-06-01'),-- Monitor
(405, 105, 30, '2025-06-01'),  -- Keyboard
(406, 106, 45, '2025-06-01'), -- Mouse
(407, 107, 20, '2025-06-01'),  -- Router
(408, 108, 35, '2025-06-01'),-- Webcam
(409, 109, 18, '2025-06-01'),  -- Tablet
(410, 110, 12, '2025-06-01');  -- Printer


-------------TASK_02
---Q1 1. Write an SQL query to retrieve the names and emails of all customers.  
SELECT CONCAT(firstname,' ',lastname) ,email FROM customers

---Q2 Write an SQL query to list all orders with their order dates and corresponding customer names.
SELECT 
    c.firstname,
    o.orderID,
    o.orderdate
FROM 
    customers c INNER JOIN orders o ON c.customerID = o.customerID;

----Q3 Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
SELECT * FROM customers
INSERT into customers(customerID,firstname,lastname,email,phone,address)
VALUES 
(11,'Surya','Kumar','surya@gmail.com','9983564776','Thirunagar, Madurai');
	
-----Q4 Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%. 
UPDATE Products
SET Price = Price * 1.10;

-----Q5 Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
-- First delete from OrderDetails 
DELETE FROM orderetails
WHERE orderID = 208

-- Then delete from Orders 
DELETE FROM orders
WHERE orderID = 208;

SELECT * FROM orders
SELECT * FROM orderetails


------Q6 Write an SQL query to insert a new order into the "Orders" table.  information. 
INSERT INTO orders (orderID,customerID,orderdate,totalamount)
VALUES
(211,11,'2025-06-11',2000)--got erro but solved

-----Q7 Write an SQL query to update the contact information 
UPDATE Customers
SET 
    Phone = '9994449665',
    Email = 'maheswari@gmail.com'
WHERE 
    FirstName = 'Uma';

SELECT * FROM customers 
    
------Q8 Write an SQL query to recalculate and update the total cost 
UPDATE orders
SET totalamount=(
    SELECT SUM(p.price * od.quantity)
    FROM orderetails od
    JOIN products p ON od.productID = p.productID
    WHERE od.orderID = orders.orderID
);

SELECT * FROM orders

-----q9 difficult  Write an SQL query to delete all orders and their associated order details for a specific customer f
DELETE FROM orderetails
WHERE orderID IN(
SELECT orderID from orders where customerID=2
);
DELETE FROM orders
WHERE customerID = 2;
select * from orders

-----q10 Write an SQL query to insert a new electronic gadget 

INSERT INTO products (productID, productname, description, price)
VALUES (111, 'Smartwatch', 'Bluetooth-enabled fitness', 6500);


------q11 Write an SQL query to update the status of a specific order in the "Orders" table
ALTER TABLE orders
ADD status VARCHAR(20);

UPDATE orders
SET status = 'Shipped'
WHERE orderID = 203;
SELECT * FROM orders


------q12 Write an SQL query to calculate and update the number of orders placed by each customer n the "Customers" table based on the data in the "Orders" table.
SELECT * FROM customers
ALTER TABLE customers
ADD order_count INT ;

UPDATE customers
SET order_count = (
select SUM(re.quantity)
from orders o
INNER JOIN 
orderetails re ON o.orderID=re.orderid
where o.customerID=customers.customerID
);




--------------task_03
-------1. Write an SQL query to retrieve a list of all orders along with customer information (e.g., 
---customer name) for each order. 

SELECT 
c.customerID,
concat(c.firstname,' ' ,c.lastname) as name,
o.orderID,
o.orderdate
FROM customers c inner join orders o 
ON c.customerID=o.customerID
order  by name

---2. Write an SQL query to find the total revenue generated by each electronic gadget product. 
----Include the product name and the total revenue.

SELECT 
p.productID,
p.productname,
SUM(o.quantity*p.price) as revenue 
from products p inner join orderetails o
ON p.productID=o.productID
group by p.productID,p.productname


---3. Write an SQL query to list all customers who have made at least one purchase. Include their 
---names and contact information. 
SELECT 
CONCAT(c.firstname, ' ', c.lastname) AS name,
COUNT(o.orderID) AS times
FROM customers c 
RIGHT JOIN orders o ON c.customerID = o.customerID
GROUP BY CONCAT(c.firstname, ' ', c.lastname);

---4. Write an SQL query to find the most popular electronic gadget, which is the one with the highest 
---total quantity ordered. Include the product name and the total quantity ordered. 

SELECT 
o.quantity,
MAX(p.productname) AS tot
from orderetails o left join products p
on p.productID=o.productID
group  by o.quantity

----5. Write an SQL query to retrieve a list of electronic gadgets along with their corresponding 
---categories. 
SELECT productname , category from products

---6. Write an SQL query to calculate the average order value for each customer. Include the 
---customer's name and their average order value.

SELECT 
c.customerID,
concat (c.firstname , ' ' , c.lastname ) as name,
count(o.orderID)/count(distinct o.orderdate) as average
from customers c inner join orders o on
c.customerID=o.customerID
group by concat (c.firstname , ' ' , c.lastname ),c.customerID

---7. Write an SQL query to find the order with the highest total revenue. Include the order ID, 
---customer information, and the total revenue.

SELECT top 1
o.orderID,
concat (c.firstname , ' ' , c.lastname ) as name,
SUM(od.quantity*p.price) as revenue 
from customers c inner join orders o on c.customerID=o.customerID
join orderetails od on o.orderID=od.orderID
join products p on od.productID=p.productID
group by o.orderID,concat (c.firstname , ' ' , c.lastname ) 
ORDER BY revenue DESC;

---8. Write an SQL query to list electronic gadgets and the number of times each product has been 
----ordered. 
SELECT 
p.productname,
COUNT(od.orderetailID) AS times_ordered
FROM products p
JOIN orderetails od ON p.productID = od.productID
GROUP BY p.productname;

---9. Write an SQL query to find customers who have purchased a specific electronic gadget product. 
---Allow users to input the product name as a parameter. 
SELECT 
DISTINCT c.customerID,
CONCAT(c.firstname, ' ', c.lastname) AS name,
c.email
FROM customers c JOIN orders o ON c.customerID = o.customerID
JOIN orderetails od ON o.orderID = od.orderID
JOIN products p ON od.productID = p.productID
WHERE p.productname = 'Laptop'

--10. Write an SQL query to calculate the total revenue generated by all orders placed within a 
--specific time period. Allow users to input the start and end dates as parameters. 
SELECT 
p.productname,
SUM(od.quantity * p.price) AS revenue
FROM orders o JOIN orderetails od ON o.orderID = od.orderID
JOIN products p ON od.productID = p.productID
WHERE o.orderdate BETWEEN '2025-06-01' AND '2025-06-05'
GROUP BY p.productname;


use TECHSHOP
-------task 04
-----1. Write an SQL query to find out which customers have not placed any orders. 
select concat ( firstname , ' ',lastname) as customer_not_placed,customerID from customers
where customerid not in (select customerID from orders)

----2. Write an SQL query to find the total number of products available for sale. 
select p.productname , p.productid , i.quantityinstock from products p , inventory i
where p.productID = i.productID

----3. Write an SQL query to calculate the total revenue generated by TechShop.
select sum(p.price * o.quantity) as totalrevenue
from products p
join orderetails o on o.productid = p.productid;

---4. Write an SQL query to calculate the average quantity ordered for products in a specific category. 

select c.category ,avg(o.quantity)as average  from products c, orderetails o 
where c.productID=o.productID
group by c.category



-----5. Write an SQL query to calculate the total revenue generated by a specific customer. Allow users 
---to input the customer ID as a parameter. 
select (select sum(od.quantity * p.price) from orders o, orderetails od, products p
where o.orderid = od.orderid 
and od.productid = p.productid 
and o.customerid = '1'
) as total_revenue;



----6. Write an SQL query to find the customers who have placed the most orders. List their names 
----nd the number of orders they've placed. 

select c.firstname from customers c
where c.order_count = (select max(order_count) as maximum from customers)

---7. Write an SQL query to find the most popular product category, which is the one with the highest 
---total quantity ordered across all orders. 

select p.category  from products p 
where p.productID in ( select o.productID from orderetails o
where o.quantity = ( select max(quantity ) as maximum from orderetails))

---8. Write an SQL query to find the customer who has spent the most money (highest total revenue) 
---on electronic gadgets. List their name and total spending.
select c.firstname from customers c 
where c.customerID in ( select o.customerID from orders o
where o.totalamount = ( select max(totalamount ) as tot from orders))

---9. Write an SQL query to calculate the average order value (total revenue divided by the number of 
---orders) for all customers.

select (sum(od.quantity *p.price) /count(c.order_count)) as avgord
from customers c join orders o on c.customerID=o.customerID
join orderetails od on od.orderID = o.orderID
join products p on od.productID=p.productID


select (sum(od.quantity *p.price) /count(c.order_count)) as avgord from products p , orderetails od , customers c, orders o
where c.customerID=o.customerID and od.orderID=o.orderID and od.productID=p.productID

-----10. Write an SQL query to find the total number of orders placed by each customer and list their 
---names along with the order count. 
select firstname , order_count from customers











	



