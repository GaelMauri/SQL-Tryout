/*
Continuing from the previous question, what are the skills associated with these top 20 jobs?
*/

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

/*
Results:
[
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "sql"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "oracle"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "spark"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "matplotlib"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "excel"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "tableau"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "power bi"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "sas"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "python"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "nosql"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "scala"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "r"
  },
  {
    "top20": "1",
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "sas"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "sql"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "power bi"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "tableau"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "spark"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "r"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "scala"
  },
  {
    "top20": "2",
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech",
    "skills": "python"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "St Charles, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "r"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "St Charles, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "sas"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "St Charles, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "c"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "St Charles, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "sas"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "St Charles, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "python"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "Fairview, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "sas"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "Fairview, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "c"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "Fairview, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "sas"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "Fairview, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "r"
  },
  {
    "top20": "3",
    "salary_year_avg": "193048.0",
    "job_location": "Fairview, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury",
    "skills": "python"
  },
  {
    "top20": "4",
    "salary_year_avg": "170000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Office of the Secretary of Defense",
    "skills": "c"
  },
  {
    "top20": "4",
    "salary_year_avg": "170000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Office of the Secretary of Defense",
    "skills": "go"
  },
  {
    "top20": "4",
    "salary_year_avg": "170000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Office of the Secretary of Defense",
    "skills": "terminal"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "tableau"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "sql"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "python"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "scala"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "r"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "spark"
  },
  {
    "top20": "5",
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "power bi"
  },
  {
    "top20": "6",
    "salary_year_avg": "152650.0",
    "job_location": "Maryland",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "excel"
  },
  {
    "top20": "6",
    "salary_year_avg": "152650.0",
    "job_location": "Maryland",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "python"
  },
  {
    "top20": "6",
    "salary_year_avg": "152650.0",
    "job_location": "Maryland",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "r"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills": "sql"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency",
    "skills": "terminal"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency",
    "skills": "spss"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency",
    "skills": "qlik"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency",
    "skills": "sas"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency",
    "skills": "tableau"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency",
    "skills": "sas"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills": "alteryx"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills": "tableau"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills": "databricks"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills": "go"
  },
  {
    "top20": "7",
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office",
    "skills": "r"
  },
  {
    "top20": "8",
    "salary_year_avg": "145000.0",
    "job_location": "Herndon, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "ibm cloud"
  },
  {
    "top20": "8",
    "salary_year_avg": "145000.0",
    "job_location": "Herndon, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "sql"
  },
  {
    "top20": "8",
    "salary_year_avg": "145000.0",
    "job_location": "Herndon, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "python"
  },
  {
    "top20": "8",
    "salary_year_avg": "145000.0",
    "job_location": "Herndon, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "powershell"
  },
  {
    "top20": "8",
    "salary_year_avg": "145000.0",
    "job_location": "Herndon, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "azure"
  },
  {
    "top20": "9",
    "salary_year_avg": "126801.5",
    "job_location": "Chicago, IL",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Department of Transportation",
    "skills": "phoenix"
  },
  {
    "top20": "9",
    "salary_year_avg": "126801.5",
    "job_location": "Philadelphia, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Department of Transportation",
    "skills": "phoenix"
  },
  {
    "top20": "10",
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart",
    "skills": "r"
  },
  {
    "top20": "10",
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart",
    "skills": "sql"
  },
  {
    "top20": "10",
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart",
    "skills": "spreadsheet"
  },
  {
    "top20": "10",
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart",
    "skills": "sas"
  },
  {
    "top20": "10",
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart",
    "skills": "tableau"
  },
  {
    "top20": "10",
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart",
    "skills": "sas"
  },
  {
    "top20": "11",
    "salary_year_avg": "120200.0",
    "job_location": "Long Beach, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "SCAN Health Plan",
    "skills": "sas"
  },
  {
    "top20": "11",
    "salary_year_avg": "120200.0",
    "job_location": "Long Beach, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "SCAN Health Plan",
    "skills": "sql"
  },
  {
    "top20": "11",
    "salary_year_avg": "120200.0",
    "job_location": "Long Beach, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "SCAN Health Plan",
    "skills": "sas"
  },
  {
    "top20": "11",
    "salary_year_avg": "120200.0",
    "job_location": "Long Beach, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "SCAN Health Plan",
    "skills": "excel"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "spss"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "python"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "r"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sas"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "c++"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "c#"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "perl"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "tableau"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Annapolis Junction, MD",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "flow"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Annapolis Junction, MD",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "python"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sas"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "United States",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "qlik"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "oracle"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "qlik"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "sas"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "tableau"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "perl"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "c#"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "c++"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "sas"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "r"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "java"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "python"
  },
  {
    "top20": "12",
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc.",
    "skills": "spss"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "tableau"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "sql"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "python"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "scala"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "r"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "spark"
  },
  {
    "top20": "13",
    "salary_year_avg": "117500.0",
    "job_location": "Dallas, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart",
    "skills": "power bi"
  },
  {
    "top20": "14",
    "salary_year_avg": "115000.0",
    "job_location": "Pleasant Hill, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Epik Solutions",
    "skills": "python"
  },
  {
    "top20": "14",
    "salary_year_avg": "115000.0",
    "job_location": "Pleasant Hill, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Epik Solutions",
    "skills": "excel"
  },
  {
    "top20": "14",
    "salary_year_avg": "115000.0",
    "job_location": "Pleasant Hill, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Epik Solutions",
    "skills": "sap"
  },
  {
    "top20": "14",
    "salary_year_avg": "115000.0",
    "job_location": "Pleasant Hill, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Epik Solutions",
    "skills": "sql"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "tableau"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "python"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "sql"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "azure"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "ibm cloud"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "jira"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Washington, DC",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "sql"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Washington, DC",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "power bi"
  },
  {
    "top20": "15",
    "salary_year_avg": "111500.0",
    "job_location": "Washington, DC",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM",
    "skills": "ibm cloud"
  },
  {
    "top20": "16",
    "salary_year_avg": "108329.0",
    "job_location": "Washington, DC",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Federal Energy Regulatory Commission",
    "skills": "go"
  },
  {
    "top20": "16",
    "salary_year_avg": "108329.0",
    "job_location": "Washington, DC",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Federal Energy Regulatory Commission",
    "skills": "c"
  },
  {
    "top20": "16",
    "salary_year_avg": "108329.0",
    "job_location": "Washington, DC",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Federal Energy Regulatory Commission",
    "skills": "power bi"
  },
  {
    "top20": "17",
    "salary_year_avg": "105475.0",
    "job_location": "El Segundo, CA",
    "job_schedule_type": "Part-time",
    "company_name": "KARL STORZ Endoscopy - America",
    "skills": "looker"
  },
  {
    "top20": "17",
    "salary_year_avg": "105475.0",
    "job_location": "El Segundo, CA",
    "job_schedule_type": "Part-time",
    "company_name": "KARL STORZ Endoscopy - America",
    "skills": "sap"
  },
  {
    "top20": "17",
    "salary_year_avg": "105475.0",
    "job_location": "El Segundo, CA",
    "job_schedule_type": "Part-time",
    "company_name": "KARL STORZ Endoscopy - America",
    "skills": "tableau"
  },
  {
    "top20": "18",
    "salary_year_avg": "100500.0",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "company_name": "Udacity, Inc.",
    "skills": "zoom"
  },
  {
    "top20": "18",
    "salary_year_avg": "100500.0",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "company_name": "Udacity, Inc.",
    "skills": "numpy"
  },
  {
    "top20": "18",
    "salary_year_avg": "100500.0",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "company_name": "Udacity, Inc.",
    "skills": "pandas"
  },
  {
    "top20": "18",
    "salary_year_avg": "100500.0",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "company_name": "Udacity, Inc.",
    "skills": "python"
  },
  {
    "top20": "18",
    "salary_year_avg": "100500.0",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "company_name": "Udacity, Inc.",
    "skills": "sql"
  },
  {
    "top20": "18",
    "salary_year_avg": "100500.0",
    "job_location": "United States",
    "job_schedule_type": "Part-time",
    "company_name": "Udacity, Inc.",
    "skills": "slack"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Annapolis Junction, MD",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "flow"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Annapolis Junction, MD",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "python"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "tableau"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "oracle"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "visual basic"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "matlab"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sas"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "redshift"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "snowflake"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "java"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "shell"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "mongo"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "mysql"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "cassandra"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "azure"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "aws"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "redshift"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "r"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "python"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sql"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "spark"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "snowflake"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "hadoop"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "kafka"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "spark"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "hadoop"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "sql"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "python"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "nosql"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "scala"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "scala"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "spss"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "python"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "shell"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "azure"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "Boston, MA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Capital One",
    "skills": "aws"
  },
  {
    "top20": "19",
    "salary_year_avg": "100000.0",
    "job_location": "St. Louis, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sas"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sas"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sql"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "python"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "r"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "sas"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "excel"
  },
  {
    "top20": "20",
    "salary_year_avg": "95700.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton",
    "skills": "powerpoint"
  }
]
*/