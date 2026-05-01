SELECT
    company_id,
    companies,
    CASE
        WHEN job_count >= 50 THEN 'Large'
        WHEN job_count < 50 AND job_count > 10 THEN 'Medium'
        ELSE 'Small'
    END AS company_size
FROM (
        SELECT
            company_dim.name AS companies,
            company_dim.company_id,
            COUNT(job_postings.job_id) AS job_count
        FROM
            job_postings_fact AS job_postings
            LEFT JOIN company_dim ON job_postings.company_id = company_dim.company_id
        GROUP BY
            company_dim.name,
            company_dim.company_id  
    ) AS company_jobposting_count;
