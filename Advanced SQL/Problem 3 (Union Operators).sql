WITH combined_job_postings AS (
    SELECT 
        job_id, job_posted_date
    FROM january_jobs
    UNION ALL
    SELECT 
        job_id, job_posted_date
    FROM february_jobs
    UNION ALL
    SELECT 
        job_id, job_posted_date
    FROM march_jobs
), monthly_skill_demand AS (
    SELECT
        skills_dim.skills,
        EXTRACT(MONTH FROM job_posted_date) AS Month,
        EXTRACT(YEAR FROM job_posted_date) AS Year,
        COUNT(combined_job_postings.job_id) AS job_count
    FROM
        combined_job_postings
        INNER JOIN skills_job_dim ON combined_job_postings.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY
    skills_dim.skills,
    Year,
    Month
)
SELECT
    skills,
    Month,
    Year,
    job_count
FROM
    monthly_skill_demand
ORDER BY
    skills,
    Year,
    Month
