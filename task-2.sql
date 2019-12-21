INSERT INTO vacancy_body(
	company_name, 
	name, 
	text, 
	area_id, 
	address_id, 
	work_experience, 
	salary_from,
	salary_gross,
	test_solution_required,
	work_schedule_type, 
	employment_type
)
SELECT 
	(
		SELECT string_agg(substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', (random() * 77)::int + 1, 1), '') 
		FROM generate_series(1, 1 + (random() * 150 + i % 10)::int)
	)	AS company_name,

	(	SELECT string_agg(substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', (random() * 77)::int + 1, 1), '') 
		FROM generate_series(1, 1 + (random() * 220 + i % 10)::int)
	)	AS name,

	(	SELECT string_agg(substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', (random() * 77)::int + 1, 1), '') 
		FROM generate_series(1, 1 + (random() * 50 + i % 10)::int)
	)	AS text,

    (random() * 1000)::int AS area_id,
    (random() * 50000)::int AS address_id,
    (random() * 10)::int AS work_experience,
    25000 + (random() * 150)::int * 1000 AS salary_from,
    (random() > 0.5) AS salary_gross,
    (random() > 0.5) AS test_solution_required,
    floor(random() * 5)::int AS work_schedule_type,
    floor(random() * 5)::int AS employment_type

FROM generate_series(1, 10000) AS g(i);

-- fill in salary_to
UPDATE vacancy_body SET salary_to = salary_from + (random() * 100)::int * 1000;

-- make some nulls
UPDATE vacancy_body SET salary_from=null WHERE random()<.1;
UPDATE vacancy_body SET salary_to=null WHERE random()<.1;
UPDATE vacancy_body SET salary_from=null, salary_to=null WHERE random()<.01;
UPDATE vacancy_body SET salary_from=null WHERE area_id%5=(date_part('minute', now()))::int % 5;
UPDATE vacancy_body SET salary_to=null WHERE area_id%6=(date_part('minute', now()))::int % 6;

---------------------------------------------------------

INSERT INTO vacancy (
	created_at, 
	expires_at, 
	employer_id, 
	disabled, 
	visible, 
	area_id,
	vacancy_body_id
)
SELECT
    -- random in last 5 years
    now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS creation_time,
    now() AS expire_time,
    (random() * 1000000)::int AS employer_id,
    (random() > 0.5) AS disabled,
    (random() > 0.5) AS visible,
    vb.area_id,
	vb.vacancy_body_id
FROM vacancy_body AS vb;

UPDATE vacancy
SET expires_at = created_at + (random() * 365 * 24 * 3600 * 5) * '1 second'::interval

---------------------------------------------------------
-- DELETE FROM resume;
INSERT INTO resume (
	title,
	user_id,
	created_at
)
SELECT
	(	SELECT string_agg(substr('      abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', (random() * 77)::int + 1, 1), '') 
		FROM generate_series(1, 1 + (random() * 150 + i % 10)::int)
	)	AS title,
	(random() * 100000)::int AS user_id,
	now()-(random() * 365 * 24 * 3600 * 5) * '1 second'::interval AS created_at
FROM generate_series(1, 100000) AS g(i);
