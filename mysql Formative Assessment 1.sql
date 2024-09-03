## 1. Create the following tables inside the database ‘global_store_db’

CREATE DATABASE IF NOT EXISTS global_store_db;
USE global_store_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    quantity INT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_ordered INT,
    order_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

## 2.Alter the products table to add a new column named category (VARCHAR(50)) after the price column. (score : 0.5)

ALTER TABLE products ADD category VARCHAR(50) AFTER price;
select * from products;
##3. Rename the products table to inventory.

ALTER TABLE products RENAME TO inventory;

## 4. Insert at least 10 records into the inventory table and 5 records into orders table and display the tables. (score : 1)
INSERT INTO inventory (name, price, quantity, category) VALUES 
('Laptop', 1000, 20, 'Electronics'),
('Smartphone', 700, 50, 'Electronics'),
('Headphones', 150, 100, 'Accessories'),
('Keyboard', 45, 70, 'Accessories'),
('Monitor', 300, 40, 'Electronics'),
('Mouse', 25, 80, 'Accessories'),
('Tablet', 400, 30, 'Electronics'),
('Charger', 20, 150, 'Accessories'),
('Printer', 200, 10, 'Electronics'),
('Webcam', 80, 60, 'Accessories');
select * from inventory;
INSERT INTO orders (product_id, quantity_ordered, order_date)
VALUES 
(1, 2, '2024-09-01'),
(3, 1, '2024-09-02'),
(5, 4, '2024-09-03'),
(7, 2, '2024-09-04'),
(9, 1, '2024-09-05');

SELECT * FROM orders;

## 5.a) Write a query to display distinct categories from the inventory table.

SELECT DISTINCT category FROM inventory;

## 5.b) Select the top 5 products by their prices in descending order from the inventory table.

SELECT name, price FROM inventory ORDER BY price DESC LIMIT 5;

## 5.c) Display the names of products with a quantity greater than 10 from the inventory table.

SELECT name FROM inventory WHERE quantity > 10;

## 5.d) Use the SUM() function to calculate the total price of all products in the inventory table.

SELECT SUM(price * quantity) AS total_price_of_products FROM inventory;

## 5.e)Group products by their categories and display the count of products in each category.

SELECT category,COUNT(*) AS product_count FROM inventory GROUP BY category;

## 5.f) Write a query to identify products that are currently out of stock (i.e., quantity is zero). Display the product details including the product name and price.

SELECT name, price FROM inventory WHERE quantity = 0;

## 6. Create a view named expensive_products that displays the details of products with a price above the average price of all products
CREATE VIEW expensive_products AS SELECT * FROM inventory WHERE price > (SELECT AVG(price) 
FROM inventory);

select * from expensive_products;

## 7. Write a join query to display the names of products along with the corresponding order quantities from the inventory and orders tables

SELECT inventory.name, orders.quantity_ordered FROM inventory JOIN orders ON inventory.product_id = orders.product_id;
