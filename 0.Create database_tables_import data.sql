-- Create the database
    CREATE DATABASE job_postings;
-- Create the tables, then set ownership and index

    -- Create company_dim table with primary key
    CREATE TABLE public.company_dim
    (
        company_id INT PRIMARY KEY,
        name TEXT,
        link TEXT,
        link_google TEXT,
        thumbnail TEXT
    );

    -- Create skills_dim table with primary key
    CREATE TABLE public.skills_dim
    (
        skill_id INT PRIMARY KEY,
        skills TEXT,
        type TEXT
    );

    -- Create job_postings_fact table with primary key
    CREATE TABLE public.job_postings_fact
    (
        job_id INT PRIMARY KEY,
        company_id INT,
        job_title_short VARCHAR(255),
        job_title TEXT,
        job_location TEXT,
        job_via TEXT,
        job_schedule_type TEXT,
        job_work_from_home BOOLEAN,
        search_location TEXT,
        job_posted_date TIMESTAMP,
        job_no_degree_mention BOOLEAN,
        job_health_insurance BOOLEAN,
        job_country TEXT,
        salary_rate TEXT,
        salary_year_avg NUMERIC,
        salary_hour_avg NUMERIC,
        FOREIGN KEY (company_id) REFERENCES public.company_dim (company_id)
    );

    -- Create skills_job_dim table with a composite primary key and foreign keys
    CREATE TABLE public.skills_job_dim
    (
        job_id INT,
        skill_id INT,
        PRIMARY KEY (job_id, skill_id),
        FOREIGN KEY (job_id) REFERENCES public.job_postings_fact (job_id),
        FOREIGN KEY (skill_id) REFERENCES public.skills_dim (skill_id)
    );

    -- Set ownership of the tables to the postgres user
    ALTER TABLE public.company_dim OWNER to postgres;
    ALTER TABLE public.skills_dim OWNER to postgres;
    ALTER TABLE public.job_postings_fact OWNER to postgres;
    ALTER TABLE public.skills_job_dim OWNER to postgres;

    -- Create indexes on foreign key columns for better performance
    CREATE INDEX idx_company_id ON public.job_postings_fact (company_id);
    CREATE INDEX idx_skill_id ON public.skills_job_dim (skill_id);
    CREATE INDEX idx_job_id ON public.skills_job_dim (job_id);

-- Import the data: Remember to set you path for the CSV files
    COPY company_dim
    FROM 'C:\set\your\path\company_dim.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

    COPY skills_dim
    FROM 'C:\set\your\path\skills_dim.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

    COPY job_postings_fact
    FROM 'C:\set\your\path\job_postings_fact.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

    COPY skills_job_dim
    FROM 'C:\set\your\path\skills_job_dim.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--DATABASE is ready.