/*
What are the top 20 paying Data Analyst (and similar) jobs in the USA, 
considering in-person and remote, part-time positions and the names of the offering companies? 
*/

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

/*
Results:
[
  {
    "salary_year_avg": "234000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech"
  },
  {
    "salary_year_avg": "202000.0",
    "job_location": "California",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart Global Tech"
  },
  {
    "salary_year_avg": "193048.0",
    "job_location": "Fairview, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury"
  },
  {
    "salary_year_avg": "193048.0",
    "job_location": "St Charles, MO",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "U.S. Department of the Treasury"
  },
  {
    "salary_year_avg": "174000.0",
    "job_location": "Irving, TX",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wells Fargo"
  },
  {
    "salary_year_avg": "170500.0",
    "job_location": "Oakland, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Blue Shield of California"
  },
  {
    "salary_year_avg": "170000.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Office of the Secretary of Defense"
  },
  {
    "salary_year_avg": "153000.0",
    "job_location": "Sunnyvale, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Walmart"
  },
  {
    "salary_year_avg": "152650.0",
    "job_location": "Maryland",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "salary_year_avg": "152221.5",
    "job_location": "Anywhere",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Patent and Trademark Office"
  },
  {
    "salary_year_avg": "152221.5",
    "job_location": "Fort Meade, MD",
    "job_schedule_type": "Part-time",
    "company_name": "US Defense Counterintelligence and Security Agency"
  },
  {
    "salary_year_avg": "145000.0",
    "job_location": "Herndon, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "IBM"
  },
  {
    "salary_year_avg": "126801.5",
    "job_location": "Philadelphia, PA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Department of Transportation"
  },
  {
    "salary_year_avg": "126801.5",
    "job_location": "Chicago, IL",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "US Department of Transportation"
  },
  {
    "salary_year_avg": "126765.0",
    "job_location": "Carson City, NV",
    "job_schedule_type": "Part-time",
    "company_name": "Change Healthcare"
  },
  {
    "salary_year_avg": "125000.0",
    "job_location": "San Bruno, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Wal-Mart"
  },
  {
    "salary_year_avg": "120200.0",
    "job_location": "Long Beach, CA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "SCAN Health Plan"
  },
  {
    "salary_year_avg": "119550.0",
    "job_location": "McLean, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton"
  },
  {
    "salary_year_avg": "119550.0",
    "job_location": "Arlington, VA",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton, Inc."
  },
  {
    "salary_year_avg": "119550.0",
    "job_location": "Annapolis Junction, MD",
    "job_schedule_type": "Full-time and Part-time",
    "company_name": "Booz Allen Hamilton"
  }
]
*/