-- E-COMMERCE ORDER & INVENTORY ANALYTICS SYSTEM
-- Beginner-friendly portfolio project | MySQL 8.0+
-- Run the full script in MySQL Workbench.
-- WARNING: This recreates the ecommerce_analytics database and deletes
-- any existing database with that name. Remove DROP DATABASE if needed.

DROP DATABASE IF EXISTS ecommerce_analytics;
CREATE DATABASE ecommerce_analytics;
USE ecommerce_analytics;

-- =========================================================
-- 1. TABLES
-- =========================================================

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    city VARCHAR(80) NOT NULL,
    signup_date DATE NOT NULL
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(120) NOT NULL,
    category_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 5,
    active TINYINT(1) NOT NULL DEFAULT 1,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    CHECK (unit_price >= 0),
    CHECK (stock_quantity >= 0),
    CHECK (reorder_level >= 0)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CHECK (order_status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    CHECK (quantity > 0),
    CHECK (unit_price >= 0)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    CHECK (amount >= 0),
    CHECK (payment_status IN ('Pending', 'Paid', 'Failed', 'Refunded'))
);

-- =========================================================
-- 2. SAMPLE DATA
-- =========================================================

INSERT INTO Customers (customer_name, email, city, signup_date) VALUES
('Aarav Sharma', 'aarav@example.com', 'Hyderabad', '2025-01-10'),
('Diya Reddy', 'diya@example.com', 'Vijayawada', '2025-02-15'),
('Rohan Kumar', 'rohan@example.com', 'Hyderabad', '2025-03-01'),
('Meera Das', 'meera@example.com', 'Chennai', '2025-03-18'),
('Ishaan Rao', 'ishaan@example.com', 'Bengaluru', '2025-04-05'),
('Sana Ali', 'sana@example.com', 'Hyderabad', '2025-05-21'),
('Kavya Patel', 'kavya@example.com', 'Pune', '2025-06-09'),
('Vikram Singh', 'vikram@example.com', 'Chennai', '2025-07-12');

INSERT INTO Categories (category_name) VALUES
('Electronics'), ('Accessories'), ('Home');

INSERT INTO Products
(product_name, category_id, unit_price, stock_quantity, reorder_level) VALUES
('Wireless Mouse', 2, 799.00, 4, 5),
('Mechanical Keyboard', 2, 2499.00, 12, 5),
('USB-C Hub', 2, 1799.00, 3, 5),
('Bluetooth Headphones', 1, 3499.00, 8, 4),
('Laptop Stand', 3, 1299.00, 15, 5),
('Webcam', 1, 2899.00, 0, 3),
('Portable SSD', 1, 5999.00, 6, 3),
('Desk Lamp', 3, 999.00, 20, 5),
('HDMI Cable', 2, 399.00, 2, 5),
('Monitor', 1, 12999.00, 5, 2);

INSERT INTO Orders (customer_id, order_date, order_status) VALUES
(1, '2026-01-05', 'Delivered'),
(2, '2026-01-08', 'Delivered'),
(3, '2026-01-12', 'Shipped'),
(1, '2026-02-02', 'Delivered'),
(4, '2026-02-10', 'Cancelled'),
(5, '2026-02-15', 'Processing'),
(6, '2026-03-01', 'Delivered'),
(7, '2026-03-05', 'Pending'),
(2, '2026-03-12', 'Delivered'),
(8, '2026-03-20', 'Shipped'),
(3, '2026-04-02', 'Delivered'),
(6, '2026-04-10', 'Cancelled');

INSERT INTO OrderItems (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 799.00),
(1, 4, 1, 3499.00),
(2, 2, 1, 2499.00),
(2, 9, 3, 399.00),
(3, 3, 1, 1799.00),
(3, 5, 1, 1299.00),
(4, 7, 1, 5999.00),
(4, 1, 1, 799.00),
(5, 10, 1, 12999.00),
(6, 6, 1, 2899.00),
(6, 8, 2, 999.00),
(7, 4, 2, 3499.00),
(7, 9, 2, 399.00),
(8, 3, 2, 1799.00),
(9, 5, 2, 1299.00),
(9, 2, 1, 2499.00),
(10, 10, 1, 12999.00),
(10, 8, 1, 999.00),
(11, 7, 2, 5999.00),
(11, 1, 1, 799.00),
(12, 6, 1, 2899.00);

INSERT INTO Payments
(order_id, payment_date, amount, payment_method, payment_status) VALUES
(1, '2026-01-05', 5097.00, 'UPI', 'Paid'),
(2, '2026-01-08', 3696.00, 'Card', 'Paid'),
(3, '2026-01-12', 3098.00, 'UPI', 'Paid'),
(4, '2026-02-02', 6798.00, 'Card', 'Paid'),
(5, '2026-02-10', 12999.00, 'UPI', 'Refunded'),
(6, '2026-02-15', 4897.00, 'Card', 'Pending'),
(7, '2026-03-01', 7796.00, 'UPI', 'Paid'),
(8, '2026-03-05', 3598.00, 'Cash on Delivery', 'Pending'),
(9, '2026-03-12', 5097.00, 'UPI', 'Paid'),
(10, '2026-03-20', 13998.00, 'Card', 'Paid'),
(11, '2026-04-02', 12797.00, 'UPI', 'Paid'),
(12, '2026-04-10', 2899.00, 'Card', 'Refunded');

-- =========================================================
-- 3. BUSINESS ANALYTICS QUERIES
-- Run each query individually if you want to inspect one result at a time.
-- =========================================================

-- Q1. View all customers
SELECT * FROM Customers;

-- Q2. View all active products and prices
SELECT product_id, product_name, unit_price, stock_quantity
FROM Products
WHERE active = 1;

-- Q3. Products with stock at or below the reorder level
SELECT product_id, product_name, stock_quantity, reorder_level
FROM Products
WHERE stock_quantity <= reorder_level
ORDER BY stock_quantity ASC;

-- Q4. Count products in each category
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- Q5. Total number of orders by status
SELECT order_status, COUNT(*) AS order_count
FROM Orders
GROUP BY order_status
ORDER BY order_count DESC;

-- Q6. Calculate each order's value (quantity * price at order time)
SELECT o.order_id, o.order_date, o.order_status,
       SUM(oi.quantity * oi.unit_price) AS order_value
FROM Orders o
JOIN OrderItems oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, o.order_status
ORDER BY o.order_id;

-- Q7. Customer names and the orders they placed
SELECT c.customer_name, o.order_id, o.order_date, o.order_status
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date;

-- Q8. Total orders per customer, including customers with no orders
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

-- Q9. Revenue from paid orders only; excludes cancelled order status
SELECT SUM(p.amount) AS paid_revenue
FROM Payments p
JOIN Orders o ON p.order_id = o.order_id
WHERE p.payment_status = 'Paid'
  AND o.order_status <> 'Cancelled';

-- Q10. Sales by product (based on non-cancelled orders)
SELECT pr.product_name,
       SUM(oi.quantity) AS units_ordered,
       SUM(oi.quantity * oi.unit_price) AS gross_order_value
FROM Products pr
JOIN OrderItems oi ON pr.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY pr.product_id, pr.product_name
ORDER BY gross_order_value DESC;

-- Q11. Top 5 products by units ordered (excluding cancelled orders)
SELECT pr.product_name, SUM(oi.quantity) AS units_ordered
FROM Products pr
JOIN OrderItems oi ON pr.product_id = oi.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY pr.product_id, pr.product_name
ORDER BY units_ordered DESC, pr.product_name
LIMIT 5;

-- Q12. Customers whose total order value is greater than ₹5,000
SELECT c.customer_name,
       SUM(oi.quantity * oi.unit_price) AS total_order_value
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > 5000
ORDER BY total_order_value DESC;

-- Q13. Monthly order counts
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month,
       COUNT(*) AS total_orders
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;

-- Q14. Payment status summary
SELECT payment_status, COUNT(*) AS payment_count,
       SUM(amount) AS payment_amount
FROM Payments
GROUP BY payment_status;

-- Q15. Customers with no orders
SELECT c.customer_id, c.customer_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q16. Orders with their payment details
SELECT o.order_id, c.customer_name, p.amount,
       p.payment_method, p.payment_status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
LEFT JOIN Payments p ON o.order_id = p.order_id
ORDER BY o.order_id;

-- Q17. Products priced above the average product price
SELECT product_name, unit_price
FROM Products
WHERE unit_price > (SELECT AVG(unit_price) FROM Products)
ORDER BY unit_price DESC;

-- Q18. Rank products by sales value using a window function (MySQL 8+)
SELECT product_name, sales_value,
       DENSE_RANK() OVER (ORDER BY sales_value DESC) AS sales_rank
FROM (
    SELECT pr.product_id, pr.product_name,
           COALESCE(SUM(
               CASE WHEN o.order_status <> 'Cancelled'
                    THEN oi.quantity * oi.unit_price ELSE 0 END
           ), 0) AS sales_value
    FROM Products pr
    LEFT JOIN OrderItems oi ON pr.product_id = oi.product_id
    LEFT JOIN Orders o ON oi.order_id = o.order_id
    GROUP BY pr.product_id, pr.product_name
) AS product_sales
ORDER BY sales_rank, product_name;

-- Q19. Inventory stock value (stock quantity * current unit price)
SELECT SUM(stock_quantity * unit_price) AS inventory_value
FROM Products;

-- Q20. Order detail report with customer, product, quantity, and line total
SELECT o.order_id, c.customer_name, o.order_date,
       pr.product_name, oi.quantity, oi.unit_price,
       (oi.quantity * oi.unit_price) AS line_total, o.order_status
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products pr ON oi.product_id = pr.product_id
ORDER BY o.order_id, oi.order_item_id;

-- =========================================================
-- END OF PROJECT
-- =========================================================
