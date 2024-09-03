SELECT t.primary_title,
       r.votes
FROM people p
JOIN crew c
USING(person_id)
JOIN titles t
USING(title_id)
JOIN ratings r
USING(title_id)
WHERE p.name LIKE '%Cruise%'
AND p.born = 1962
GROUP by t.primary_title
ORDER BY votes DESC
LIMIT 10;

