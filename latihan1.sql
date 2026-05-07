CREATE TABLE products (
    product_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_name VARCHAR(255) NOT NULL,
    price int NOT NULL
)

INSERT INTO products (product_name, price)
VALUES ('Laptop', 1000),
        ('Mouse', 50),
        ('Keyboard', 200);
INSERT INTO products (product_name, price)
VALUES ('Laptop', 2000);
INSERT INTO products (product_name, price)
VALUES ('sepeda', 3000);
table products;

-- menemukan product dengan harga tertinggi, tentukan harga tertinggi dulu baru tampilkan product
SELECT product_name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);


-- menemukan product dengan harga lebih besar dari rata rata
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);