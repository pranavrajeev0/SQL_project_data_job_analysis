SELECT
    quarter1_jobpostings.job_id,
    quarter1_jobpostings.job_title_short,
    quarter1_jobpostings.job_location,
    quarter1_jobpostings.job_via,
    quarter1_jobpostings.salary_year_avg,
    skills_dim.skills,
    skills_dim.type
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobpostings
    LEFT JOIN skills_job_dim ON quarter1_jobpostings.job_id = skills_job_dim.job_id
    LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg > 70000
ORDER BY
    quarter1_jobpostings.job_id;
