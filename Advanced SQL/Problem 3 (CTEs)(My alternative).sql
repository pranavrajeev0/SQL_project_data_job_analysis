SELECT
    company_dim.name AS company_name,
    COUNT(DISTINCT skills_job_dim.skill_id) AS skill_count,
    MAX(salary_year_avg) AS highest_salary
FROM
    company_dim
    LEFT JOIN job_postings_fact AS job_postings ON company_dim.company_id = job_postings.company_id
    LEFT JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
WHERE
    salary_year_avg IS NOT NULL
GROUP BY
    company_name
HAVING
    COUNT(DISTINCT skills_job_dim.skill_id) > 0;