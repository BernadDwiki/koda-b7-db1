-- Minitask 4

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

SELECT id, title, release_date, rating, created_at, updated_at, director_id, genre_id
FROM movies
WHERE extract(year FROM release_date) = 2020;

SELECT id, first_name, last_name, created_at, updated_at
FROM actors
WHERE lower(first_name) LIKE '%s';

SELECT id, title, release_date, rating, created_at, updated_at, director_id, genre_id
FROM movies
WHERE rating >= 4.0 AND rating <= 8.0
-- WHERE rating BETWEEN 4.0 AND 8.0
AND release_date BETWEEN '2004-01-01 00:00:00' AND '2010-12-31 23:59:59';
-- AND extract(year FROM release_date) BETWEEN 2004 AND 2010;