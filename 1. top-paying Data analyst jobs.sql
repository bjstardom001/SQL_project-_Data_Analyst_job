/*
Question: What are the top-paying Data analyst jobs?
-Identify the top 10 highest-paying Data Aanalyst roles that are available remotely.
-Focuses on jobs postings with specified salaries(remove NULL).
-Why? Highlight the top-paying opportunities for Data Analysis, offering insight into employment oppurtunities.
*/


SELECT
   job_id,
   job_location,
   job_schedule_type,
   salary_year_avg,
   job_title_short,
   name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim
ON job_postings_fact.company_id=company_dim.company_id
WHERE
    job_location='Anywhere' 
    AND salary_year_avg  IS NOT NULL
    AND job_title_short= 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
