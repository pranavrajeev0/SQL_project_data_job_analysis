WITH top_5_skills AS (
    SELECT
        skill_id,
        COUNT(job_id) AS job_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        job_count DESC
    LIMIT 5
)
SELECT 
    skills_dim.skills,
    top_5_skills.job_count
FROM 
    skills_dim
    INNER JOIN top_5_skills ON skills_dim.skill_id = top_5_skills.skill_id;

