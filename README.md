# INTRODUCTION

This repository was done independent of any academic or occupational obligation, but rather as way to learn the basics and intermediate concepts of SQL, and show my capabilities for managing databases, data manipulation, code optimization and desired outputs. The knowledge and steps were taken by following the course from Luke Barousse, found [here](https://youtu.be/7mz73uXD9DA?si=PoDWVRJG80J5GiFi). 

This project is structured around 4 questions, each in their own query, that challenge and back up the extent of my knowledge on the tools that helped me complete the tasks in question. These 4 questions, shown in the "Queries and Code" section, are composed to get progressively more complex.

 

## MATERIAL

### Tools Learned and Used
- **SQL**: the coding language with which the data has been analyzed, allowing to reveal the insights within the data inputted. 
- **CSV Datasets**: where all the data inputted comes from and, therefore, where all the output source from. The csv files of the "Material" section have been provided by Luke Barousse, while the files in the "Results and Insights" section have been created from the queries. 
- **PostgreSQL**: the relational database management system of my choice, based on the quantity of systems demanded by Data Analyst jobs in Denmark, coming out on top 2 out of the existing database management system, also recommended by the course. Source from [this page](https://datanerd.tech/).
- **VSCode**: my go-to code editor, due to its high customizability, extensions, and language support, boosting my efficiency when running these queries. 
- **GitHub**: in order to store these project, upload its results, and periodically build a sufficient portfolio, I used GitHub to control the progress and updates of this repository. 

### Datasets Used
Across the code shown in the next section there are 4 datasets from where the data is sourced. These are:
- **company_dim** contains the name of companies that offer jobs relating to data analysis, engineering and science, followed by the job link and a number that serves as an identifier.
- **job_posting_fact** gathers extensive information (average salary, remote or in-person, etc.) on the kind of jobs that companies offered in the previous dataset, along with an identifier for job number and company number.   
- **skills_dim** relates a skill to a certain skill number identifier, and the type of skill it is.
- **skills_job_dim** matches a job number identifier to a skill number identifier. **All of these identifiers will be the links between the datasets**.

## QUERIES AND CODE
### Item Creation
The queries for database and dataset creation, plus storing data within these datasets, can be found in the .sql files inside the [material_loading folder](/material_loading/). The queries used are the following:

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
        DENSE_RANK() OVER (ORDER BY salary_year_avg DESC, job_location DESC) AS top20,
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

### Question 1 and 2


**1. Salary Distribution**:

The highest annual salary ($234000) is offered by **Walmart Global Tech** in **Sunnyvale, CA**; while the lowest annual salary ($115000) is offered by **Epik Solutions** in **Pleasant Hill, CA**.

Taking a look at the whole group, the **average salary** offered for these specific jobs is of $151855, having an **expected deviation** of $36120 per job. 


**2. The 5 Top Paying Companies Are**:

   | **Rank** | **Salary**   | **Location**         | **Company**                          | **Skills**                                                                 |
|----------|--------------|----------------------|--------------------------------------|----------------------------------------------------------------------------|
| 1        | $234,000     | Sunnyvale, CA        | Walmart Global Tech                  | Spark, Matplotlib, Excel, Tableau, Power BI, SAS, SQL, Python, NoSQL, Scala, R, Oracle |
| 2        | $202,000     | California           | Walmart Global Tech                  | Tableau, SQL, Python, Scala, Spark, R, Power BI                            |
| 3        | $193,048     | St Charles, MO       | U.S. Department of the Treasury      | Python, SAS, C, R                                                          |
| 4        | $193,048     | Fairview, PA         | U.S. Department of the Treasury      | R, SAS, C, Python                                                          |
| 5        | $170,000     | Arlington, VA        | US Office of the Secretary of Defense| C, Terminal, Go                                                            |


**3. The Top Demanded Skills Are**:

- **Python**
- **SQL**
- **R**
- **Tableau**
- **Power BI**

While not appearing as often, specialized skills like **Scala**, **Go**, and **Databricks** are particularly in demand for higher-paying roles.


**4. Public vs. Private Sector Skills**

   **Public companies** such as the U.S. Department of the Treasury and US Office of the Secretary of Defense often require certain skills like **Python**, **SAS**, and **C**; while **private companies** like Walmart Global Tech and Booz Allen Hamilton expect a broader range of technical skills required.

---

It is notable that some jobs are listed as **"Anywhere"**, indicating remote work opportunities, but not entirely remote, and are therefore kept in the output.

---
### Question 3

**1. The 10 Top Demanded Skills Are**:


| **Skill**   | **Count** |
|-------------|-----------|
| SQL         | 379       |
| Python      | 289       |
| Excel       | 229       |
| Power BI    | 200       |
| Tableau     | 156       |
| R           | 129       |
| SAS         | 124       |
| SAP         | 91        |
| PowerPoint  | 53        |
| VBA         | 51        |

The top 10 demanded skills focus on **Data Manipulation** (SQL) and **Automation** (Python), its **Visualization** (Power BI) and its **Presentation** (PowerPoint).


---
**The Bottom 10 Demanded Skills Are**:

| **Skill**       | **Count** |
|-----------------|-----------|
| PowerShell      | 1         |
| Splunk          | 1         |
| Spreadsheet     | 1         |
| Perl            | 1         |
| Pascal          | 1         |
| Notion          | 1         |
| SQLite          | 1         |
| Node.js         | 1         |
| SSRS            | 1         |
| Assembly        | 1         |

The bottom 10 demanded skills barely appear, as they focus on more **Uncommon Languages** (Pascal), **Starting/Basic Versions** of others skills (SQLite) and **Specialized Tools** (Splunk).

---
### Question 4


**Low Salary Bracket**:

| **Skill**   | **Count** | **Rank** |
|-------------|-----------|----------|
| SQL         | 28        | 1        |
| Python      | 20        | 2        |
| SAS         | 16        | 3        |
| R           | 14        | 4        |
| Excel       | 13        | 5        |
| Tableau     | 12        | 6        |
| Power BI    | 11        | 7        |
| AWS         | 8         | 8        |
| Oracle      | 6         | 9        |
| Azure       | 6         | 10       |



**Standard Salary Bracket**:

| **Skill**   | **Count** | **Rank** |
|-------------|-----------|----------|
| SAS         | 16        | 1        |
| Python      | 16        | 2        |
| SQL         | 13        | 3        |
| Tableau     | 11        | 4        |
| R           | 10        | 5        |
| Power BI    | 6         | 6        |
| Excel       | 5         | 7        |
| Azure       | 4         | 8        |
| C           | 4         | 9        |
| Spark       | 3         | 10       |



**High Salary Bracket**:

| **Skill**   | **Count** | **Rank** |
|-------------|-----------|----------|
| Power BI    | 2         | 1        |
| Scala       | 2         | 2        |
| Spark       | 2         | 3        |
| SAS         | 2         | 4        |
| SQL         | 2         | 5        |
| Tableau     | 2         | 6        |
| R           | 2         | 7        |
| Python      | 2         | 8        |
| Excel       | 1         | 9        |
| Oracle      | 1         | 10       |

---

From these tables it can be seen that there's a clear resemblance between the **low** and **standard** brackets:
The most demanded skills in both are **SQL**, **Python**, and **Excel**, followed by **R**, that focuses on statistical analysis skills. These analyses are showcased by programmes such as **Tableau** and **Power BI**, therefore concluding that in the Low and Standard brackets there's relevancy for the most core data skills, and its visualization.

On the other hand, there's many more differences between these brackets and the **High** bracket, which requires much more specialized expertise, shown in demand for **Scala** or **Spark** instead of Python or R, used on processing huge amounts of data and on really peculiar scenarios. The dominant demand of **Power BI** indicates the significant use of more advanced data visualization techniques when paired with Scala or Spark. It is also noticeable that there are less observations in the High bracket, as it treats with more niche and abnormal cases, that are therefore less know, and better rewarded in turn. 

