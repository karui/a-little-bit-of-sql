CREATE TABLE IF NOT EXISTS resume_history
(
    resume_id integer,
    changed_at timestamp,
	json json
);

CREATE OR REPLACE FUNCTION on_resume_change() RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO resume_history (resume_id, changed_at, json)
		SELECT
			OLD.resume_id,
			now(),
			to_json(OLD.*);
	RETURN null;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_resume_change
AFTER UPDATE OR DELETE ON resume
FOR EACH ROW EXECUTE PROCEDURE on_resume_change();


UPDATE resume SET title='gOOD tITLE' WHERE resume_id=1;
UPDATE resume SET title='Fixed title' WHERE resume_id=1;
UPDATE resume SET title='Another one' WHERE resume_id=1;


SELECT
	resume_id,
	changed_at,
	(json::json->>'title')::varchar(133) as title
FROM resume_history
WHERE resume_id=1
UNION ALL
SELECT
	resume_id,
	null,
	title
FROM resume
WHERE resume_id=1
