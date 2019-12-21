SELECT
	MIN(vb.name) AS vacancy_name
FROM vacancy AS v
LEFT JOIN vacancy_response AS vr USING (vacancy_id)
LEFT JOIN vacancy_body AS vb USING (vacancy_body_id)
WHERE vr.created_at is null or date_part('day', vr.created_at - v.created_at) < 7
GROUP BY vacancy_id
HAVING count(*)<5
ORDER BY vacancy_name
