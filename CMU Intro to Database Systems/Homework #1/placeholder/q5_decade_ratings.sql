SELECT  CONCAT(premiered / 10 * 10, 's') AS Decade,
	AVG(rating) AS average,
	MAX(rating),
	MIN(rating),
	COUNT(premiered)
FROM titles t
JOIN ratings r
USING(title_id)
WHERE premiered IS NOT NULL
GROUP BY Decade
ORDER BY average DESC, Decade;	
