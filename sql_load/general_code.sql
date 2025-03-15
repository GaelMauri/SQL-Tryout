SELECT*
FROM janjobs
WHERE 
    salary_year_avg > 70000
UNION ALL
SELECT*
FROM febjobs
WHERE 
    salary_year_avg > 70000
UNION ALL
SELECT*
FROM marjobs
WHERE 
    salary_year_avg > 70000
;

WITH firstq_jobp AS (
    SELECT*
    FROM janjobs
    UNION ALL
    SELECT*
    FROM febjobs
    UNION ALL
    SELECT*
    FROM marjobs
)

SELECT *
FROM firstq_jobp
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 50
;
