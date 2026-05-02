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

/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis.
*/

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
