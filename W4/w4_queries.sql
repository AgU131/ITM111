-- W04 Assignment: Single Table Queries 
-- Agustin Heredia

-- Step1: Virtual Art Gallery Application Queries:
SELECT * FROM artist;

-- Query 1: add Vermeer's info
INSERT INTO artist VALUES
	(NULL, 'Johannes', NULL, 'Vermeer', 1632, 1674, 'Netherlands', 'n');
    
-- Query 2: see all artists and info by lname
SELECT *
FROM artist
ORDER BY lname;

-- Query 3: edit Vermeer's dod from 1674 to 1675
UPDATE artist SET `dod` = '1675' 
WHERE artist_id = 9;

-- Query 4: delete Vermeer's row
DELETE FROM artist
WHERE artist_id = 9;

-- Step 2: Bike Shop Queries:
SELECT * FROM customer;

-- Query 5: customer's info from Houston
SELECT first_name, last_name, phone
FROM customer
WHERE city = "Houston";

-- Query 6: 500 off of all bikes with a price higer than 5000
SELECT product_name, list_price, list_price - 500 AS 'Discount Price'
FROM product
WHERE list_price >= 5000
ORDER BY list_price DESC;

-- Query 7: list of all the staff & email who are not from your store
SELECT first_name, last_name, email
FROM staff
WHERE store_id <> 1;

-- Query 8: list of all the bikes with the word 'spider'
SELECT product_name, model_year, list_price
FROM product
WHERE product_name REGEXP 'spider';

-- Query 9: list all bike with a price from $500–$550. lowest price first
SELECT product_name, list_price
FROM product
WHERE list_price BETWEEN 500 AND 550
ORDER BY list_price;

-- Query 10: customer's info who has a phone,and city has the letters 'ach' or 'och',or last name is William
SELECT first_name, last_name, phone, street, city, state, zip_code
FROM customer
WHERE phone IS NOT NULL AND city REGEXP 'ach|och' OR last_name = "William"
LIMIT 5;

-- Query 12: divide the price 2019 bike's into 3 payments
SELECT product_name, CONCAT('$', FORMAT(list_price / 3, 2, 'en_US')) AS "One of 3 payments"
FROM product
WHERE product_name LIKE '%2019';

-- Step 3: Magazine Database:
SELECT * FROM magazine;

-- Query 13: take 3% off the magazine prices
SELECT magazineName, ROUND(magazinePrice*0.97,2) AS "3% off"
FROM magazine;

-- Query 14: subscription's years
SELECT subscriberKey, ROUND(DATEDIFF('2020-12-20', subscriptionStartDate)  / 365, 0) AS "Years since subscription"
FROM subscription;

-- Query 15: how long their subscription will go
SELECT subscriptionStartDate, subscriptionLength, DATE_FORMAT(DATE_ADD(subscriptionStartDate, INTERVAL subscriptionLength MONTH), '%M %D, %Y') 
AS "Subscription end"
FROM subscription;

