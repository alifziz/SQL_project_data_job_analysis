/*

3. What are the most in-demand skills for data analysts?

- Join job postings to inner join table similar to query2
- Identify the top 5 in-demand skills for a data analyst
- Focus on all job postings.
- Why? - Retrieves the top 5 skills with the highest demand
in the job market, providing insights into the most valuable
skills for job seekers.

Logic Steps:
1. Do 2 inner joins skills job dim and skills dim with job posting
fact table to count for each job what skills needed and number. Also 
limit to 5 for quick calculation
    SELECT *
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id

2. Select skills, count job id from skills job dim to count skills, adding
filter with WHERE job title data analyst and job is remote
SELECT
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS skill_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND
        job_work_from_home = true
    GROUP BY skills_dim.skills
    ORDER BY skill_count DESC
    LIMIT 5

3. Download result 
result > export > csv

4. Analyze skills with ai tools
prompt: These are the top 5 data analyst skills I found in job postings in 2023, can you analyze the skill column and display insights
and result attachment
create a horizontal bar chart with the findings

show me the chart result
Top 5 Most Demanded Data Analyst Skills (2023)

power bi ██████████████████████████████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 2,609
tableau  ████████████████████████████████████████████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░ 3,745
python   ██████████████████████████████████████████████████████████████████░░░░░░░░░░░░░░░░ 4,330
excel    ██████████████████████████████████████████████████████████████████████████████░░░░ 4,611
sql      ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████ 7,291
*/

    SELECT
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND
        job_work_from_home = true
    GROUP BY skills_dim.skills
    ORDER BY demand_count DESC
    LIMIT 5
