select
	area_id,
	avg(salary_from)::int as salary_from_avg, 
	avg(salary_to)::int as salary_to_avg,
	avg(salary_avg)::int as salary_avg_avg
from 
(select
	area_id, 
	salary_from, 
	salary_to,
	NULLIF((COALESCE(salary_from, salary_to,0) + COALESCE(salary_to,salary_from,0))/2, 0) as salary_avg
from 
	(select 
		area_id, 
		(salary_from*(1 - 0.13*salary_gross::int))::int as salary_from, 
		(salary_to*(1 - 0.13*salary_gross::int))::int as salary_to
	from vacancy_body)
	as vb) 
	as vb
-- 	where salary_from is not null or salary_to is not null 
	group by area_id;