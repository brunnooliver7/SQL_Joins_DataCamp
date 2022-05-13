-- Left Join

SELECT c1.name AS city, code, c2.name AS country, region, city_proper_pop
FROM cities AS c1
  INNER JOIN countries AS c2
    ON c1.country_code = c2.code
ORDER BY code DESC;

SELECT c1.name AS city, code, c2.name AS country,
       region, city_proper_pop
FROM cities AS c1
    LEFT JOIN countries AS c2
    ON c1.country_code = c2.code
ORDER BY code DESC;

-- Left join (2)

SELECT c.name AS country, local_name, l.name AS language, percent
FROM countries AS c
  INNER JOIN languages AS l
    ON c.code = l.code
ORDER BY country DESC;

SELECT c.name AS country, local_name, l.name AS language, percent
FROM countries AS c
  LEFT JOIN languages AS l
    ON c.code = l.code
ORDER BY country DESC;

-- Left join (3)

SELECT name, region, gdp_percapita
FROM countries AS c
  LEFT JOIN economies AS e
    ON c.code = e.code
WHERE e.year = 2010;

SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
  LEFT JOIN economies AS e
    ON c.code = e.code
WHERE e.year = 2010
GROUP BY region;

SELECT region, AVG(gdp_percapita) AS avg_gdp
FROM countries AS c
  LEFT JOIN economies AS e
    ON c.code = e.code
WHERE e.year = 2010
GROUP BY region
ORDER BY avg_gdp DESC;

-- Right join

SELECT cities.name AS city, urbanarea_pop, countries.name AS country,
       indep_year, languages.name AS language, percent
FROM languages
  RIGHT JOIN countries
    ON languages.code = countries.code
  RIGHT JOIN cities
    ON countries.code = cities.country_code
ORDER BY city, language;

-- Full join

SELECT name AS country, code, region, basic_unit
FROM countries
  FULL JOIN currencies
    USING (code)
WHERE region = 'North America' OR region IS NULL
ORDER BY region;

-- Full join (2)

SELECT countries.name, code, languages.name AS language
FROM languages
  FULL JOIN countries
    USING (code)
WHERE countries.name LIKE 'V%' OR countries.name IS NULL
ORDER BY countries.name;

-- Full join (3)

SELECT c1.name AS country, region, l.name AS language,
       c2.basic_unit, c2.frac_unit
FROM countries AS c1
  FULL JOIN languages AS l
    USING (code)
  FULL JOIN currencies AS c2
    USING (code)
WHERE region LIKE 'M%esia';


-- A table of two cities

SELECT c.name AS city, l.name AS language
FROM cities AS c        
  CROSS JOIN languages AS l
WHERE c.name LIKE 'Hyder%';

-- Outer challenge

SELECT c.name as country, region, p.life_expectancy as life_exp
FROM countries AS c
  LEFT JOIN populations AS p
    ON c.code = p.country_code
WHERE p.year = 2010
ORDER BY p.life_expectancy
LIMIT 5;