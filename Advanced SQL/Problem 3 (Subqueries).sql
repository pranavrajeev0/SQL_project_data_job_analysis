SELECT
    company_dim.name AS company_name,
    average_yearly_salary.avg_salary AS avg_salary
FROM
    company_dim
    INNER JOIN (
                SELECT
                    company_id,
                    AVG(salary_year_avg) AS avg_salary
                FROM 
                    job_postings_fact
                WHERE 
                    salary_year_avg > (
                        SELECT
                            AVG(salary_year_avg)
                        FROM
                            job_postings_fact
                        WHERE
                            salary_year_avg IS NOT NULL
                    )
                GROUP BY
                    company_id
    ) AS average_yearly_salary ON company_dim.company_id = average_yearly_salary.company_id
ORDER BY
    avg_salary DESC;
