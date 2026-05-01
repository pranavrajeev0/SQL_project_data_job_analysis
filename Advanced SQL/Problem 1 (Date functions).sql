SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS average_salary,
    AVG(salary_hour_avg) AS average_hourly_salary
FROM
    job_postings_fact
WHERE
    job_posted_date::date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type ASC;
