SELECT  name,       
 	IFNULL(died, 2024) - born AS Age
FROM people 
WHERE born >= 1900
ORDER BY Age DESC, name DESC
LIMIT 20;
