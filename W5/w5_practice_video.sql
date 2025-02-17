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

    




