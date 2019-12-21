SELECT 
	resume_id,
	array_to_string(array_agg(specialization_id),', ') AS specialization_array,
	min(most_common_specialization)
FROM
(	SELECT 
		resume_id,
		(array_agg(specialization_id))[1] AS most_common_specialization
	FROM
	(	SELECT 
			resume_id,
			count(*) AS cnt,
			specialization_id
		FROM resume
		LEFT JOIN vacancy_response USING (resume_id)
		LEFT JOIN vacancy USING (vacancy_id)
		LEFT JOIN vacancy_body_specialization USING (vacancy_body_id)
		GROUP BY resume_id, specialization_id
		ORDER BY resume_id, cnt desc
	) AS t1
	GROUP BY resume_id
) AS t2
LEFT JOIN resume_specialization USING (resume_id)
GROUP BY resume_id
