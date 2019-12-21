SELECT 
to_char(to_timestamp (
(	SELECT
	extract(month from created_at) as month
	FROM vacancy
	GROUP BY month
	ORDER BY count(*) desc LIMIT 1
)::text, 'MM'), 'TMmonth') AS vacancy_hot_month,
to_char(to_timestamp (
(	SELECT
	extract(month from created_at) as month
	FROM resume
	GROUP BY month
	ORDER BY count(*) desc LIMIT 1
)::text, 'MM'), 'TMmonth') AS resume_hot_month