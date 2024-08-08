/*
Note: These queries are set for [data analyst jobs], and can be set as [Anywhere], based on the name of the file. 

You can alter: 
*the role can do so by changing the lines that have comment -- [we define role here].
*so that the job doesn't have or can be applied from anywhere, remove or comment the lines that have comment -- [Set job apply from Anywhere].
*/

-- 
/* 2. What are the skills required for these top-paying jobs for [data analysts] [that can be applied from anywhere]?
Note:
-This can be solved by using the Query 1 from Question 1 as a CTE, as those are the top-paying jobs.
-Need to connect tables with skills. To do have to JOIN our CTE results with skills_job_dim and skills_dim tables
-Group by skill as that whats we care about
-Added a count for skills, so I can see have frequent those skills appear for these top-paying jobs.
-Display by frequency desc, order of name.

*/

    --Query 2:
    -- This is Query 1 from the previous question as CTE
    WITH top_paying_jobs AS(
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
    LIMIT 10
    ) -- end of Query 1 as CTE

    SELECT
        skills_dim.skills,
        COUNT(skills_dim.skills) AS count_skills
    FROM top_paying_jobs
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    GROUP BY skills_dim.skills
    ORDER BY count_skills DESC, skills;
