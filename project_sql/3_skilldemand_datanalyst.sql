/*
What are the most demanded skills for Data Analyst jobs, only counting Denmark, Belgium, France and Germany,
considering part-time and non-remote positions, and NULL values? 

Note: In this case, NULL values in any other table apart from skills are not 
relevant, since we only care about the demanded skill for a certain job,
 not about the characteristics of the job itself 
*/

SELECT
    skills,
    COUNT(skills) AS skill_count
FROM skills_job_dim
INNER JOIN skills_dim AS skill
    ON skills_job_dim.skill_id = skill.skill_id
WHERE job_id IN (
    SELECT
        job_id
    FROM job_postings_fact
    WHERE 
        job_title_short LIKE '%Data Analyst%' AND
        (job_location LIKE '%Denmark%'OR 
        job_location LIKE '%Belgium%' OR
        job_location LIKE '%France%' OR
        job_location LIKE '%Germany%') AND
        job_schedule_type LIKE '%Part%' AND
        job_work_from_home = FALSE
) AND skills IS NOT NULL
GROUP BY
    skills
ORDER BY
    skill_count DESC
;

/*
Insights (from AI):
1. Top Demanded Skills
SQL is the most demanded skill with 379 occurrences, followed by Python (289) and Excel (229).

The top 5 skills are:

SQL (379)
Python (289)
Excel (229)
Power BI (200)
Tableau (156)

2. Data Visualization Tools
Data visualization tools like Power BI (200), Tableau (156), and Qlik (50) are highly demanded.
This indicates that employers value the ability to present data effectively.

3. Programming Languages
Python (289) and R (129) are the most demanded programming languages for Data Analysts.
Other languages like Go (40), Java (11), and JavaScript (20) are also present but less common.

4. Cloud and Big Data Tools
Cloud platforms like Azure (34), AWS (21), and GCP (5) are in demand.
Big data tools like Databricks (21), Snowflake (20), and Spark (13) are also relevant.

5. Lesser-Demanded Skills
Skills like Pascal (1), Delphi (1), and Assembly (1) are rarely demanded, indicating niche or outdated technologies.

6. Spreadsheet and Office Tools
Excel (229) and PowerPoint (53) are highly demanded, reflecting the importance of basic data manipulation and presentation skills.
Word (35) and Outlook (5) are also present but less emphasized.
*/