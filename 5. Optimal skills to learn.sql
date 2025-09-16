/*
  Question: What are the most optimal skills to learn?
  --Identify skills in high demand and associated with high average salaries for the Data analyst role.
  -- Remote jobs only
  --Why? To target skills that offer job security and financial benefits, offering strategic insights
     for career development in Data analysis.
     */
 
 
 
 
 WITH skill_count AS(

      SELECT 
         skills_dim.skill_id,
         COUNT(*) AS skill_count,
         skills_dim.skills AS skill_name
     FROM 
         skills_job_dim

    INNER JOIN 
        job_postings_fact ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id=skills_job_dim.skill_id
    WHERE
       job_title_short='Data Analyst' AND job_work_from_home= True
    AND salary_year_avg IS NOT NULL
    GROUP BY
      skills_dim.skill_id

    ),average_salary AS (
      SELECT
         skills_dim.skill_id,
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
         skills_dim .skill_id
         )

   SELECT
    skill_count.skill_id,
    skill_count.skill_name,
    skill_count,
    avg_salary
FROM 
  skill_count
INNER JOIN
    average_salary ON skill_count.skill_id=average_salary.skill_id
WHERE 
   skill_count >10
ORDER BY
   avg_salary DESC,
   skill_count DESC
LIMIT 25;
