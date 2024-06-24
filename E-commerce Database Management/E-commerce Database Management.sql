-- Create the database --
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

	-- Create the products table --
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

	-- Create the customers table --
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    address TEXT,
    phone VARCHAR(15)
);

	-- Create the orders table --
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

	-- Create the order_items table --
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into products table --
INSERT INTO products (name, description, price, stock_quantity)
VALUES 
('Laptop', 'High performance laptop', 1200.00, 10),
('Smartphone', 'Latest model smartphone', 800.00, 15),
('Headphones', 'Noise-cancelling headphones', 150.00, 30),
('Monitor', '4K UHD Monitor', 300.00, 20),
('Keyboard', 'Mechanical keyboard', 100.00, 50),
('Mouse', 'Wireless mouse', 50.00, 60),
('Printer', 'All-in-one printer', 200.00, 25),
('Tablet', 'Latest model tablet', 400.00, 30),
('Speaker', 'Bluetooth speaker', 70.00, 40),
('External Hard Drive', '1TB external hard drive', 90.00, 35);

-- Insert data into customers table --
INSERT INTO customers (name, email, address, phone)
VALUES 
('Alice Johnson', 'alice.johnson@example.com', '123 Main St', '123-456-7890'),
('Bob Smith', 'bob.smith@example.com', '456 Elm St', '987-654-3210'),
('Carol White', 'carol.white@example.com', '789 Oak St', '555-123-4567'),
('David Brown', 'david.brown@example.com', '321 Pine St', '555-987-6543'),
('Eva Green', 'eva.green@example.com', '654 Maple St', '555-555-5555'),
('Frank Black', 'frank.black@example.com', '987 Birch St', '444-444-4444'),
('Grace Blue', 'grace.blue@example.com', '222 Cedar St', '333-333-3333'),
('Henry Yellow', 'henry.yellow@example.com', '111 Walnut St', '222-222-2222'),
('Ivy Red', 'ivy.red@example.com', '333 Cherry St', '111-111-1111'),
('Jack Orange', 'jack.orange@example.com', '444 Spruce St', '999-999-9999');

-- Insert data into orders table --
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES 
(1, '2024-06-01', 1350.00),
(2, '2024-06-10', 800.00),
(3, '2024-06-15', 450.00),
(4, '2024-06-20', 600.00),
(5, '2024-06-25', 150.00),
(6, '2024-06-30', 300.00),
(7, '2024-07-05', 100.00),
(8, '2024-07-10', 200.00),
(9, '2024-07-15', 500.00),
(10, '2024-07-20', 90.00);

-- Insert data into order_items table --
INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES 
(1, 1, 1, 1200.00),
(1, 3, 1, 150.00),
(2, 2, 1, 800.00),
(3, 4, 1, 300.00),
(3, 5, 1, 100.00),
(4, 6, 1, 50.00),
(4, 7, 1, 200.00),
(5, 8, 1, 400.00),
(6, 9, 1, 70.00),
(6, 10, 1, 90.00);


-- Queries --

-- Select all products --
SELECT * FROM products;

-- Find products by price range --
SELECT * FROM products
WHERE price BETWEEN 100.00 AND 1000.00;

-- Add a new product --
INSERT INTO products (name, description, price, stock_quantity)
VALUES ('Webcam', 'HD webcam', 120.00, 20);

-- Update stock quantity of a product --
UPDATE products
SET stock_quantity = 30
WHERE product_id = 3;

-- Delete a product -- NW(Because of Parent)
DELETE FROM products
WHERE product_id = 3;

-- List all customers --
SELECT * FROM customers;

-- List all orders --
SELECT * FROM orders;

-- List all orders for a specific customer --
SELECT orders.order_id, orders.order_date, orders.total_amount
FROM orders
WHERE orders.customer_id = 1;

SELECT order_id,order_date,total_amount FROM orders WHERE order_id = 1;

-- List all items in a specific order --
SELECT order_items.order_item_id, products.name, order_items.quantity, order_items.price
FROM order_items
JOIN products ON order_items.product_id = products.product_id
WHERE order_items.order_id = 1;
