WITH remote_job_count AS(
    SELECT
        job_id
    FROM
        job_postings_fact
    WHERE
        job_work_from_home = TRUE AND
        job_title_short = 'Data Analyst'
)
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(remote_job_count.job_id) AS job_count
FROM
    skills_dim
    LEFT JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    LEFT JOIN remote_job_count ON skills_job_dim.job_id = remote_job_count.job_id
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
ORDER BY
    job_count DESC
LIMIT 5;
