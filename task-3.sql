SELECT
	area_id,
	AVG(salary_from)::int AS salary_min_avg, 
	AVG(salary_to)::int AS salary_max_avg,
	AVG(salary_avg)::int AS salary_mid_avg
FROM 
	(SELECT
	area_id, 
	salary_from, 
	salary_to,
 	(salary_from + salary_to)/2 AS salary_avg
-- 	NULLIF((COALESCE(salary_from, salary_to,0) + COALESCE(salary_to,salary_from,0))/2, 0) AS salary_avg
	FROM 
		(SELECT 
			area_id, 
			(salary_from*(1 - 0.13*salary_gross::int))::int AS salary_from, 
			(salary_to*(1 - 0.13*salary_gross::int))::int AS salary_to
		FROM vacancy_body)
		AS vb) 
	AS vb
GROUP BY area_id;
