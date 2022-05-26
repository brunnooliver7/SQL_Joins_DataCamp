-- Subquery inside where

SELECT AVG(life_expectancy)
FROM populations
WHERE year = 2015;

SELECT *
FROM populations
WHERE life_expectancy > 1.15 *
(
  SELECT AVG(life_expectancy)
  FROM populations
  WHERE year = 2015
)
AND year = 2015;

-- Subquery inside where (2)

-- Select fields
SELECT name, country_code, urbanarea_pop
  -- From cities
  FROM cities
-- Where city name in the field of capital cities
WHERE name IN
  -- Subquery
  (SELECT capital
   FROM countries)
ORDER BY urbanarea_pop DESC;

-- Subquery inside select

SELECT countries.name AS country, COUNT(*) AS cities_num
  FROM cities
    INNER JOIN countries
    ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;

SELECT countries.name AS country,
  (SELECT COUNT(*)
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

-- Subquery inside from

-- Select fields (with aliases)
SELECT code, COUNT(*) as lang_num
  -- From languages
  FROM languages
-- Group by code
GROUP BY code;

-- Advanced subquery

-- Select fields
SELECT name, continent, economies.inflation_rate
  -- From countries
  FROM countries
  	-- Join to economies
  	INNER JOIN economies
    -- Match on code
    USING(code)
-- Where year is 2015
WHERE economies.year = 2015;

-- Subquery challenge

-- Select fields
SELECT code, inflation_rate, unemployment_rate
  -- From economies
  FROM economies
  -- Where year is 2015 and code is not in
  WHERE year = 2015 AND code NOT IN
  	-- Subquery
  	(SELECT code
  	 FROM countries
  	 WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic%'))
-- Order by inflation rate
ORDER BY inflation_rate;

-- Final challenge

-- Select fields
SELECT DISTINCT c.name, e.*
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND e.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE region = 'Central America' AND year = 2015
-- Order by field
ORDER BY c.name;

-- Final challenge (2)

-- Select fields
SELECT region, continent, AVG(p.fertility_rate) AS avg_fert_rate
  -- From left table
  FROM countries AS c
    -- Join to right table
    INNER JOIN populations AS p
      -- Match on join condition
      ON c.code = p.country_code
  -- Where specific records matching some condition
  WHERE year = 2015
-- Group appropriately
GROUP BY continent, region
-- Order appropriately
ORDER BY avg_fert_rate;

-- Final challenge (3)

-- Select fields
SELECT name, country_code, city_proper_pop, metroarea_pop,  
      -- Calculate city_perc
      city_proper_pop / metroarea_pop * 100 AS city_perc
  -- From appropriate table
  FROM cities
  -- Where 
  WHERE name IN
    -- Subquery
    (SELECT capital
     FROM countries
     WHERE (continent = 'Europe'
        OR continent LIKE '%America'))
       AND metroarea_pop IS NOT NULL
-- Order appropriately
ORDER BY city_perc DESC
-- Limit amount
LIMIT 10;