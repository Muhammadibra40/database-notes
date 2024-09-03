SELECT  name,
	COUNT(job) AS num
FROM people 
JOIN crew
USING(person_id_
GROUP BY name
ORDER BY num DESC
LIMIT 20;
