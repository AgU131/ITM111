-- W05 Assignment: Joining and Summarizing Data
-- Agustin Heredia

-- Step1: Joins
-- v_art Database:
USE v_art;
SELECT * FROM artist;
SELECT * FROM artwork;

-- Query 1: search by Period/Style and you choose Impressionism, you get two resulting images ("Woman in the Garden" and "Irises"). What query would be used in the code here to allow the user to see these images? No join is needed. 
SELECT artfile FROM artwork
WHERE period = "Impressionism";

-- Query 2: search by Subject and type in the word flower, you get three images. What query would have allowed the user to get those results (remember, the keyword might have been 'flowers' but they typed 'flower') .
SELECT artfile FROM artwork
	JOIN artwork_keyword
    ON artwork.artwork_id = artwork_keyword.artwork_id
	JOIN keyword
    ON artwork_keyword.keyword_id = keyword.keyword_id
WHERE keyword.keyword REGEXP 'flower';

-- Query 3: List all the artists from the artist table, but only the related artwork from the artwork table. We need the first name, last name, and artwork title. 
SELECT fname, lname, title
FROM artist
	LEFT JOIN artwork 
	ON artwork.artist_id = artist.artist_id ;


-- Magazine Database:
USE magazine;
SELECT * FROM magazine;
SELECT * FROM subscriber;
SELECT * FROM subscription;

-- Query 4: List all subscriptions with the magazine name, last name, first name, and sort alphabetically by magazine name. 
SELECT magazineName, subscriberLastName, subscriberFirstName
FROM magazine m
    JOIN subscription sub
	ON m.magazineKey = sub.magazineKey
	JOIN subscriber s
    ON sub.subscriberKey = s.subscriberKey
ORDER BY magazineName;

-- Query 5: List all the magazines that Samantha Sanders subscribes to.
SELECT magazineName
FROM magazine m
    JOIN subscription sub
	ON m.magazineKey = sub.magazineKey
	JOIN subscriber s
    ON sub.subscriberKey = s.subscriberKey
WHERE subscriberFirstName = 'Samantha' AND subscriberLastName = 'Sanders';


-- Employee Database:
USE employees;
SELECT * FROM departments;

-- Query 6: List the first five employees from the Customer Service Department. Put them in alphabetical order by last name.
SELECT first_name, last_name
FROM employees  e
	JOIN dept_emp de
    ON e.emp_no = de.emp_no
	JOIN departments d
    ON de.dept_no = d.dept_no
WHERE d.dept_no = 'd009'
ORDER BY last_name
LIMIT 5;

-- Query 7: Find out the current salary and department of Berni Genin. You can use the ORDER BY and LIMIT to get just the most recent salary.
SELECT first_name, last_name, dept_name, salary, s.from_date
FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
	JOIN employees e    
    ON e.emp_no = de.emp_no
	JOIN salaries s
    ON e.emp_no = s.emp_no
WHERE first_name = 'Berni' AND last_name = 'Genin'
ORDER BY DATE(s.from_date) DESC 
LIMIT 1;


-- Step 2: Summary Queries
-- Using the bike database:
USE bike;
SELECT * FROM product;
SELECT * FROM stock;
SELECT * FROM store;

-- Query 8: Get the average quantity that we have in all our bike stocks. Round to the nearest whole number.
SELECT ROUND(AVG(quantity)) AS "Stock Average"
FROM stock;

-- Query 9: 
SELECT p.product_name
FROM product p
    JOIN stock s 
    ON p.product_id = s.product_id
WHERE s.quantity = 0  -- Filtra solo los productos sin stock que vendrian a ser los que necesitan ser reordenados
GROUP BY p.product_name  -- Evita duplicados
ORDER BY p.product_name;

-- Query 10: How many of each category of bikes do we have in stock (inventory) at our "Baldwin Bikes" store, which has the store_id of 2. We need to see the name of the category as well as the number of bikes we have in inventory in the category. Sort by lowest inventory items first. 
SELECT c.category_name, SUM(quantity) AS inStock
FROM category c
	JOIN product p
    ON c.category_id = p.category_id
	JOIN stock s
    ON p.product_id = s.product_id
    JOIN store st
    ON s.store_id = st.store_id
WHERE st.store_id = 2
GROUP BY c.category_name
HAVING SUM(quantity) > 0 -- añadi ese >0 solo por una sugerencia de gpt
ORDER BY inStock;


-- Use the employee database to answer the following:
USE employees;

-- Query 11: How many employees do we have? (3 points)
SELECT COUNT(emp_no) FROM employees;

-- Query 12: Get the average salaries in each department. We only need those departments that have average salaries that are below 60,000. Format the salary to 2 decimal places and a comma in the thousands place. 
SELECT dept_name, FORMAT(AVG(salary), 2) AS average_salary
FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
	JOIN employees e
    ON de.emp_no = e.emp_no
    JOIN salaries s
    ON e.emp_no = s.emp_no
GROUP BY dept_name
HAVING AVG(salary) < 60000;

-- Query 13: Find out how many females work in each department. Sort by department name.
SELECT dept_name, COUNT(e.emp_no) AS "Number of Females"
FROM departments d
	JOIN dept_emp de
    ON d.dept_no = de.dept_no
	JOIN employees e
    ON de.emp_no = e.emp_no
WHERE e.gender = 'F'
GROUP BY dept_name
ORDER BY dept_name;

