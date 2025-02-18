-- Practce W6 Video - SubQueries

USE world;
SELECT
	name, population
FROM
	country
WHERE
	name = 'Russian Federation';
    
    
SELECT name, population
FROM country
WHERE population >146934000;

-- Aca vemos los subqueries. Ya que son mucho mas utiles y efectivos que el codigo anterior
-- en vez de buscar el valor de algo por separado y despues usarlo para comparar con otro valor, buscamos ese valor dentro de la funcion que lo compara (este ej.: Rusia)

SELECT name, population
FROM country
WHERE population > (SELECT population	-- nuestro subquery esta en () para que pase primero
			FROM country
			WHERE name = 'Russian Federation')
ORDER BY name;


SELECT name,
	CONCAT(ROUND(100 * population /
    (SELECT population
	FROM country
	WHERE name = 'Germany'),
    3), '%') AS porcentaje
FROM country
WHERE continent = 'Europe';



-- Example 3 Create a duplicate table

CREATE TABLE city_bak
AS SELECT * FROM city;

SELECT * 
FROM city_bak 
WHERE countrycode IN 
	(SELECT code
    FROM country
    WHERE region = 'Central Africa');
    
-- podriamos hacer esto en vez de lo anterior, pero no queremos obtener el resultado que buscamos de manera independiente sino hacerlo en un subquery
SELECT *
    FROM country
    WHERE region = 'Central Africa';
    
 
DELETE FROM city_bak 
WHERE countrycode 
IN (SELECT code
    FROM country
    WHERE region = 'Central Africa');
-- no podemos hacer esto sin desactivar el modo seguro antes: Edit -> Preferences -> SQL Editor -> Safe Updates. Y al hacer eso debemos restart mis servers (cerrar la app y volverla a abrir)

-- eliminar la table temporal que hicimos. data definition lenguage

DROP TABLE city_bak;

    
    
    
    
    
    
    
    