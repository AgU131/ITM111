-- W5 Practice JOINTS
USE v_art;

SELECT artist_id, title
FROM artwork;

SELECT *
FROM artwork;

-- this returns every combinaton of a row table from one table, with every row from the other table
SELECT fname, lname, title
FROM artwork 
	JOIN artist  -- es lo mismo INNER JOIN que JOIN solo
	ON artwork.artist_id = artist.artist_id ;
    -- USING (artist_id); esto haria lo mismo que ON, pero los keys tienen que ser =

-- aca todavia necesitamos el JOIN porque noestro WHERE esta usando una columna de otra table
SELECT title
FROM artwork 
	JOIN artist
	ON artwork.artist_id = artist.artist_id
WHERE lname = "da Vinci";

USE bike;

SELECT product_name, category_name, brand_name, list_price
FROM product 		-- aca le podemos dar alias a las tables, y debemos despues usar su alias en todos lados. y se usaria asi: FROM product p   y asi p seria su alias
	JOIN category
	ON product.category_id = category.category_id
    JOIN brand
    ON product.brand_id = brand.brand_id
WHERE category_name = "Children Bicycles";

-- en estos casos cuando esta la misma key que uso, y la llamo a esa key. debo especificar de donde la saco con el mismo formato de los ON. con el nombre del table un punto (.) y el nombre de la key. como esta en el WHERE
SELECT * FROM brand;
SELECT first_name, last_name, store.store_id
FROM staff
	JOIN store
	ON staff.store_id = store.store_id
WHERE staff.store_id = 3;


SELECT title FROM artwork a
	JOIN artwork_keyword ak
    ON a.artwork_id = ak.artwork_id
	JOIN keyword k
    ON ak.keyword_id = k.keyword_id
WHERE keyword = 'water';


USE employees;
SELECT first_name, last_name, dept_name, salary, s.from_date  -- aca uso el alias de salaries en vez de el nombre de la table
FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
	JOIN employees e    
    ON e.emp_no = de.emp_no
	JOIN salaries s
    ON e.emp_no = s.emp_no
WHERE s.from_date > '200-12-31';


USE world;
SELECT * FROM country;
SELECT * FROM city;

SELECT name FROM city;
-- probando primary keys que no son numeros y no son iguales entre algunos
SELECT co.name, ci.name 
FROM city ci
	JOIN country co
    ON code = countrycode;
    
-- aca sabemos todos lo productos que x apellido compro, en un tremendo database con muchas tables
USE bike;
SELECT product_name, order_date
FROM customer c
	JOIN cust_order co
    ON c.customer_id = co.customer_id
	JOIN cust_order_item coi
    ON co.cust_order_id = coi.cust_order_id
	JOIN product p
    ON coi.product_id = p.product_id
WHERE last_name = 'Baldwin';


-- 2nd Video
USE magazine;
SELECT magazineName, magazinePrice, subscriptionStartDate, subscriberFirstName
FROM magazine m
    RIGHT JOIN subscription s
	ON m.magazineKey = s.magazineKey
	RIGHT JOIN subscriber sr
    ON s.subscriberKey = sr.subscriberKey
UNION
SELECT magazineName, magazinePrice, subscriptionStartDate, subscriberFirstName
FROM magazine m
    LEFT JOIN subscription s
	ON m.magazineKey = s.magazineKey
	LEFT JOIN subscriber sr
    ON s.subscriberKey = sr.subscriberKey;
    
    
-- 3RD Video

USE v_art;
SELECT COUNT(country), country
FROM artist
WHERE country = 'France';


USE bike;

SELECT SUM(list_price), MAX(list_price), MIN(list_price)
FROM product;

SELECT AVG(list_price)
FROM product
WHERE model_year = 2017;

SELECT model_year, AVG(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year;

SELECT model_year, SUM(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP;  -- esto le da una celda final con el avg de las anteriores

SELECT model_year, COUNT(list_price)
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP
HAVING AVG(list_price) > 4000;  -- EL HAVING FILTRA DESPUES DE QUE LOS GRUPOS FUERON CREADOS

SELECT model_year, FORMAT(AVG(list_price), 2)  -- format convierte los numeros a string, porque les agrega esa coma en el medio
FROM product
WHERE list_price > 2800
GROUP BY model_year WITH ROLLUP
HAVING AVG(list_price) > 4000;

SELECT model_year, FORMAT(AVG(list_price), 2)
FROM product
WHERE product_name LIKE "%speed%"
GROUP BY model_year WITH ROLLUP
HAVING AVG(list_price) > 300;



USE magazine;

SELECT magazineName, COUNT(subscriberKey) AS suscribers
FROM magazine m
	JOIN subscription sn
    ON m.magazineKey = sn.magazineKey
GROUP BY magazineName
HAVING suscribers >= 2;


USE bike;

SELECT store_name, product_name, SUM(quantity)
FROM store s
	JOIN stock st
		ON s.store_id = st.store_id
	JOIN product p
		ON st.product_id = p.product_id
GROUP BY product_name, store_name WITH ROLLUP;

SELECT store_name, product_name, SUM(quantity)
FROM store s
	JOIN stock st
		ON s.store_id = st.store_id
	JOIN product p
		ON st.product_id = p.product_id
WHERE product_name LIKE "Electra Cruiser 1 Ladies%"
GROUP BY product_name, store_name WITH ROLLUP;



