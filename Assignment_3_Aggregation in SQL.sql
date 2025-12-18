USE world;
#1
SELECT
    c.Name AS country_name,
    COUNT(ci.ID) AS city_count
FROM country c
LEFT JOIN city ci ON ci.CountryCode = c.Code
GROUP BY c.Code, c.Name
ORDER BY city_count DESC;
#2
SELECT
    Continent,
    COUNT(*) AS country_count
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30
ORDER BY country_count DESC;
#3
SELECT
    Region,
    SUM(Population) AS total_population
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000
ORDER BY total_population DESC;
#4
SELECT
    Continent,
    AVG(GNP) AS avg_gnp_per_country
FROM country
GROUP BY Continent
ORDER BY avg_gnp_per_country DESC
LIMIT 5;
#5
SELECT
    c.Continent,
    COUNT(DISTINCT cl.Language) AS official_language_count
FROM country c
JOIN countrylanguage cl
      ON cl.CountryCode = c.Code
     AND cl.IsOfficial = 'T'
GROUP BY c.Continent
ORDER BY official_language_count DESC;
#6
SELECT
    Continent,
    MAX(GNP) AS max_gnp,
    MIN(GNP) AS min_gnp
FROM country
GROUP BY Continent
ORDER BY Continent;
#7
SELECT
    c.Name AS country_name,
    AVG(ci.Population) AS avg_city_population
FROM country c
JOIN city ci ON ci.CountryCode = c.Code
GROUP BY c.Code, c.Name
ORDER BY avg_city_population DESC
LIMIT 1;
#8
SELECT
    c.Continent,
    AVG(ci.Population) AS avg_city_population
FROM country c
JOIN city ci ON ci.CountryCode = c.Code
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000
ORDER BY avg_city_population DESC;
#9
SELECT
    Continent,
    SUM(Population) AS total_population,
    AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
GROUP BY Continent
ORDER BY avg_life_expectancy DESC;
#10
SELECT
    Continent,
    SUM(Population) AS total_population,
    AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY avg_life_expectancy DESC
LIMIT 3;

