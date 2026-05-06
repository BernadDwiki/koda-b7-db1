-- DDL Data Definition Language

CREATE TABLE movies (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY, 
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    rating float NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP,
    director_id int NOT NULL,
    genre_id int NOT NULL,
    FOREIGN KEY (director_id) REFERENCES directors(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

CREATE TABLE actors (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP
);

CREATE TABLE movie_actors (
    movie_id int NOT NULL,
    actor_id int NOT NULL,
    role VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (actor_id) REFERENCES actors(id)
);

CREATE TABLE directors (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP
);

CREATE TABLE genres (
    id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP
);

INSERT INTO actors (first_name, last_name)
VALUES ('Tom', 'Hanks'),
       ('Meryl', 'Streep'),
       ('Leonardo', 'DiCaprio'),
       ('Scarlett', 'Johansson'),
       ('Brad', 'Pitt'),
       ('Angelina', 'Jolie'),
       ('Johnny', 'Depp'),
       ('Natalie', 'Portman'),
       ('Robert', 'Downey Jr.'),
       ('Jennifer', 'Lawrence');

INSERT INTO directors (first_name, last_name)
VALUES ('Steven', 'Spielberg'),
       ('Christopher', 'Nolan'),
       ('Quentin', 'Tarantino'),
       ('Martin', 'Scorsese'),
       ('James', 'Cameron'),
       ('Ridley', 'Scott'),
       ('David', 'Fincher'), 
       ('Alfred', 'Hitchcock'),
       ('Stanley', 'Kubrick'),
       ('Francis Ford', 'Coppola');

INSERT INTO genres (name)
VALUES ('Action'),
       ('Comedy'),
       ('Drama'),
       ('Horror'),
       ('Science Fiction'),
       ('Romance'),
       ('Thriller'),
       ('Fantasy'),
       ('Documentary'),
       ('Animation');

INSERT INTO movies (title, release_date, rating, director_id, genre_id)
VALUES ('Inception', '2010-07-16', 8.8, 2, 5),
       ('The Godfather', '1972-03-24', 9.2, 10, 3),
       ('Pulp Fiction', '1994-10-14', 8.9, 3, 3),
       ('The Dark Knight', '2008-07-18', 9.0, 2, 1),
       ('Schindler''s List', '1993-12-15', 8.9, 1, 3),
       ('The Shawshank Redemption', '1994-09-23', 9.3, 4, 3),
       ('The Matrix', '1999-03-31', 8.7, 6, 5),
       ('Forrest Gump', '1994-07-06', 8.8, 1, 3),
       ('The Silence of the Lambs', '1991-02-14', 8.6, 7, 7),
       ('The Avengers', '2012-05-04', 8.0, 9, 1),
       ('Titanic', '1997-12-19', 7.8, 5, 2),
       ('Gladiator', '2000-05-05', 8.5, 6, 1),
       ('The Departed', '2006-10-06', 8.5, 4, 7),
       ('The Prestige', '2006-10-20', 8.5, 2, 7);

INSERT INTO movies (title, release_date, rating, director_id, genre_id)
VALUES ('The Grand Budapest Hotel', '2014-03-28', 8.1, 3, 2),
       ('Interstellar', '2014-11-07', 8.6, 2, 5),
       ('Django Unchained', '2012-12-25', 8.4, 3, 1),
       ('The Wolf of Wall Street', '2013-12-25', 8.2, 4, 2),
       ('The Hateful Eight', '2015-12-25', 7.8, 3, 1);

INSERT INTO movie_actors (movie_id, actor_id, role)
VALUES (1, 3, 'Dom Cobb'),
       (2, 5, 'Michael Corleone'),
       (3, 5, 'Vincent Vega'),
       (4, 9, 'Bruce Wayne / Batman'),
       (5, 1, 'Oskar Schindler'),
       (6, 5, 'Andy Dufresne'),
       (7, 9, 'Neo'),
       (8, 1, 'Forrest Gump'),
       (9, 7, 'Dr. Hannibal Lecter'),
       (10, 9, 'Tony Stark / Iron Man'),
       (11, 5, 'Jack Dawson'),
       (12, 3, 'Maximus Decimus Meridius'),
       (13, 5, 'Billy Costigan'),
       (14, 3, 'Alfred Borden');
-- DQL Data Query Language

table movies;
table actors;
table directors;


-- menampilkan list direktor beserta banyaknya genre yang sudah di direct
SELECT d.id, d.first_name, d.last_name, COUNT(m.genre_id) AS genre_count 
FROM directors d
JOIN movies m ON m.director_id = d.id
GROUP BY d.id, d.first_name, d.last_name;

-- menampilkan list aktor dengan peran lebih dari 5
SELECT a.first_name, a.last_name, COUNT(ma.role) AS role_count
FROM actors a
JOIN movie_actors ma ON ma.actor_id = a.id
GROUP BY a.first_name, a.last_name
HAVING COUNT(ma.role) > 2;

-- menampilkan direktor yang paling produktif sepanjang masa
SELECT d.first_name, d.last_name, COUNT(m.id) AS movie_count
FROM directors d
JOIN movies m ON m.director_id = d.id
GROUP BY d.first_name, d.last_name
ORDER BY movie_count DESC
LIMIT 1;

-- menampilkan tahun tersibuk sepanjang masa
SELECT EXTRACT(YEAR FROM release_date) AS release_year, COUNT(id) AS movie_count
FROM movies
GROUP BY release_year
ORDER BY movie_count DESC
LIMIT 1;

-- mendapatkan data movies dengan list actors yang disatukan menjadi satu kolom (dipisahkan dengan koma) dengan menggunakan string_agg
SELECT m.id, m.title, string_agg(a.first_name || ' ' || a.last_name, ', ') AS actors
FROM movies m
JOIN movie_actors ma ON ma.movie_id = m.id
JOIN actors a ON a.id = ma.actor_id
GROUP BY m.id, m.title;

