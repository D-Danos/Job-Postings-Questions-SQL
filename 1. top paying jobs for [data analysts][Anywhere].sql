/*
Note: These queries are set for [data analyst jobs], and can be set as [Anywhere], based on the name of the file. 

You can alter: 
*the role can do so by changing the lines that have comment -- [we define role here].
*so that the job doesn't have or can be applied from anywhere, remove or comment the lines that have comment -- [Set job apply from Anywhere].
*/

/*1. What are the top-paying jobs for [data analysts] [that can be applied from anywhere]?
Note:
-Need to have salary - Not NULL (salary_year_avg IS NOT NULL)
-We would like to see the company so we have to JOIN with the company_dim table.
-Can work from anywhere (job_location='Anywhere')
-Identify the top 10. (LIMIT 10)
-Need to have salary - Not NULL (salary_year_avg IS NOT NULL)
*/

-- Answer Question 1
    -- Query 1:
    SELECT 
        job_id,
        job_title_short,
        job_title,
        company_dim.name,
        job_country,
        salary_year_avg,
        job_schedule_type,
        job_work_from_home,
        job_location
        
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id

    WHERE 
        salary_year_avg IS NOT NULL AND
        job_location='Anywhere' AND -- [Set job apply from Anywhere]
        job_title_short='Data Analyst' -- [we define role here]


    ORDER BY salary_year_avg DESC
    LIMIT 10;