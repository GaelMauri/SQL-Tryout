/*
What are the top 10 skills demanded in Data Analyst jobs by salary brackets, considering non-remote, part-time positions, and NULL values?
The salary brackets are defined as follows:
    - Low: x <= 100000
    - Standard: 100000 < x <200000
    - High: x >= 200000
*/

WITH skillid_to_salary AS (
    SELECT
        skills.skill_id,
        CASE
            WHEN salary_year_avg <= 100000 THEN 'Low'
            WHEN salary_year_avg >= 200000 THEN 'High'
            ELSE 'Standard'
        END AS salary_brackets
    FROM job_postings_fact
    INNER JOIN skills_job_dim AS skills
        ON job_postings_fact.job_id = skills.job_id
    WHERE 
        job_title_short LIKE '%Data Analyst%' AND
        job_schedule_type LIKE '%Part%' AND
        job_work_from_home = FALSE AND
        salary_year_avg IS NOT NULL),
skills_to_salary AS (
    SELECT
        salary_brackets AS brackets,
        skill.skills AS skills,
        COUNT(skill.skill_id) AS skill_count,
        ROW_NUMBER() OVER (PARTITION BY salary_brackets ORDER BY COUNT(skill.skill_id) DESC) AS rank
    FROM skillid_to_salary
    INNER JOIN skills_dim AS skill
        ON skillid_to_salary.skill_id = skill.skill_id
    GROUP BY
        brackets, skills
    ORDER BY
        brackets DESC, skill_count DESC)

SELECT*
FROM skills_to_salary
WHERE rank <= 10
;

/*
Results:
[
  {
    "brackets": "Standard",
    "skills": "sas",
    "skill_count": "16",
    "rank": "1"
  },
  {
    "brackets": "Standard",
    "skills": "python",
    "skill_count": "16",
    "rank": "2"
  },
  {
    "brackets": "Standard",
    "skills": "sql",
    "skill_count": "13",
    "rank": "3"
  },
  {
    "brackets": "Standard",
    "skills": "tableau",
    "skill_count": "11",
    "rank": "4"
  },
  {
    "brackets": "Standard",
    "skills": "r",
    "skill_count": "10",
    "rank": "5"
  },
  {
    "brackets": "Standard",
    "skills": "power bi",
    "skill_count": "6",
    "rank": "6"
  },
  {
    "brackets": "Standard",
    "skills": "excel",
    "skill_count": "5",
    "rank": "7"
  },
  {
    "brackets": "Standard",
    "skills": "azure",
    "skill_count": "4",
    "rank": "8"
  },
  {
    "brackets": "Standard",
    "skills": "c",
    "skill_count": "4",
    "rank": "9"
  },
  {
    "brackets": "Standard",
    "skills": "spark",
    "skill_count": "3",
    "rank": "10"
  },
  {
    "brackets": "Low",
    "skills": "sql",
    "skill_count": "28",
    "rank": "1"
  },
  {
    "brackets": "Low",
    "skills": "python",
    "skill_count": "20",
    "rank": "2"
  },
  {
    "brackets": "Low",
    "skills": "sas",
    "skill_count": "16",
    "rank": "3"
  },
  {
    "brackets": "Low",
    "skills": "r",
    "skill_count": "14",
    "rank": "4"
  },
  {
    "brackets": "Low",
    "skills": "excel",
    "skill_count": "13",
    "rank": "5"
  },
  {
    "brackets": "Low",
    "skills": "tableau",
    "skill_count": "12",
    "rank": "6"
  },
  {
    "brackets": "Low",
    "skills": "power bi",
    "skill_count": "11",
    "rank": "7"
  },
  {
    "brackets": "Low",
    "skills": "aws",
    "skill_count": "8",
    "rank": "8"
  },
  {
    "brackets": "Low",
    "skills": "oracle",
    "skill_count": "6",
    "rank": "9"
  },
  {
    "brackets": "Low",
    "skills": "azure",
    "skill_count": "6",
    "rank": "10"
  },
  {
    "brackets": "High",
    "skills": "scala",
    "skill_count": "2",
    "rank": "2"
  },
  {
    "brackets": "High",
    "skills": "power bi",
    "skill_count": "2",
    "rank": "1"
  },
  {
    "brackets": "High",
    "skills": "sas",
    "skill_count": "2",
    "rank": "4"
  },
  {
    "brackets": "High",
    "skills": "spark",
    "skill_count": "2",
    "rank": "3"
  },
  {
    "brackets": "High",
    "skills": "python",
    "skill_count": "2",
    "rank": "8"
  },
  {
    "brackets": "High",
    "skills": "r",
    "skill_count": "2",
    "rank": "7"
  },
  {
    "brackets": "High",
    "skills": "tableau",
    "skill_count": "2",
    "rank": "6"
  },
  {
    "brackets": "High",
    "skills": "sql",
    "skill_count": "2",
    "rank": "5"
  },
  {
    "brackets": "High",
    "skills": "excel",
    "skill_count": "1",
    "rank": "9"
  },
  {
    "brackets": "High",
    "skills": "oracle",
    "skill_count": "1",
    "rank": "10"
  }
]
*/