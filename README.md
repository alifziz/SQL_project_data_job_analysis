# Introduction 
This is a learner project from Luke Barousse's course on Data Analyst with real data collected from 2023 job markets on Data Science jobs around the world. The data helps an aspiring or seasoned data analyst or data engineers to explore new jobs, skills required, salary rate for look for new roles or negotiate better pay.

Check out SQL queries: [project_sql](/project_sql/)

# Background
Experiential Learning method was applied while learning SQL queries for Data Analysts. I experimented, broke codes and then try to understand why it broke. 
I was curious to find out different job titles embraced by data scientists, skills needed and location benefits.

Some specific questions I was exploring include- 
1. What are the top-paying jobs for Data Analysts?
2. What are the skills required for Data Analyst's top-paying roles?
3. What are the most in-demand skills for Data Analysts?
4. Whare the top skills based on salary for Data Analysts?
5. What are the most high demand and high salary skills to learn?

# Tools I used
For deep diving in the open border Data Analyst job market, I used several tools: 
1. **SQL** : This tools allowed me to query the database and understand from the insight.
2. **PostgreSQL** : This database management was chosen to manage the job posting data.
3. **Visual Studio Code** : This was chosen for database management locally and remotely, executing SQL queries.
4. **Git and GitHub** : This tool was used for version control and to share sql scripts and analysis for project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. 
Each question was analyzed further:

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filtered data analyst positions by average yearly salary and locatio, focusing on remote jobs. This highlights high paying jobs.

```sql
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
```
![Top Paying Roles](project_sql\Assets\1_top_pay_roles.png)
* This was generated using AI tools

*Breakdown of the top paying data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Top Paying Skills
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
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
```
![Top Paying Skills](project_sql\Assets\2_top_paying_skills.png)
* This was generated using AI tools

*Breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
- **SQL** is leading with a bold count of 10.
- **Python** follows closely with a bold count of 9.
- **Tableau** is also highly sought after, with a bold count of 7.
Other skills like **R**, **Snowflake**, **Pandas**, and **Excel** show varying degrees of demand.

### 3. In-Demand Skills
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
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
    LIMIT 5;
```
![In-Demand Skills](project_sql\Assets\3_in-demand_skills.png)

*Breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

### 4. Top Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
LIMIT 15;
```

![Top Skills Based on Salary](project_sql\Assets\4_skills_based_on_salary.png)

*Breakdown of the results for top paying skills for Data Analysts:
1. ****Big Data & Distributed Computing Dominate the Top
Skill	Salary	Category**
PySpark is the #1 highest-paying skill by a huge margin ($208k). This tells us that companies are desperate for people who can process terabytes of data across clusters. If you can write PySpark, you are working with massive, enterprise-scale data—and getting paid for it.

2. **DevOps & Version Control Tools Pay Surprisingly Well**
Data analysts are no longer just "report makers." Companies want analysts who can write production-grade code, manage repositories, and navigate Linux environments. This blurs the line between Data Analyst and Data Engineer. The premium on Bitbucket ($189k) suggests these roles are embedded in engineering teams.

3. **Specialized / Niche Databases Command a Premium**
Knowing standard SQL is baseline. Knowing Couchbase or Elasticsearch—which are used for real-time, JSON-based, or search-heavy applications—puts you in a niche that few analysts occupy. Supply is low, so salary is high.

4. **Data Science & Machine Learning Stack (Still Strong, but Not #1)**
The classic Python data science stack (Pandas, NumPy, Jupyter) pays well ($143k–$153k), but they are table stakes now. The real premium goes to enterprise AI platforms like Watson and DataRobot, which suggest you are deploying models at scale, not just exploring data in notebooks.

5. **Kubernetes & Golang – The "Engineer Adjacent" Skills**
Golang and Kubernetes are not traditional data analyst skills—they are backend engineering tools. The fact that they appear here means that the highest-paying "data analyst" jobs are actually hybrid data engineering roles where you deploy models in containers and write microservices.


### 5. Most High Demand and High Salary Skills
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
-- With CTEs

WITH skills_demand AS(
    SELECT
        skills_job_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
),

average_salary AS(
    SELECT
        skills_job_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON average_salary.skill_id = skills_demand.skill_id
WHERE demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 15;

-- Alternative concise query- 
-- without CTEs

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 15;
```
![Most High Demand and High Salary Skills](project_sql\Assets\5_most_high_demand_high_salary_skills.png)

*Breakdown of the most optimal skills for Data Analysts in 2023: 
1. **The Demand vs. Salary Trade-Off**
There is a clear inverse relationship between demand and salary. The most in-demand skills (Python, R) are now so common that they no longer command a premium. The highest-paying skills are niche, specialized, or emerging tools that fewer people know.

2. **Cloud & Big Data Platforms are the "Sweet Spot"**
Cloud skills (AWS, Azure, Snowflake, BigQuery) offer the best balance of decent demand and high salary. They are not as oversaturated as Python, but still widely needed. Snowflake is particularly hot—highest demand in this category with a strong salary.

3. **The "DevOps/Productivity" Cluster – Surprisingly High Pay**
Confluence ($114k) pays more than AWS, Azure, and Hadoop—despite being "just" a documentation tool. This suggests that senior/lead analysts who manage teams and projects (and use Jira/Confluence to do so) are paid a premium for their leadership, not just technical chops.

4. **The Python & R Reality Check**
Python and R are the most demanded skills, but they are at the bottom of the salary list. This is because they are considered table stakes—every data analyst must know them, but they no longer differentiate you. You need Python plus something else (cloud, big data, or project leadership) to earn top dollar.

5. **The "Hidden Gems" – Highest ROI Skills**
If you want to maximize salary with minimal competition, learn Go (a systems language) or Confluence (project leadership). But for the best balance of demand + salary, Snowflake is the clear winner—37 postings and $113k.

6. **The Tools Being Left Behind**
Looker ($103k) and Oracle ($104k) are decent, but they lag behind cloud-native tools like Snowflake ($113k) and BigQuery ($109k). The market is moving toward cloud-native solutions, and legacy tools (Oracle, SSIS) are starting to show their age.

# What I learned
Throughout this adventure, I've improved my SQL toolkit. I have learned how to form:

- **Complex Query Crafting:** Mastered advanced SQL, merging tables and wielding WITH clauses for temp table maneuvers.
- **Data Aggregation:** Got comfortable with GROUP BY and aggregate functions like COUNT() and AVG().
- **Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusion
This project enhanced my SQL skills and provided valuable insights into the data analyst job market. As I reflect on the experience, I strongly realized the importance of continuous learning and adaptation in the field of data analytics.
