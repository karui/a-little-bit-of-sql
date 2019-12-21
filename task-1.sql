CREATE TABLE IF NOT EXISTS vacancy_body (
    vacancy_body_id serial PRIMARY KEY,
	company_name varchar(150) DEFAULT ''::varchar NOT NULL,
    name varchar(220) DEFAULT ''::varchar NOT NULL,
    text text,
    area_id integer,
    address_id integer,
    work_experience integer DEFAULT 0 NOT NULL,
    salary_from bigint DEFAULT 0,
    salary_to bigint DEFAULT 0,
    salary_gross boolean,
    test_solution_required boolean DEFAULT false NOT NULL,
    work_schedule_type integer DEFAULT 0 NOT NULL,
    employment_type integer DEFAULT 0 NOT NULL,
    CONSTRAINT vacancy_body_work_employment_type_validate CHECK ((employment_type = ANY (ARRAY[0, 1, 2, 3, 4]))),
    CONSTRAINT vacancy_body_work_schedule_type_validate CHECK ((work_schedule_type = ANY (ARRAY[0, 1, 2, 3, 4])))
);

CREATE TABLE IF NOT EXISTS vacancy (
    vacancy_id serial PRIMARY KEY,
    created_at timestamp NOT NULL,
    expires_at timestamp NOT NULL,
    employer_id integer DEFAULT 0 NOT NULL,    
    disabled boolean DEFAULT false NOT NULL,
    visible boolean DEFAULT true NOT NULL,
    vacancy_body_id integer REFERENCES vacancy_body,
    area_id integer
);

CREATE TABLE IF NOT EXISTS vacancy_body_specialization (
--     vacancy_body_specialization_id integer NOT NULL,
    vacancy_body_id integer REFERENCES vacancy_body,
    specialization_id integer DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS resume (
       resume_id serial PRIMARY KEY,
       title varchar(133) DEFAULT ''::varchar NOT NULL,
       user_id integer NOT NULL,
       created_at timestamp NOT NULL
);

CREATE TABLE IF NOT EXISTS resume_specialization (
--     resume_specialization_id integer NOT NULL,
    resume_id integer REFERENCES resume,
    specialization_id integer DEFAULT 0 NOT NULL
);

CREATE TABLE IF NOT EXISTS vacancy_response (
	vacancy_id integer REFERENCES vacancy,
	resume_id integer REFERENCES resume,
	created_at timestamp
);
