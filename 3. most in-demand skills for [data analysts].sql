/*
Note: These queries are set for [data analyst jobs], and can be set as [Anywhere], based on the name of the file. 

You can alter: 
*the role can do so by changing the lines that have comment -- [we define role here].
*so that the job doesn't have or can be applied from anywhere, remove or comment the lines that have comment -- [Set job apply from Anywhere].
*/

/*3. What are the most in-demand skills for [data analysts]?
-Chose to grab the job_id in a subquery within WHERE statement.
-Now that I have the relevant job ids, just need to JOIN skills_dim and skill_job_dim table those (job_id).
-Display top 30 by order of frequency descending.
-This is for all job postings NOT applied from Anywhere (it's commented out).
-Display by frequency desc, order of name.

*/

--Query 3

SELECT 
    skills_dim.skill_id,
    skills,
    COUNT(skills) AS count_skills
FROM skills_dim
INNER JOIN skills_job_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE 
    job_id IN(

    SELECT job_id 
    FROM job_postings_fact
    WHERE 
        --job_location='Anywhere' AND -- [Set job apply from Anywhere]
        job_title_short='Data Analyst' -- [we define role here]

    )
GROUP BY skills_dim.skill_id
ORDER BY count_skills DESC,skills
LIMIT 20;