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
Insights (from AI):
1. Most Demanded Skills Across All Brackets
SQL and Python are consistently in the top 3 across all salary brackets, indicating their universal importance for Data Analysts.
SAS is also highly demanded, especially in the Standard and Low brackets.

2. Low Salary Bracket:
Top Skills: SQL (28), Python (20), SAS (16), R (14), Excel (13).
Foundational skills like SQL, Python, and Excel dominate this bracket, suggesting that entry-level or junior roles focus on core data manipulation and analysis.

3. Standard Salary Bracket:
Top Skills: SAS (16), Python (16), SQL (13), Tableau (11), R (10).
In addition to core skills, tools like Tableau and Power BI become more important, indicating a focus on data visualization and reporting in mid-level roles.

4. High Salary Bracket (≥ $200,000)
Top Skills: Power BI (2), Scala (2), Spark (2), SAS (2), Python (2).
High-paying roles demand advanced skills like Scala and Spark, which are associated with big data and distributed computing. Power BI remains relevant, but the skill counts are much lower, suggesting these roles are fewer in number or more specialized.

5. Skill Distribution by Salary Bracket
Low Bracket: Focuses on foundational skills (SQL, Python, Excel).
Standard Bracket: Adds data visualization tools (Tableau, Power BI).
High Bracket: Introduces advanced big data tools (Scala, Spark).

6. Niche Skills
Scala and Spark appear only in the High bracket, indicating their association with senior or specialized roles.
Excel is present in all brackets but becomes less prominent in the High bracket.
*/
 