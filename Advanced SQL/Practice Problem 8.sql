SELECT 
    quarter_1_jobs.job_title,
    quarter_1_jobs.job_location,
    quarter_1_jobs.job_via,
    quarter_1_jobs.job_posted_date::date,
    quarter_1_jobs.salary_year_avg
FROM (  
    SELECT*
    FROM
        january_jobs
    UNION ALL
    SELECT*
    FROM
        february_jobs
    UNION ALL
    SELECT*
    FROM
        march_jobs
) AS quarter_1_jobs
WHERE
    salary_year_avg > 70000 AND
    quarter_1_jobs.job_title_short = 'Data Analyst';