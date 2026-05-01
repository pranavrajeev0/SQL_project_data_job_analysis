WITH remote_skills AS (
    SELECT 
        skill_id,
        Count(job_postings_fact.job_id) AS job_count
    FROM
        skills_job_dim
        INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND
        job_postings_fact.job_title_short = 'Data Analyst'
    Group by
        skill_id
)
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    remote_skills.job_count
FROM
    skills_dim
    INNER JOIN remote_skills ON skills_dim.skill_id = remote_skills.skill_id
Order by
    job_count DESC
LIMIT 5;
