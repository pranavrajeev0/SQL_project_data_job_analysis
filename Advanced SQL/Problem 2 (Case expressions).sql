SELECT
    COUNT(DISTINCT companies.name) AS job_count,
    CASE
        WHEN job_work_from_home = TRUE THEN 'Remote'
        ELSE 'On-site'
    END AS location_category
FROM
    job_postings_fact AS job_postings
    LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
GROUP BY
    location_category;