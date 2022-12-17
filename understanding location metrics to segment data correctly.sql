/*
Goal: Understand how to use variables 'continent' and 'location' to segment data and obtain values that correctly represent the population
*/

/* 
VARIABLE: CONTINENT
tracks global data for each continent (Africa, Asia, Europe, North America, South America and Oceania)
*/
SELECT DISTINCT(continent) FROM ProjectWork..LocationMetrics

/*
VARIABLE: LOCATION
tracks data by country, by income status and global data (where variable continent is null)
*/
SELECT DISTINCT(location) FROM ProjectWork..LocationMetrics


/* 
WHERE clauses on LOCATION and CONTINENT variables to segment data 
*/


/* segment by country */
SELECT DISTINCT(location) FROM ProjectWork..LocationMetrics 
WHERE continent IS NOT NULL

/* segment by continents, income class, world and international */
SELECT DISTINCT(location) FROM ProjectWork..LocationMetrics 
WHERE continent IS NULL

/* segment by income class (population size available) */
SELECT location, population FROM ProjectWork..LocationMetrics 
WHERE location LIKE '%income%'
-- WHERE continent IS NULL and location LIKE '%income%'


/* segment by continent */
SELECT DISTINCT(location) FROM ProjectWork..LocationMetrics 
WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('World','International','European Union')
--WHERE continent IS NULL and location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America','Oceania')

SELECT DISTINCT(continent) FROM ProjectWork..LocationMetrics 
WHERE continent IS NOT NULL


/* 
checking if different WHERE clauses and main segmentation variable outputs same global results 
*/

SELECT continent, sum(new_deaths) as total_deaths 
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NOT NULL 
GROUP BY continent

SELECT location, sum(new_deaths) as total_deaths
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location IN ('Europe', 'South America', 'North America', 'Asia', 'Africa', 'Oceania')
-- WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('European Union', 'World', 'International')
GROUP BY location

/* takeaway: both queries outputed same result so we can segment data in these two ways*/


/* investigate global numbers aggregating by continent and how its reflected on location = World */

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NOT NULL 

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
--WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('European Union', 'World', 'International')
WHERE continent IS NULL AND location IN ('Europe', 'South America', 'North America', 'Asia', 'Africa', 'Oceania')

/* takeaway: same output aggregate by continent and by location when location is a continent */

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location = 'World'

/* include location = international in the sum */
SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('European Union', 'World')

/* takeaway: Location 'World' = all continents + 'international' */

