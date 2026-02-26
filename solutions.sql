-- Netflix Project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix( 
show_id	VARCHAR(6),
types VARCHAR(10),
title VARCHAR(150),	
director VARCHAR(208),	
castS VARCHAR(1000),	
country	VARCHAR(150),
date_added VARCHAR(50),
release_year INT,
rating VARCHAR(10),
duration  VARCHAR(15),	
listed_in VARCHAR(150),
description VARCHAR(250)
);
SELECT * FROM netflix;

SELECT 
COUNT(*) AS total_count 
FROM netflix;

SELECT DISTINCT type FROM netflix;

-- 15 BUSINESS PROBLEMS
-- 1. Count the number of Movies vs TV Shows
SELECT * FROM netflix;
SELECT types,COUNT(*) FROM netflix as total_content GROUP BY types ;

--2. Find the most common rating for movies and TV shows
SELECT rating,COUNT(*) FROM netflix GROUP BY rating ORDER BY COUNT(*) DESC LIMIT 1;

--3. List all movies released in a specific year (e.g., 2020)
SELECT release_year,COUNT(*) FROM netflix GROUP BY release_year ORDER BY COUNT(*) DESC;

--4. Find the top 5 countries with the most content on Netflix
SELECT country,COUNT(types) AS total_content FROM netflix WHERE country IS NOT NULL GROUP BY country ORDER BY COUNT(types) DESC LIMIT 5; 

--5. Identify the longest movie
SELECT * FROM netflix;
SELECT * FROM netflix WHERE duration IS NOT NULL ORDER BY duration DESC LIMIT 1;

--6. Find content added in the last 5 years
SELECT * FROM netflix WHERE date_added >=CURRENT_DATE - INTERVAL '10 years';

--7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT * FROM netflix WHERE director='Rajiv Chilaka';

--8. List all TV shows with more than 5 seasons
SELECT * FROM netflix WHERE types='TV Show' AND duration>'5 seaons';

--9. Count the number of content items in each genre
SELECT listed_in,COUNT(*) FROM netflix GROUP BY listed_in;

--10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!
SELECT * FROM netflix;
SELECT release_year,COUNT(title) AS content_realesed_in_India FROM netflix WHERE country='India' GROUP BY release_year ORDER BY release_year DESC LIMIT 5;

--11. List all movies that are documentaries
SELECT * FROM netflix WHERE listed_in LIKE '%Documentaries%';

--12. Find all content without a director
SELECT * FROM netflix WHERE director IS NULL;

--13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT * FROM netflix WHERE casts LIKE '%Salman Khan%' AND release_year> EXTRACT(YEAR FROM CURRENT_DATE)-10;

--14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
SELECT UNNEST(STRING_TO_ARRAY(casts,',')) AS ACTORS,COUNT(*) AS TOTAL_NO_MOVIES FROM netflix WHERE country='India' GROUP BY UNNEST(STRING_TO_ARRAY(casts,',')) ORDER BY COUNT(*) DESC LIMIT 10;

--15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.
SELECT * FROM netflix;

SELECT 
    CASE 
        WHEN LOWER(description) LIKE '%kill%' 
          OR LOWER(description) LIKE '%violence%' 
        THEN 'Bad'
        ELSE 'Good'
    END AS content_category,
    COUNT(*) AS total_count
FROM netflix
GROUP BY content_category;