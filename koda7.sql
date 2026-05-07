CREATE TABLE users (
    id SERIAL PRIMARY KEY, // postgresql only auto increment
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    age INT NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

ALTER TABLE users 
ADD COLUMN updated_at TIMESTAMP;  

ALTER TABLE users
ALTER COLUMN photo VARCHAR(255);

ALTER TABLE users
ALTER COLUMN photo SET DEFAULT 'https://example.com/default-profile.png';

ALTER TABLE users
AlTER COLUMN updated_at SET DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE users
AlTER COLUMN gender CHAR(1) CHECK gender IN ('M', 'F') NOT NULL;

CREATE TABLE posts (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) 
);

INSERT INTO users (username, email, age, password_hash) 
VALUES ('yenyen', 'yenyen@example.com', 25, 'hashed_password'),
       ('soby', 'soby@example.com', 30, 'hashed_password');

table users;

UPDATE users
SET age = 26
WHERE username = 'yenyen' OR username = 'soby';

DELETE FROM users
WHERE username = 'soby';

DELETE FROM users
WHERE username = 'john_doe';

INSERT INTO users (username, email, age, password_hash) 
VALUES ('kasino', 'kasino@example.com', 28, 'hashed_password');
INSERT INTO users (username, email, age, password_hash)
VALUES ('soby', 'soby@example.com', 30, 'hashed_password');
INSERT INTO users (username, email, age, password_hash)
VALUES ('susilo', 'susilo@example.com', 30, 'hashed_password');

SELECT currval('users_id_seq');

INSERT INTO posts (user_id, title, content)
VALUES (2, 'My First Post', 'This is the content of my first post.');


CREATE TABLE books (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY, // standard SQL auto increment
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP 
);

INSERT INTO books (title, author, published_date)
VALUES ('The Great Gatsby', 'F. Scott Fitzgerald', '1925-04-10');

table books;

SELECT currval('books_id_seq');

-- DQL Data Query Language

SELECT id, username, email, age AS "umur", created_at, updated_at
FROM users;
-- SELECT * FROM users;

SELECT DISTINCT age -- digunakan untuk menghilangkan duplikasi data, huruf besar dan kecil dianggap beda
FROM users; 

SELECT u.id, u.username, u.email, u.age AS "umur", u.created_at, u.updated_at
FROM users u
WHERE u.age > 27 AND age IS NOT NULL
ORDER BY umur ASC, username DESC -- umur dulu baru username, umur harus tetap ASC
LIMIT 1  OFFSET 1; -- skip 1 data pertama, ambil data ke 2

SELECT u.id, u.username, u.email, u.age AS "umur", u.created_at, u.updated_at
FROM users u
WHERE extract(day FROM u.created_at) = 5
AND extract(month FROM u.created_at) = 5
--WHERE created_at BETWEEN '2026-05-05 00:00:00' AND '2026-05-05 23:59:59';

SELECT username
FROM users
WHERE username LIKE '%o%'; -- mencari username yang mengandung huruf "o"

SELECT username
FROM users
WHERE lower(username) LIKE lower('%O%'); -- mencari username yang mengandung huruf "o" (case-insensitive)

-- joining tables

-- market
-- product category dan supplier saling berelasi dengan product
ALTER TABLE products
ADD FOREIGN KEY (category_id) REFERENCES categories(id);

-- menampilkan nama produk beserta nama kategorinya
SELECT p.id, p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.id
ORDER BY p.id ASC;

-- menampilkan nama produk beserta nama kategorinya, termasuk produk yang tidak memiliki kategori
SELECT p.id, p.product_name, c.category_name
FROM products p
LEFT JOIN categories c ON p.category_id = c.id
ORDER BY p.id ASC;

-- menampilkan nama produk beserta nama kategorinya, termasuk kategori yang tidak memiliki produk
SELECT p.id, p.product_name, c.category_name
FROM products p
RIGHT JOIN categories c ON p.category_id = c.id
ORDER BY p.id ASC;

-- menampilkan nama produk beserta nama kategorinya, termasuk produk yang tidak memiliki kategori dan kategori yang tidak memiliki produk
SELECT p.id, p.product_name, c.category_name
FROM products p
FULL JOIN categories c ON p.category_id = c.id
ORDER BY p.id ASC;

-- menampilkan nama produk beserta nama kategorinya dan nama suppliernya, termasuk produk yang tidak memiliki kategori dan supplier
SELECT p.id, p.product_name, c.category_name, s.supplier_name
FROM products p
JOIN categories c ON p.category_id = c.id
LEFT JOIN suppliers s ON p.supplier_id = s.id -- menampilkan semua produk, termasuk yang tidak memiliki supplier
ORDER BY p.id ASC;

-- menampilkan nama produk beserta nama kategorinya dan nama suppliernya, termasuk supplier yang tidak memiliki produk
SELECT p.id, p.product_name, c.category_name, s.supplier_name   
FROM products p
JOIN categories c ON p.category_id = c.id
RIGHT JOIN suppliers s ON p.supplier_id = s.id -- menampilkan semua supplier, termasuk yang tidak memiliki produk
ORDER BY p.id ASC;


-- transaction
-- ada tabel students, products, transactions, dan transactions_products
-- students ke transactions itu one to many, products ke transactions itu many to many melalui tabel transactions_products, transactions ke products itu many to many melalui tabel transactions_products
-- table transactions_products berisi transaksi id, produk id, jumlah
-- relasi many to many antara transactions dan products

-- mulai dari tabel asosiasi (transactions_products), tampilkan id transaksi, nama siswa, nama produk, dan jumlahnya
SELECT t.id, s.name, p.name, tp.qty
FROM transactions_products tp
JOIN transactions t ON t.id = tp.transaction_id -- menampilkan semua transaksi, termasuk yang tidak memiliki produk
JOIN students s ON s.id = t.student_id  -- menampilkan semua siswa, termasuk yang tidak memiliki transaksi
JOIN products p ON p.id = tp.product_id ; -- menampilkan semua transaksi, termasuk yang tidak memiliki produk, dan semua siswa, termasuk yang tidak memiliki transaksi


-- Agregasi

-- ada tabel user
SELECT count(*), age FROM users -- count(age) tidak menghitung null, sedangkan count(*) menghitung semua baris
GROUP BY age -- menghitung jumlah baris dalam tabel users berdasarkan umur
HAVING count(*) > 3; -- menampilkan hanya umur yang memiliki lebih dari 3 pengguna

SELECT count(*), age FROM users
WHERE age > 25 -- menghitung jumlah baris dalam tabel users berdasarkan umur yang lebih dari 25
GROUP BY age;

INSERT INTO users (username, age, email)
VALUES ('harun', 28, 'harun@example.com'),
       ('susan', 28, 'susan@example.com'),
       ('budi', 28, 'budi@example.com');

SELECT MAX(age) FROM users; -- menampilkan umur tertua
SELECT MIN(age) FROM users; -- menampilkan umur termuda


CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP
);

CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP
);

CREATE TABLE scores (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    score INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

-- 
SELECT st.name, SUM(sc.score) AS total_score
FROM scores sc
JOIN students st ON st.id = sc.student_id
GROUP BY st.name
ORDER BY st.name ASC;

-- menghitung rata-rata nilai untuk setiap siswa
SELECT st.name, AVG(sc.score) AS average_score
FROM scores sc
JOIN students st ON st.id = sc.student_id
GROUP BY st.name
ORDER BY st.name ASC;

-- menghitung rata-rata nilai untuk setiap mata pelajaran
SELECT s.name AS subject_name, AVG(sc.score) AS average_score
FROM scores sc
JOIN subjects s ON s.id = sc.subject_id
GROUP BY s.name
HAVING AVG(sc.score) > 75.0;

-- menghitung rata-rata nilai untuk mata pelajaran Matematika
SELECT s.name AS subject_name, AVG(sc.score) AS average_score
FROM scores sc
JOIN subjects s ON s.id = sc.subject_id
WHERE s.name = 'Matematika'
GROUP BY s.name

-- menghitung rata-rata nilai untuk setiap mata pelajaran, tetapi hanya menampilkan mata pelajaran yang memiliki rata-rata nilai lebih dari 75.0
SELECT st.name, sc.score, s.name AS subject_name
FROM scores sc
JOIN students st ON st.id = sc.student_id
JOIN subjects s ON s.id = sc.subject_id
WHERE s.name = 'Bahasa Indonesia' ;

-- memcari rerata siswa yang berada diatas rerata kumulatif

-- merupakan subquery untuk menghitung rata-rata kumulatif dari semua nilai, single row subquery
SELECT AVG(score) AS average_score
FROM scores;

SELECT s.name AS subject_name, AVG(sc.score) AS average_score
FROM scores sc
JOIN subjects s ON s.id = sc.subject_id
GROUP BY s.name
HAVING AVG(sc.score) > (SELECT AVG(score) AS average_score FROM scores); -- subquery dijalankan duluan
ORDER BY s.name ASC;

SELECT d.id, COUNT(m.id) AS movie_count
FROM directors d
JOIN movies m ON m.director_id = d.id
GROUP BY d.id;

SELECT d.first_name, d.last_name, sq.total
FROM (SELECT director_id, COUNT(id) AS total
      FROM movies
      GROUP BY director_id) AS sq
JOIN directors d ON d.id = sq.director_id;

SELECT first_name, last_name
FROM directors d
WHERE id IN (
    SELECT d.id
    FROM movies m
    JOIN directors d ON m.director_id = d.id
    GROUP BY d.id
    HAVING COUNT(m.id) > 5
)

SELECT su.name

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

SELECT e1.id, e1.employee_name, e1.salary, e1.department_id
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id -- per deprtment, klo beda department tidak dihitung
);

SELECT employee_name, salary, (SELECT AVG(salary) FROM employees) AS average_salary
FROM employees;
 
SELECT e1.employee_name, e1.salary, e2.average_salary
FROM employees e1,
(SELECT AVG(salary) AS average_salary FROM employees) e2;


-- CTE sales
CREATE TABLE sales (
    product_id INT,
    sales_amount INT
);

INSERT INTO sales (product_id, sales_amount)
VALUES (1, 100),
       (2, 200),
       (1, 300);

table sales;

WITH recap AS (
    SELECT product_id, SUM(sales_amount) AS total_sales
    FROM sales
    GROUP BY product_id
)
SELECT product_id, total_sales
FROM recap
WHERE total_sales = (SELECT MAX(total_sales) FROM recap);