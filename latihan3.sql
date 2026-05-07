CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id int,
    product VARCHAR(50),
    quantity int,
    price_per_unit float
)

INSERT INTO sales (customer_id, product, quantity, price_per_unit)
VALUES (101, 'Keyboard', 2, 25.00),
(102, 'Mouse', 1, 15.00),
(101, 'Monitor', 1, 200.00),
(103, 'Keyboard', 1, 25.00),
(101, 'Mouse', 3, 15.00);

TABLE sales;

-- cari customer yang membeli keyboard dengan total harga pembelian keyboard lebih dari 30
WITH recap AS (
    SELECT customer_id, product, quantity * price_per_unit AS total_sales
    FROM sales
)
SELECT customer_id, total_sales
FROM recap
WHERE product = 'Keyboard' AND total_sales > 30;

-- cari product yang hanya terjual 1 kali dan siapa pembelinya
WITH recap AS (
    SELECT customer_id, product, quantity * price_per_unit AS total_sales
    FROM sales
)
SELECT customer_id, product
FROM recap
WHERE product IN ( -- ambil product yang hanya terjual 1 kali
    SELECT product 
    FROM recap
    GROUP BY product
    HAVING COUNT(*) = 1
);
