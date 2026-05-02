/*
Question: What skills are required for the top paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles.
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
        helpings job seekers understand which skills to develop that align with top salaries.
*/

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
