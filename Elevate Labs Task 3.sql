-- SQL Queries for Task

-- a) Basic SELECT with WHERE, ORDER BY
SELECT name, city
FROM Customers
WHERE city = 'Delhi'
ORDER BY name;

-- b) Aggregate Function with GROUP BY
SELECT city, COUNT(*) AS total_customers
FROM Customers
GROUP BY city;

-- c) INNER JOIN
SELECT Orders.order_id, Customers.name, Orders.order_date
FROM Orders
INNER JOIN Customers ON Orders.customer_id = Customers.customer_id;

-- d) LEFT JOIN
SELECT Customers.name, Orders.order_id
FROM Customers
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id;

-- e) RIGHT JOIN
SELECT Orders.order_id, Customers.name
FROM Orders
RIGHT JOIN Customers ON Orders.customer_id = Customers.customer_id;

-- f) Subquery - Products more expensive than average
SELECT name
FROM Products
WHERE price > (
    SELECT AVG(price) FROM Products
);

-- g) Average Revenue Per User (ARPU)
SELECT c.customer_id, c.name, AVG(p.amount) AS avg_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.name;

-- h) Create a View - Order Summary
CREATE VIEW OrderSummary AS
SELECT o.order_id, c.name AS customer_name, o.order_date, SUM(oi.quantity * oi.price) AS total_order_value
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY o.order_id, c.name, o.order_date;

-- i) Indexes for Optimization
CREATE INDEX idx_customer_city ON Customers(city);
CREATE INDEX idx_order_date ON Orders(order_date);