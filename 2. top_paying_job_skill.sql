/*
Question: What skills are required for the top-paying Data analyst jobs?
-Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
   job_id,
   job_location,
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
LIMIT 10

)

SELECT
top_paying_jobs.*,
skills AS Skill_type
FROM 
   top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY
   salary_year_avg DESC;
