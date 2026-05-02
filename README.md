# Introduction
📊Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and where high demand meets high salary in data analytics.

SQL queries? Check them out here: [project_sql folder](/project_SQL/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from the [SQL Course](https://lukebarousse/sql). It's packed with insights on job titles, salaries, locations, and essential skills

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are the most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL**: The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL**: The chosen database management system, ideal for handling the job posting data.
- **Visual studio code**: My go-to  for database management and executing SQL queries.
- **Git & GitHub**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company_name,
    job_postings.job_location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg,
    job_postings.job_posted_date
FROM
    job_postings_fact AS job_postings
    LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
 ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide salary range**: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers**: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety**: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

### 2. Skills required for top paying Data Analyst Jobs
To identify the key skills required for the highest-paying Data Analyst roles, I used the top 10 highest-paying jobs from the previous query and joined them with the skills dataset. This approach highlights the specific technical and analytical skills associated with high-salary positions

```sql
SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.company_name,
    skills_dim.skills,
    top_paying_jobs.salary_year_avg
FROM(
    SELECT
        job_postings.job_id,
        job_postings.job_title,
        companies.name AS company_name,
        job_postings.job_location,
        job_postings.job_schedule_type,
        job_postings.salary_year_avg,
        job_postings.job_posted_date
    FROM
        job_postings_fact AS job_postings
        LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    ORDER BY
        salary_year_avg DESC
    LIMIT 10 ) AS top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;
```
Here's the breakdown of the required skills for top paying data analyst jobs in 2023:
- **SQL** and **Python** appear consistently across top-paying roles, making them essential for high-paying data analyst positions.
- Skills like **AWS, Azure, Databricks**, and **Hadoop** highlight the importance of working with large-scale data systems.
- Indicates that higher salaries are often linked to data engineering and cloud integration capabilities

### 3. Most in-demand skills for Data Analysts
To identify the most in-demand skills for Data Analysts, I analyzed remote job postings and counted how frequently each skill appears. This approach highlights the skills that are most sought after in the remote job market.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM
    skills_job_dim
    INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst' AND
    job_postings_fact.job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Here's the breakdown of the Most in-demand skills for Data Analyst jobs in 2023:
- **SQL as a Core Skill:**
SQL stands out as the most essential skill for remote data analyst roles, forming the foundation for querying and managing data.
- **Importance of Excel:**
Excel remains widely used in remote jobs for organizing, cleaning, and analyzing data efficiently.
- **Python for Advanced Work:**
Python is highly valued in remote roles for handling complex data tasks, automation, and deeper analysis.
- **Role of Visualization Tools:**
Tools like Tableau and Power BI are important in remote environments for presenting insights and building dashboards for stakeholders.

### 4. Top Skills based on Salary
To identify the highest-paying skills for Data Analysts, I analyzed remote job postings and calculated the average salary associated with each skill. This approach highlights which skills are linked to higher compensation in remote data analyst roles.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Here's the breakdown of the top paying skills for the Data analyst jobs in 2023:
- Skills like PySpark and Databricks are highly valued in remote roles, showing the importance of handling large-scale distributed data.
- Technologies such as Kubernetes and Airflow highlight the demand for analysts who can work with cloud-based systems in remote environments.
- Tools like Pandas, NumPy, and Jupyter remain essential for performing advanced data analysis and automation.
- Skills like GitLab and Jenkins indicate that remote roles value professionals who can collaborate, manage workflows, and integrate with production systems.

### Most optimal skills for Data Analyst jobs
To identify the most optimal skills for Data Analysts, I analyzed skills based on both demand and average salary. This helps highlight skills that are not only commonly requested by employers but also connected to higher-paying roles.

**Alternative Query**
```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary,
    COUNT (job_postings_fact.job_id) AS demand_count
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 25;
```

**Main Query**
```sql
WITH top_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM
        skills_job_dim
        INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_title_short = 'Data Analyst' AND
        job_postings_fact.job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
    ORDER BY
        demand_count DESC
), top_paying AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id,
        skills_dim.skills
    ORDER BY
        avg_salary DESC
    
)
SELECT
    top_paying.skills,
    top_paying.avg_salary,
    top_demand.demand_count
FROM
    top_paying
    INNER JOIN top_demand ON top_paying.skill_id = top_demand.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC;
```
Here's the breakdown of the Most optimal skills for Data Analysts to learn:
- **SQL as the Best Starting Point**: SQL appears as the strongest skill because it combines high demand with solid salary potential, making it essential for data analyst roles.
- **Excel and Visualization Tools**: Excel, Tableau, and Power BI remain highly valuable because they are widely used for analysis, reporting, and communicating insights.
- **Python for Career Growth**: Python stands out as an important skill for analysts who want to move into more advanced analytics, automation, and technical roles.
- **Cloud and Advanced Tools**: Skills like Snowflake, Azure, AWS, and Hadoop show that learning modern data tools can improve career opportunities and salary potential.
- **Balanced Skill Strategy**: The best skills to learn are those that provide both job security through high demand and financial benefits through higher salaries.

# What I Learned

- **High-paying roles require more than basic skills:** The analysis shows that top-paying Data Analyst jobs often demand a combination of advanced tools, cloud technologies, and data processing skills rather than just foundational knowledge.
- **Core skills remain essential across all levels:** Despite the presence of advanced tools, skills like SQL, Python, and Excel consistently appear across both high-paying and high-demand roles, making them critical for entry and growth in the field.
- **Demand and salary do not always align perfectly:** Some skills are highly demanded but not necessarily the highest paying, while others offer higher salaries but appear less frequently. This highlights the importance of balancing both factors when choosing which skills to develop.
- **Visualization and communication are key:** Tools like Tableau and Power BI show that presenting insights effectively is just as important as analyzing data, especially in business-focused roles.
- **The data analytics field is becoming more technical:** The presence of tools related to big data, cloud platforms, and data engineering indicates that the role of a Data Analyst is evolving toward more technical and interdisciplinary responsibilities.
- **Practical application of SQL in analysis:** This project helped apply SQL in a real-world context to filter, join, and aggregate data in order to extract meaningful insights about the job market.

# Conclusion
This analysis highlights that the Data Analyst job market offers strong opportunities, but success depends on developing the right combination of skills. Foundational tools like SQL, Python, and Excel remain essential, while knowledge of cloud platforms and advanced technologies can significantly enhance earning potential. Overall, the most optimal approach is to build a balanced skill set that aligns both with market demand and higher salary opportunities
