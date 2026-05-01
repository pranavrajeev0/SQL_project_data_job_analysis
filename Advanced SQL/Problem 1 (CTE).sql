WITH job_count AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS Number_of_postings
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name,
    job_count.Number_of_postings
FROM
    company_dim
    INNER JOIN job_count ON company_dim.company_id = job_count.company_id
ORDER BY
    job_count.Number_of_postings DESC
LIMIT 10;
    