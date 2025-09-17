  # Introduction

  I examine the data job market, focusing on data analyst roles. This project examines the top-paying jobs, in-demand skills, and where high demand meets high pay in data analytics.

  #   Background
  Got my data from my SQL Course, and it's packed with insights on job titles, salaries, locations, and essential skills.

  **The questions I wanted to answer through my SQL queries were:**
   - What are the top-paying data analyst jobs?
-   What skills are required for these top-paying jobs?
   - What skills are most in demand for data analysis?
  - Which skills are associated with higher salaries?
   - What are the most optimal skills to learn?

 # Tools I Used
 **For my analysis, I employed the help of a couple of key tools, which included:**
- **SQL:** It serves as the fundamental tool for my analysis, allowing me to query the database and generate insights.
-   **PostgreSQL:** It was the database management system used.
-   **Visual Studio:** Connected to my PostgreSQL for database management and for executing SQL queries.

  # The Analysis
**The analysis shows how each question was tackled:** 

  1. **Top-Paying Data Analyst Jobs:** To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs only. The query below highlights the high-paying opportunities in data analysis.
```sql
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
```
**Key takeaways:**
-  **Remote work dominates:**  All roles are “Anywhere.”

- **Salary spread is uneven:** Most jobs cluster in the 185k–220k range, with a few very high-paying outliers.

- **Big brand effect:**  Meta and AT&T offer above-average salaries compared to smaller firms.

- **SmartAsset:** is actively hiring multiple Data Analysts, though at mid-level salaries.

- **Median is more reliable than average:**  Shows a more realistic expectation for analysts (~206k).




2. **Skills required for a top-paying Data Analyst Job:** I looked into the top skills required to get high-paying opportunities as a data analyst, and I filtered data analyst roles by average salary, location as remote, and the companies paying these salaries. The query below highlights the skills required, the pay, and the company names.
``` sql
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
```
**Key takeaways:**

- **Core Skills Are Standard:**
SQL, Python, Tableau, and Excel appear across nearly all roles, making them non-negotiable entry skills. Even lower-paying jobs still demand this toolkit.

- **Salary Rises with Skill Breadth:**
Higher salaries are linked to broader stacks: cloud platforms, BI tools, and communication skills. Top earners blend analyst and engineer capabilities.

- **Cloud & Big Data = Premium Pay:**
AWS, Azure, Databricks, and Snowflake show up in higher-paying roles. Analysts who manage large-scale data systems earn significantly more.

- **BI Tools Differentiate Analysts:**
Tableau is expected almost everywhere, while Power BI, Crystal Reports, and Flow add niche advantages. Multi-tool BI skills boost competitiveness.


- **Career Strategy:**
Start with SQL + Python + Tableau + Excel. Add cloud + BI mastery to move up, and aim for hybrid analyst-engineer roles for top pay.

3. **Top skills in demand:** I looked into the top 5 skills that are in demand for job opportunities. The query below highlights the top 5 skills in demand for a data analyst.

```sql
ELECT 
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

WITH remote_job AS(SELECT 
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
``` 
**Key takeaways:** 

- **SQL leads the pack** – With 7,291 mentions, SQL is the backbone of data analysis roles, making it the most essential skill for handling and querying structured data.

- **Excel still matters** – Despite the rise of advanced tools, 4,611 mentions of Excel show it remains a go-to for quick analysis, reporting, and day-to-day business tasks.

- **Programming and BI tools are rising** – Python (4,330) enables automation and advanced analytics, while Tableau (3,745) and Power BI (2,609) highlight the growing demand for data visualization and storytelling skills.

4. **Top skills based on pay:** Dive into uncovering skills with high salary payment. There are top skills required of a data analyst for job opportunities, but this answers the question of which skill gets the highest pay?. The query below shows skills with the highest average salaries.

```sql
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
```
**Key takeaways:**

- **High-paying niche skills** – SVN stands out with an average salary of $400,000, far ahead of the rest, suggesting rare expertise or specialized roles command extraordinary pay.

- **Emerging technologies pay well** – Skills like Solidity ($179K) and Golang ($155K) show strong compensation, reflecting demand in blockchain and modern backend development.

- **AI/ML and data tools are lucrative** – Tools such as DataRobot ($155K), MXNet ($149K), and dplyr ($148K) highlight how machine learning frameworks and data manipulation libraries offer high-paying opportunities.

- **DevOps and cloud remain valuable** – Terraform ($147K) and VMware ($148K) illustrate the premium on infrastructure automation and virtualization expertise.

- **API & integration skills pay competitively** – Twilio ($139K) shows that even communication/API integration expertise can yield strong salaries.

👉 *Overall: While generalist tools like SQL or Excel are essential, specialized technical skills—especially in blockchain, AI/ML, and cloud engineering—drive the highest salaries.*

5. **Optimal skills to learn:** What skill offers job security and high pay? This is the question that is being answered. To have a long and interesting career in data analysis, you need a skill that is in demand forever and pays high. The query below gives an insight into skills that offer job security and a high salary.

```sql
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
```

**Key takeaways:**

- **High-paying data engineering skills:** – Tools like Confluence ($114K), Spark ($113K), and Snowflake ($112K) top the list, showing strong demand for advanced data management and collaboration platforms.

- **Cloud platforms remain competitive:** – AWS ($106K), Azure ($105K), and BigQuery ($105K) reflect the ongoing need for cloud and big data expertise, all offering six-figure salaries.

- **Programming languages are essential but slightly lower-paid:** – Python ($101K), Java ($100K), and R ($98K) show high usage but moderate salaries compared to niche tools, likely due to wider availability of talent.

- **Analytics and BI tools are widely used but not the highest paid:** – Tableau ($98K) and SQL ($96K) appear most frequently in job listings (hundreds of mentions) but average lower salaries compared to specialized tools.

- **Specialized BI and ETL tools also offer solid pay;** – Alteryx ($106K), Qlik ($101K), and SSIS ($97K) demonstrate that ETL and reporting expertise continues to be valued across industries.

👉 *Overall: Niche data engineering and cloud tools command higher pay, while core languages (Python, SQL, R) and BI tools (Tableau, Qlik) are more common, offering strong job security but slightly lower average salaries.*

# What I learned 

During the course of the project, I was able to improve my SQL usage skills.
- **Complex Query Usage:** I was able to use advanced queries such as CTEs, and I was able to join tables like a pro.
- **Data Aggregation:** I used the GROUP BY function and also employed aggregates like COUNT(), AVG() as data summarizing tools.
- **Analytical Improvement:** Leveled up on my problem-solving skills, turning questions into insightful, actionable SQL queries.

# Conclusion 

- The findings show that core skills like SQL, Python, Excel, Tableau, and Power BI are the most in-demand, forming the foundation for most data roles. Their widespread adoption makes them essential, but also keeps salaries relatively moderate due to the large talent pool.

- On the other hand, specialized and emerging skills such as Spark, Snowflake, Golang, and Solidity command much higher salaries despite lower demand. Cloud platforms (AWS, Azure) and collaboration tools (Jira, Confluence) also add value, showing that technical and workflow skills together strengthen employability.

- Overall, success in the data job market requires a balance of strong fundamentals and selective specialization. Core tools ensure career stability, while advanced or niche expertise can unlock higher-paying opportunities and long-term growth
