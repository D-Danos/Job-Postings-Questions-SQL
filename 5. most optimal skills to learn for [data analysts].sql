/*
Note: These queries are set for [data analyst jobs], and can be set as [Anywhere], based on the name of the file. 

You can alter: 
*the role can do so by changing the lines that have comment -- [we define role here].
*so that the job doesn't have or can be applied from anywhere, remove or comment the lines that have comment -- [Set job apply from Anywhere].
*/

/*5. What are the most optimal skills to learn for [data analysts]? (High paying AND high demand)
    This is easier that it sounds. Can be done in single query:
        -A CTE to get COUNT of skills and AVG salary of skills (GROUP BY skill_id). 
            To do that need to JOIN job_posting_fact->skills_job_dim->skills_dim tables
        -Use HAVING for our barrier of entry for frequencies and average salary of skill.
        
        Note:
        -We need to define some a cut off point for what's considered high paying
                I choose to define that skills that have 10% above the average salary of job post for [data analyst]
        */
            SELECT
                ROUND(AVG(salary_year_avg)*1.1, 2) AS average_salary_for_role -- Multiplied be 1.1 for 110% of average
            FROM job_postings_fact
            WHERE 
                    salary_year_avg IS NOT NULL AND
                    --job_location='Anywhere' AND -- [Set job apply from Anywhere]
                    job_title_short='Data Analyst' -- [we define role here]
        -- RESULT: 110% of average job post for data analysts is 103263.37 


--Query 5

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_dim.skills) AS count_skills,
    ROUND(AVG(salary_year_avg), 2) AS average_salary_skill
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL AND
    --job_location = 'Anywhere' AND -- [Set job apply from Anywhere]
    job_work_from_home=True AND
    job_title_short = 'Data Analyst' -- [we define role here]

GROUP BY skills_dim.skill_id
HAVING 
    COUNT(skills_dim.skills) > 10 AND -- skills more more than 10 times
    ROUND(AVG(salary_year_avg), 2) > 103263.37 -- Calculated it, see above
ORDER BY 
    average_salary_skill DESC,
    count_skills DESC
LIMIT 25;
