SELECT 
	to_char(to_timestamp (v.vacancy_month::text, 'MM'), 'TMmonth') AS vacancy_hot_month,
	to_char(to_timestamp (r.resume_month::text, 'MM'), 'TMmonth') AS resume_hot_month
FROM
	(SELECT 
	 	extract(month from created_at) AS vacancy_month, 
	 	count(*) AS vacancy_count 
	 FROM vacancy 
	 GROUP BY vacancy_month
	 ORDER BY vacancy_count desc limit 1
	) AS v,
	(SELECT 
	 	extract(month from created_at) AS resume_month,
	 	count(*) AS resume_count
	 FROM resume
	 GROUP BY resume_month 
	 ORDER BY resume_count desc limit 1
	) AS r
