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
-- Query 6: List the first five employees from the Customer Service Department. Put them in alphabetical order by last name.

-- Query 7: Find out the current salary and department of Berni Genin. You can use the ORDER BY and LIMIT to get just the most recent salary.


-- Step 2: Summary Queries
-- Using the bike database:
USE bike;
-- Query 8: Get the average quantity that we have in all our bike stocks. Round to the nearest whole number.


-- Query 9: 

-- Query 10:

-- Use the employee database to answer the following:
USE employees;
-- Query 11:

-- Query 12:


-- Query 13:



