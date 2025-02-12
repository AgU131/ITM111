SELECT fname, lname
FROM artist
WHERE country = "Italy"
ORDER BY lname
LIMIT 2;

SELECT fname, lname, dod - dob AS age_at_death
FROM artist;

SELECT concat(fname, ' ', lname, ' was ', dod-dob, ' years old at death') AS "Death Age"
FROM artist;

SELECT country, local
FROM artist
ORDER BY country;
SELECT DISTINCT country, local
FROM artist
ORDER BY country;

SELECT fname, lname, dod
FROM artist
WHERE dod >=1606;

SELECT fname, lname
FROM artist
WHERE country = "Italy" AND lname = "da Vinci";

SELECT fname, lname
FROM artist
WHERE NOT country = "Italy";

SELECT fname, lname, dod
FROM artist
WHERE dod BETWEEN 1500 AND 1990;

SELECT fname, lname
FROM artist
WHERE lname LIKE 'van%';

SELECT fname, lname
FROM artist
WHERE mname IS NULL
ORDER BY lname DESC;

SELECT fname, lname, country, dob
FROM artist
WHERE country <> "United States"
ORDER BY country, dob;