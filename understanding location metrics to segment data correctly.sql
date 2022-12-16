/*
Goal: Understand variables 'continent' and 'location' to segment data and obtain correct values 
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
SELECT DISTINCT(location) FROM ProjectWork..LocationMetrics WHERE continent IS NULL

/*
Income values segment population by income class (population size is also provided)
*/
SELECT location, population FROM ProjectWork..LocationMetrics WHERE location LIKE '%income%'


/* investigate total deaths by continent to understand how it is reflected on location where continent is null */

SELECT continent, sum(new_deaths) as total_deaths 
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NOT NULL 
GROUP BY continent

SELECT location, sum(new_deaths) as total_deaths
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location IN ('Europe', 'South America', 'North America', 'Asia', 'Africa', 'Oceania')
-- WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('European Union', 'World', 'International')
GROUP BY location

/* takeaway: both queries outputed same result so we can aggregate queries by continent or by location where continent is null */

/* investigate global numbers aggregating by continent and how its reflected on location = World */

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NOT NULL 

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('European Union', 'World', 'International')

/* takeaway: same output aggregate by continent and by location when location is a continent */

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location = 'World'

SELECT sum(new_deaths) as total_deaths_global
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NULL AND location NOT LIKE '%income%' AND location NOT IN ('European Union', 'World')

/* takeaway: Location 'World' = all continents + 'international' */


