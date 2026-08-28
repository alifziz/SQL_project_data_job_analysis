/*

2. What are the skills required for these
top-paying data analyst roles?
- Use the top 10 highest paying data analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high paying jobs demand
certain skills, helping job seekers understand which skills to develop
that aligh with top salaries

README.md

Logic Steps: 
1. Remove unnecessary columns from table (from q1) job_location, job_schedule_type, job_posted date
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM
    job_postings_fact


2. Create a CTE and include current join and table inside that
With top_paying_job AS(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)

SELECT * 
FROM top_paying_job;

3. Now INNER JOIN job id with top paying job cte and  skills_job_dim and skills_dim on skill id
and show all columns from CTR top_paying_jobs and skills
SELECT 
    top_paying_jobs.*,
    skills 
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
ORDER BY salary_year_avg DESC 

4. Download result 
result right side download as csv

5. Analyze skills with ai tools
prompt: These are the top 10 data analyst roles I found in job postings in 2023, can you analyze the skill column and display insights
and result attachment
create a horizontal bar chart with the findings

show me the chart result

📊 Horizontal Bar Chart: Top Skills for Highest-Paying Data Analyst Jobs (2023)
SQL          ████████████████████████████████████████████ 100% (10/10)
Python       ██████████████████████████████████████████  90%  (9/10)
Tableau      ██████████████████████████████████████      70%  (7/10)
Excel        ████████████████████████                    40%  (4/10)
R            ████████████████████████                    40%  (4/10)
Pandas       ██████████████████                          30%  (3/10)
Snowflake    ██████████████████                          30%  (3/10)
AWS/Azure    ██████████████████                          30%  (3/10)
Jira/Confl.  ██████████████████                          30%  (3/10)
Power BI     ████████████                                20%  (2/10)
Oracle       ████████████                                20%  (2/10)
Go           ████████████                                20%  (2/10)
GitLab       ████████████                                20%  (2/10)
Databricks   ██████                                      10%  (1/10)
Hadoop       ██████                                      10%  (1/10)
PySpark      ██████                                      10%  (1/10)
SAP          ██████                                      10%  (1/10)
Jenkins      ██████                                      10%  (1/10)

📈 Summary Statistics
┌─────────────────────────────────────────────────────────────┐
│  KEY INSIGHTS FROM THE CHART                              │
├─────────────────────────────────────────────────────────────┤
│  • Total unique skills identified: 18                     │
│  • Average skills per job: 7.2                           │
│  • Essential skills (>50% jobs):                         │
│    ✓ SQL (100%) - MANDATORY                              │
│    ✓ Python (90%) - ALMOST MANDATORY                    │
│    ✓ Tableau (70%) - HIGH DEMAND                        │
├─────────────────────────────────────────────────────────────┤
│  Mid-tier skills (20-40% jobs):                           │
│    • Excel, R (40%)                                       │
│    • Pandas, Snowflake, AWS/Azure, Jira/Confluence (30%) │
│    • Power BI, Oracle, Go, GitLab (20%)                   │
├─────────────────────────────────────────────────────────────┤
│  Niche skills (10%):                                      │
│    • Databricks, Hadoop, PySpark, SAP, Jenkins           │
└─────────────────────────────────────────────────────────────┘


*/

WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
ORDER BY salary_year_avg DESC;