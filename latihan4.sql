CREATE TABLE Products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    price INT
)

CREATE TABLE Sales2 (
    id SERIAL PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(id)
)

INSERT INTO Products (name, price)
VALUES ('Laptop', 1000),
('Phone', 600),
('Tablet', 400);

TABLE products;

INSERT INTO Sales2 (product_id, quantity)
VALUES (1, 5),
(2, 10),
(3, 7),
(1, 3);

TABLE Sales2;

-- cari total penjualan dari masing masing product yang minimal terjual 7 unit

WITH total AS (
    SELECT p.name, SUM(s.quantity) AS total_qty, SUM(s.quantity * p.price) AS total_sales
    FROM Sales2 s
    JOIN Products p ON s.product_id = p.id
    GROUP BY p.name
)

SELECT name, total_qty, total_sales
FROM total
WHERE total_qty >= 7;



