(
SELECT
    job_id,
    job_title,
    'with_salary_info' AS salary_info
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
)
UNION ALL
(
SELECT
    job_id,
    job_title,
    'without_salary_info' AS salary_info
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NULL
)
ORDER BY
    salary_info DESC,
    job_id;