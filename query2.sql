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
    FOREIGN KEY (director_id) REFERENCES directors(id)
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

-- DQL Data Query Language

-- menampilkan data gabungan antara tabel directors dan genres ke dalam tabel movies, serta membatasi hasil query hanya 50 data pertama
SELECT m.id, m.title, m.release_date, m.rating, d.first_name AS director_first_name, d.last_name AS director_last_name, g.name AS genre_name
FROM movies m
JOIN directors d ON d.id = m.director_id
JOIN genres g ON g.id = m.genre_id
LIMIT 50;

-- menampilkan data gabungan antara tabel movies dan actors berdasarkan tabel asosiasi movie_actors
SELECT m.title, a.first_name AS actor_first_name, a.last_name AS actor_last_name, ma.role
FROM movie_actors ma
JOIN movies m ON m.id = ma.movie_id
JOIN actors a ON a.id = ma.actor_id;