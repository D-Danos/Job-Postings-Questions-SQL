/*
Note: These queries are set for [data analyst jobs], and can be set as [Anywhere], based on the name of the file. 

You can alter: 
*the role can do so by changing the lines that have comment -- [we define role here].
*so that the job doesn't have or can be applied from anywhere, remove or comment the lines that have comment -- [Set job apply from Anywhere].
*/

/*4. What are the top skills based on salary for [data analysts]?
-Note: We need more than the job_id from job_postings_fact unlike question 3, so I will just JOIN the tables.
-We need to connect skills with salary and to do so we need to JOIN job_posting_fact->skills_job_dim->skills_dim
-For the role of data analyst and not NULL salary 
*/

--Query 4:

SELECT 
    skills_dim.skill_id,
    skills,
    ROUND(AVG(salary_year_avg),2) AS average_salary_skill -- round to reduce the number of decimals
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
        salary_year_avg IS NOT NULL AND
        --job_location='Anywhere' AND -- [Set job apply from Anywhere]
        job_title_short='Data Analyst' -- [we define role here]
GROUP BY skills_dim.skill_id
ORDER BY average_salary_skill DESC
LIMIT 30;