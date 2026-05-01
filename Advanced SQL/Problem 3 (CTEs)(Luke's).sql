WITH Unique_skills AS (
    SELECT
        companies.company_id,
        COUNT(DISTINCT skills_job_dim.skill_id) AS unique_skill_count
    FROM
        company_dim AS companies
        LEFT JOIN job_postings_fact AS job_postings ON companies.company_id = job_postings.company_id
        LEFT JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
    GROUP BY
        companies.company_id
), Max_salary AS (
    SELECT 
        company_id,
        MAX(salary_year_avg) AS Highest_salary
    FROM
        job_postings_fact AS job_postings
    WHERE
    job_postings.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY
        company_id
)
SELECT
    companies.name AS company_name,
    Unique_skills.unique_skill_count,
    Max_salary.Highest_salary
FROM
    company_dim AS companies
    LEFT JOIN Unique_skills ON companies.company_id = Unique_skills.company_id
    LEFT JOIN Max_salary ON companies.company_id = Max_salary.company_id
ORDER BY
    company_name;
