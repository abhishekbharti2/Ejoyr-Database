-- Create database
CREATE DATABASE EcommerceDB;
USE EcommerceDB;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address TEXT
);

-- Create Products table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample data
INSERT INTO Customers (name, email, phone, address) VALUES
('John Doe', 'john@example.com', '1234567890', '123 Main St'),
('Jane Smith', 'jane@example.com', '0987654321', '456 Elm St');

INSERT INTO Products (name, price, stock) VALUES
('Laptop', 800.00, 10),
('Phone', 500.00, 20),
('Tablet', 300.00, 15);

INSERT INTO Orders (customer_id, total_amount) VALUES
(1, 1300.00),
(2, 500.00);

INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 800.00),
(1, 3, 1, 300.00),
(2, 2, 1, 500.00);

-- Retrieve order details for a specific customer
SELECT o.order_id, c.name, p.name AS product_name, od.quantity, od.price 
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id
WHERE c.customer_id = 1;
