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
Results:
[
  {
    "skills": "sql",
    "skill_count": "379"
  },
  {
    "skills": "python",
    "skill_count": "289"
  },
  {
    "skills": "excel",
    "skill_count": "229"
  },
  {
    "skills": "power bi",
    "skill_count": "200"
  },
  {
    "skills": "tableau",
    "skill_count": "156"
  },
  {
    "skills": "r",
    "skill_count": "129"
  },
  {
    "skills": "sas",
    "skill_count": "124"
  },
  {
    "skills": "sap",
    "skill_count": "91"
  },
  {
    "skills": "powerpoint",
    "skill_count": "53"
  },
  {
    "skills": "vba",
    "skill_count": "51"
  },
  {
    "skills": "qlik",
    "skill_count": "50"
  },
  {
    "skills": "go",
    "skill_count": "40"
  },
  {
    "skills": "word",
    "skill_count": "35"
  },
  {
    "skills": "oracle",
    "skill_count": "34"
  },
  {
    "skills": "azure",
    "skill_count": "34"
  },
  {
    "skills": "vue",
    "skill_count": "26"
  },
  {
    "skills": "alteryx",
    "skill_count": "22"
  },
  {
    "skills": "postgresql",
    "skill_count": "21"
  },
  {
    "skills": "databricks",
    "skill_count": "21"
  },
  {
    "skills": "dax",
    "skill_count": "21"
  },
  {
    "skills": "aws",
    "skill_count": "21"
  },
  {
    "skills": "git",
    "skill_count": "20"
  },
  {
    "skills": "javascript",
    "skill_count": "20"
  },
  {
    "skills": "snowflake",
    "skill_count": "20"
  },
  {
    "skills": "tensorflow",
    "skill_count": "18"
  },
  {
    "skills": "pandas",
    "skill_count": "18"
  },
  {
    "skills": "chef",
    "skill_count": "16"
  },
  {
    "skills": "pyspark",
    "skill_count": "15"
  },
  {
    "skills": "microstrategy",
    "skill_count": "15"
  },
  {
    "skills": "spark",
    "skill_count": "13"
  },
  {
    "skills": "linux",
    "skill_count": "13"
  },
  {
    "skills": "bigquery",
    "skill_count": "12"
  },
  {
    "skills": "julia",
    "skill_count": "12"
  },
  {
    "skills": "cognos",
    "skill_count": "12"
  },
  {
    "skills": "looker",
    "skill_count": "12"
  },
  {
    "skills": "sharepoint",
    "skill_count": "12"
  },
  {
    "skills": "matlab",
    "skill_count": "12"
  },
  {
    "skills": "java",
    "skill_count": "11"
  },
  {
    "skills": "numpy",
    "skill_count": "11"
  },
  {
    "skills": "jira",
    "skill_count": "10"
  },
  {
    "skills": "sql server",
    "skill_count": "10"
  },
  {
    "skills": "mysql",
    "skill_count": "10"
  },
  {
    "skills": "spss",
    "skill_count": "10"
  },
  {
    "skills": "html",
    "skill_count": "9"
  },
  {
    "skills": "docker",
    "skill_count": "9"
  },
  {
    "skills": "flow",
    "skill_count": "8"
  },
  {
    "skills": "kubernetes",
    "skill_count": "8"
  },
  {
    "skills": "c",
    "skill_count": "8"
  },
  {
    "skills": "css",
    "skill_count": "7"
  },
  {
    "skills": "gdpr",
    "skill_count": "6"
  },
  {
    "skills": "elasticsearch",
    "skill_count": "6"
  },
  {
    "skills": "scala",
    "skill_count": "6"
  },
  {
    "skills": "mongodb",
    "skill_count": "6"
  },
  {
    "skills": "vmware",
    "skill_count": "6"
  },
  {
    "skills": "nosql",
    "skill_count": "6"
  },
  {
    "skills": "atlassian",
    "skill_count": "6"
  },
  {
    "skills": "ruby",
    "skill_count": "6"
  },
  {
    "skills": "jupyter",
    "skill_count": "5"
  },
  {
    "skills": "c++",
    "skill_count": "5"
  },
  {
    "skills": "matplotlib",
    "skill_count": "5"
  },
  {
    "skills": "hadoop",
    "skill_count": "5"
  },
  {
    "skills": "gcp",
    "skill_count": "5"
  },
  {
    "skills": "github",
    "skill_count": "5"
  },
  {
    "skills": "react",
    "skill_count": "5"
  },
  {
    "skills": "outlook",
    "skill_count": "5"
  },
  {
    "skills": "mongo",
    "skill_count": "4"
  },
  {
    "skills": "windows",
    "skill_count": "4"
  },
  {
    "skills": "visio",
    "skill_count": "4"
  },
  {
    "skills": "php",
    "skill_count": "4"
  },
  {
    "skills": "c#",
    "skill_count": "4"
  },
  {
    "skills": "airflow",
    "skill_count": "4"
  },
  {
    "skills": "scikit-learn",
    "skill_count": "4"
  },
  {
    "skills": "gitlab",
    "skill_count": "3"
  },
  {
    "skills": "redshift",
    "skill_count": "3"
  },
  {
    "skills": "keras",
    "skill_count": "3"
  },
  {
    "skills": "t-sql",
    "skill_count": "3"
  },
  {
    "skills": "confluence",
    "skill_count": "3"
  },
  {
    "skills": "angular",
    "skill_count": "3"
  },
  {
    "skills": "ssis",
    "skill_count": "3"
  },
  {
    "skills": "pytorch",
    "skill_count": "2"
  },
  {
    "skills": "firebase",
    "skill_count": "2"
  },
  {
    "skills": "groovy",
    "skill_count": "2"
  },
  {
    "skills": "no-sql",
    "skill_count": "2"
  },
  {
    "skills": "redis",
    "skill_count": "2"
  },
  {
    "skills": "seaborn",
    "skill_count": "2"
  },
  {
    "skills": "sheets",
    "skill_count": "2"
  },
  {
    "skills": "svelte",
    "skill_count": "2"
  },
  {
    "skills": "unix",
    "skill_count": "2"
  },
  {
    "skills": "powershell",
    "skill_count": "1"
  },
  {
    "skills": "splunk",
    "skill_count": "1"
  },
  {
    "skills": "spreadsheet",
    "skill_count": "1"
  },
  {
    "skills": "perl",
    "skill_count": "1"
  },
  {
    "skills": "pascal",
    "skill_count": "1"
  },
  {
    "skills": "notion",
    "skill_count": "1"
  },
  {
    "skills": "sqlite",
    "skill_count": "1"
  },
  {
    "skills": "node.js",
    "skill_count": "1"
  },
  {
    "skills": "ssrs",
    "skill_count": "1"
  },
  {
    "skills": "assembly",
    "skill_count": "1"
  },
  {
    "skills": "nltk",
    "skill_count": "1"
  },
  {
    "skills": "ms access",
    "skill_count": "1"
  },
  {
    "skills": "mariadb",
    "skill_count": "1"
  },
  {
    "skills": "terraform",
    "skill_count": "1"
  },
  {
    "skills": "theano",
    "skill_count": "1"
  },
  {
    "skills": "typescript",
    "skill_count": "1"
  },
  {
    "skills": "unity",
    "skill_count": "1"
  },
  {
    "skills": "wrike",
    "skill_count": "1"
  },
  {
    "skills": "kotlin",
    "skill_count": "1"
  },
  {
    "skills": "express",
    "skill_count": "1"
  },
  {
    "skills": "visual basic",
    "skill_count": "1"
  },
  {
    "skills": "django",
    "skill_count": "1"
  },
  {
    "skills": "delphi",
    "skill_count": "1"
  },
  {
    "skills": "db2",
    "skill_count": "1"
  },
  {
    "skills": "slack",
    "skill_count": "1"
  },
  {
    "skills": "shell",
    "skill_count": "1"
  }
]
*/