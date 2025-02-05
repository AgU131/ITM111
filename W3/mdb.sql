CREATE DATABASE mdb;

USE mdb;

CREATE TABLE actors (actor_id INT NOT NULL AUTO_INCREMENT, 
	last_name varchar(30) NOT NULL,
    first_name varchar(25) NOT NULL,
    PRIMARY KEY(actor_id));
    
SELECT * FROM actors;
    
iNSERT INTO actors VALUES 
	(NULL, 'Hanks', 'Tom'), 
    (NULL, 'Allen', 'Tim');

iNSERT INTO actors VALUES 
	(DEFAULT, 'Potts', 'Annie');

iNSERT INTO actors (last_name, first_name) VALUES 
	('Fisher', 'Carrie');

CREATE TABLE movies (movie_id INT NOT NULL auto_increment,
	title varchar(45) NOT NULL,
    rating ENUM('G', 'PG', 'PG-13'),
    r_year YEAR NOT NULL,
    studio VARCHAR(45),
    PRIMARY KEY(movie_id));

SELECT * FROM movies;

-- Toy Story, G, 1995, Pixar

iNSERT INTO movies VALUES 
	(DEFAULT, 'Toy Story', 'G', '1995', 'Pixar');

-- PARA EDITAR
UPDATE actors
SET first_name = 'Tommy'
-- si aca no tuviese el where, afectaria todas las filas de first_name
WHERE actor_id = 1 ;

-- si necesitas cambiar la estructura del statement usas ALTAR

-- para eliminar algo:
DELETE FROM actors
WHERE actor_id = 1;

-- para eliminar una Table
DROP TABLE actors;

-- para eliminar toda la base de datos
DROP DATABASE mdb;

--