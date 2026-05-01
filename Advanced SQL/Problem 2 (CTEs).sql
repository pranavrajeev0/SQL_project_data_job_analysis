WITH national_average AS (
    SELECT
        job_id,
        job_country,
        AVG(salary_year_avg) AS national_avg
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL AND
        job_country IS NOT NULL
    GROUP BY
        job_country,
        job_id
)
SELECT
    job_postings.job_id,
    job_postings.job_title,
    company_dim.name,
    job_postings.salary_year_avg,
    CASE 
        WHEN job_postings.salary_year_avg > national_average.national_avg THEN 'Above average'
        ELSE 'Below average'
    END AS salary_category,
    EXTRACT(MONTH FROM job_posted_date) AS posting_month
FROM
    company_dim
    INNER JOIN job_postings_fact AS job_postings ON company_dim.company_id = job_postings.company_id
    INNER JOIN national_average ON job_postings.job_id = national_average.job_id
ORDER BY
    posting_month DESC;