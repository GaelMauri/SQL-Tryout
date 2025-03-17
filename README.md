# INTRODUCTION

This repository was done independent of any academic or occupational obligation, but rather as way to learn the basics and intermediate concepts of SQL, and show my capabilities for managing databases, data manipulation, code optimization and desired outputs. The knowledge and steps taken were following the course from Luke Barousse, found [here](https://youtu.be/7mz73uXD9DA?si=PoDWVRJG80J5GiFi). 

This project is structured around 4 questions, each in their own query, that challenge and back up the extent of my knowledge on the tools that helped me complete the tasks in question. These 4 questions, shown in the Queries and Code section, are composed to get progressively more complex.

 

## MATERIAL

### Tools Learned and Used
- **SQL**: the coding language with which the data has been analyzed, allowing to reveal the insights within the data inputted. 
- **CSV Datasets**: where all the data inputted comes from and, therefore, where all the output source from. The csv files of the "Material" section have been provided by Luke Barousse, while the files in the "Results and Insights" section have been created from the queries. 
- **PostgreSQL**: the relational database management system of my choice, based on the quantity of systems demanded by Data Analyst jobs in Denmark, coming out on top 2 out of the existing database management system, also recommended by the course. Source from [this page](https://datanerd.tech/).
- **VSCode**: my go-to code editor, due to its high customizability, extensions, and language support, boosting my efficiency when running these queries. 
- **GitHub**: in order to store these project, upload the its results, and periodically build a sufficient portfolio, I used GitHub to control the progress and updates of this repository. 

### Datasets Used
Across the code shown in the next section there are 4 datasets from where the data is sourced. These are:
- **company_dim** contains the name of companies that offer jobs relating to data analysis, engineering and science, followed by the job link and a number that serves as an identifier.
- **job_posting_fact** gathers extensive information (average salary, remote or in-person, etc.) on the kind of jobs that companies offered in the previous dataset, along with an identifier for job number and company number.   
- **skills_dim** relates a skill to a certain skill number identifier, and the type of skill it is.
- **skills_job_dim** matches a job number identifier to a skill number identifier. **All of these identifiers will be the links between the datasets**.

## QUERIES AND CODE
### Item Creation
For database and dataset creation, plus storing data within these datasets, the .sql files found in the [material_loading folder](/material_loading/). The queries used are the following:

*Database Creation*
```sql
CREATE DATABASE sql1;
```
*Dataset Creation*
```sql
CREATE TABLE public.company_dim
(
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

CREATE TABLE public.skills_dim
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

CREATE TABLE public.job_postings_fact
(
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES public.company_dim (company_id)
);

CREATE TABLE public.skills_job_dim
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES public.job_postings_fact (job_id),
    FOREIGN KEY (skill_id) REFERENCES public.skills_dim (skill_id)
);

ALTER TABLE public.company_dim OWNER to postgres;
ALTER TABLE public.skills_dim OWNER to postgres;
ALTER TABLE public.job_postings_fact OWNER to postgres;
ALTER TABLE public.skills_job_dim OWNER to postgres;

CREATE INDEX idx_company_id ON public.job_postings_fact (company_id);
CREATE INDEX idx_skill_id ON public.skills_job_dim (skill_id);
CREATE INDEX idx_job_id ON public.skills_job_dim (job_id);
```
*Data Allocation*
```sql
COPY company_dim
FROM 'C:\Users\Usuario\Documents\2nD Desktop\SQL Try\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\Usuario\Documents\2nD Desktop\SQL Try\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_postings_fact
FROM 'C:\Users\Usuario\Documents\2nD Desktop\SQL Try\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_job_dim
FROM 'C:\Users\Usuario\Documents\2nD Desktop\SQL Try\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
```

***The following 4 questions are answered using the queries found in the [question_queries folder](/question_queries/). Moreover, the output of the queries can be found in separate csv files in the zip folder inside the [sql_question_results folder](/sql_question_results/)***:
### Question 1
What are the top 20 paying Data Analyst jobs in the USA, 
considering in-person and remote, part-time positions and the names of the offering companies?

```sql
SELECT
    salary_year_avg,
    job_location,
    job_schedule_type,
    name AS Company_Name
FROM job_postings_fact
LEFT JOIN company_dim AS company
    ON job_postings_fact.company_id = company.company_id
WHERE 
    job_title_short LIKE '%Data Analyst%' AND
    search_location LIKE '%United States%' AND
    job_schedule_type LIKE '%Part%' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 20
;
```

### Question 2
Continuing from the previous question, what are the skills associated with each of these top 20 jobs?
```sql
WITH top20_jobs AS (
    SELECT
        DENSE_RANK() OVER (ORDER BY salary_year_avg DESC) AS top20,
        salary_year_avg,
        job_location,
        job_schedule_type,
        name AS Company_Name,
        skills
    FROM job_postings_fact
    LEFT JOIN company_dim AS company
        ON job_postings_fact.company_id = company.company_id
    LEFT JOIN skills_job_dim AS skills_num
        ON job_postings_fact.job_id = skills_num.job_id
    LEFT JOIN skills_dim AS skills
        ON skills_num.skill_id = skills.skill_id
    WHERE 
        job_title_short LIKE '%Data Analyst%' AND
        search_location LIKE '%United States%' AND
        job_schedule_type LIKE '%Part%' AND
        salary_year_avg IS NOT NULL AND
        skills IS NOT NULL
)

SELECT*
FROM top20_jobs
WHERE top20 <= 20
;

```

### Question 3
What are the most demanded skills for Data Analyst jobs, only counting Denmark, Belgium, France and Germany,
considering part-time and non-remote positions, and NULL values? 

```sql
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
```

### Question 4:
What are the top 10 skills demanded in Data Analyst jobs by salary brackets, considering non-remote, part-time positions, and NULL values?

The salary brackets are defined as follows:
- Low: x <= 100000
- Standard: 100000 < x <200000
- High: x >= 200000
```sql
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
```

## RESULTS AND INSIGHTS

