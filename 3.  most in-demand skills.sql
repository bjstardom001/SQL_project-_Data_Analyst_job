/*
Question: What are the top 5 skills in demand?
-Why? it helps to know which skills to learn to enhance employment opportunity
*/

SELECT 
     COUNT(*) AS skill_count,
     skills_dim.skills AS skill_name
FROM 
   skills_job_dim

 INNER JOIN 
  job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
  INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
 WHERE
  job_title_short='Data Analyst' AND job_work_from_home= True
GROUP BY
skill_name
ORDER BY
 skill_count DESC
LIMIT 5;
--OR

WITH remote_job AS
(SELECT 
     skill_id,
     COUNT(*) AS skill_count
FROM 
   skills_job_dim

 INNER JOIN 
  job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
 WHERE
  job_title_short='Data Analyst' AND job_work_from_home= True
GROUP BY
skill_id
)

SELECT 
  skills_dim.skill_id,
  skills AS skill_name,
  skill_count
FROM remote_job 
INNER JOIN skills_dim ON skills_dim.skill_id=remote_job.skill_id
ORDER BY
 skill_count DESC
LIMIT 5;
