CREATE TABLE books (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP,
    category_id int NOT NULL,
    book_shelf_id int NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
    FOREIGN KEY (book_shelf_id) REFERENCES book_shelfes(id)
)

CREATE TABLE categories (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    category_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
)

CREATE TABLE book_shelfes (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    shelf_name VARCHAR(255) NOT NULL
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
)

CREATE TABLE officers (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    officer_name VARCHAR(255) NOT NULL
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
)

CREATE TABLE borrowing_records (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    book_id int NOT NULL,
    officer_id int NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (officer_id) REFERENCES officers(id)
)

INSERT INTO books (title, author, published_date, category_id, book_shelf_id)
VALUES ('Laskar Pelangi', 'Andrea Hirata', '2005-01-01', 1, 1),
       ('Bumi Manusia', 'Pramoedya Ananta Toer', '1980-01-01', 2, 2),
       ('Sang Pemimpi', 'Andrea Hirata', '2006-01-01', 1, 1),
       ('Gadis Pantai', 'Pramoedya Ananta Toer', '1985-01-01', 2, 2),
       ('Ayat-Ayat Cinta', 'Habiburrahman El Shirazy', '2004-01-01', 3, 2),
       ('Negeri 5 Menara', 'Ahmad Fuadi', '2009-01-01', 4, 1),
       ('Laut Bercerita', 'Leila S. Chudori', '2013-01-01', 5, 2),
       ('Perahu Kertas', 'Dewi Lestari', '2009-01-01', 6, 1),
       ('Supernova: Ksatria, Puteri, dan Bintang Jatuh', 'Dewi Lestari', '2001-01-01', 7, 2),
       ('Supernova: Akar', 'Dewi Lestari', '2012-01-01', 8, 1);

INSERT INTO categories (category_name)
VALUES ('Fiction'),
       ('Non-Fiction'),
       ('Science Fiction'),
       ('Fantasy'),
       ('Biography'),
       ('History'),
       ('Self-Help'),
       ('Romance'),
       ('Thriller'),
       ('Mystery');

INSERT INTO book_shelfes (shelf_name)
VALUES ('Shelf A'),
       ('Shelf B');

INSERT INTO officers (officer_name)
VALUES ('Officer 1'),
       ('Officer 2');

INSERT INTO borrowing_records (book_id, officer_id, borrow_date, return_date)
VALUES (1, 1, '2024-01-01', '2024-01-15'),
       (2, 2, '2024-01-05', NULL),
       (3, 1, '2024-01-10', '2024-01-20'),
       (4, 2, '2024-01-15', NULL),
       (5, 1, '2024-01-20', '2024-01-30'),
       (6, 2, '2024-01-25', NULL),
       (7, 1, '2024-01-30', '2024-02-10'),
       (8, 2, '2024-02-05', NULL),
       (9, 1, '2024-02-10', '2024-02-20'),
       (10, 2, '2024-02-15', NULL);