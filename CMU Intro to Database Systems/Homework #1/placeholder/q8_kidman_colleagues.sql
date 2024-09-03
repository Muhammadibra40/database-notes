SELECT DISTINCT name
FROM people p 
JOIN crew c
USING(person_id)
WHERE c.title_id IN (SELECT  t.title_id
		      FROM titles t
		      JOIN crew c
		      USING(title_id)
		      JOIN people p	
		      USING(person_id)
		      WHERE p.name = 'Nicole Kidman')
AND c.category IN ('actor', 'actress'); 
