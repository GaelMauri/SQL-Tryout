--Stores the data from the csv files into the dataset to use them in the queries
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
