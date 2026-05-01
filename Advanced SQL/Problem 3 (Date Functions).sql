SELECT 
    companies.name AS company_name,
    COUNT(job_postings.job_title_short) AS job_count
FROM job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE
    job_postings.job_health_insurance = TRUE AND
    EXTRACT(Quarter FROM job_posted_date) = 2
GROUP BY
    companies.name
HAVING
    COUNT(job_postings.job_title_short) > 1
ORDER BY
    job_count DESC;