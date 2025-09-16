/*
 Question: What are the top 10 skils based on salary?
 --Look at the average salary associated with each skill for Data analyst positions.
 --Why? it shows how diffrerent skills impact salary levels for Data Analyst and helps to identify the most financially rewarding skills to acquire.
 */

SELECT
  skills AS skill_name,
   ROUND(AVG(salary_year_avg),0)AS avg_salary
FROM
   job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
WHERE
  salary_year_avg IS NOT NULL AND 
  job_title_short='Data Analyst'
GROUP BY
   skill_name
ORDER BY
 avg_salary DESC
LIMIT 10;

 
