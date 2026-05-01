SELECT 
    job_id,
    job_title,
    salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100000 THEN 'High Salary'
        WHEN salary_year_avg >= 60000 AND salary_year_avg < 100000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM 
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;