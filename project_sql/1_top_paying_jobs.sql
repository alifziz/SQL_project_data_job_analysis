/*
1. What are the top-paying data analyst jobs?

- Identify the top 10 highest paying Data Analyst roles
that are available remotely.
- Focuses on job postings with specified salaries 
(remove nulls)
- Why? Highligh the top paying opportunities for Data Anlysts, 
offering insights into employees

Logic Steps: 
1. Select job id, job title, job location, job schedule type,
salary year avg and job posted date from job postings fact
table

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact

2. Add filter - WHERE job work from home is false, job title is
Data analyst and salary year avg is not null

WHERE
   -- job_work_from_home = False AND 
    job_location = 'Anywhere' AND
    job_title_short ='Data Analyst' AND 
    salary_year_avg IS NOT NULL

    
3. Order by the query in decending order and limit to 
top 10

ORDER BY salary_year_avg DESC 
LIMIT 10;

4. Analyze skills with ai tools
prompt: These are the top 10 data analyst roles I found in job postings in 2023, can you analyze the skill column and display insights
and result attachment
create a horizontal bar chart with the findings

show me the chart result
*/


SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
-- For analysis purpose     
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
   -- job_work_from_home = False AND 
   job_location = 'Anywhere' AND
    job_title_short ='Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC 
LIMIT 10;