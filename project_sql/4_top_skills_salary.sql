/*
4. What are the top skills based on salary?
- Look at the average salary associated with each skill
for data analyst postions.
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data
Analysts and helps identify the most financially rewarding skills to
acquire or improve. 

Logic steps:
1. find average of salary and not null and for remote workers, data analysts
 and round it
SELECT
    skills_dim.skills,
    Round(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = true
GROUP BY  
    skills_dim.skills
ORDER BY salary_avg DESC
LIMIT 15


4. Download result 
result> export> download as csv / json

5. Analyze skills with ai tools
prompt: These are the top paying skills for data analysts, top 15,
can you provide some quick insights into some trends into
top paying jobs



*/

SELECT
    skills_dim.skills,
    Round(AVG(job_postings_fact.salary_year_avg), 0) AS salary_avg
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND 
    job_work_from_home = true
GROUP BY  
    skills_dim.skills
ORDER BY salary_avg DESC
LIMIT 15