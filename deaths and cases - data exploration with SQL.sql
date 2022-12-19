/* 
EXPLORING COVID DEATHS AND CASES 
*/


/* create view of covid deaths and cases by country */
CREATE VIEW DeathsAndCasesByCountry
AS
SELECT iso_code, continent, location, date, total_deaths, total_cases, new_deaths, new_cases 
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NOT NULL


/* Total Cases vs Total Deaths by country over time */
SELECT location, date, total_cases, total_deaths 
FROM DeathsAndCasesByCountry


/* Likelihood of dying if you contract Covid in the United Kingdom over time */
/* Percentage of cases that result in death */
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM DeathsAndCasesByCountry
WHERE location = 'United Kingdom'
ORDER BY 1,2


/* likelihood of contracting covid */
/* Percentage of Population Infected by Covid in the United Kingdom over time */
SELECT dea.location, dea.date, dea.total_cases, loc.population, (dea.total_cases/loc.population)*100 as PercentPopulationInfected
FROM DeathsAndCasesByCountry dea
JOIN ProjectWork..LocationMetrics loc 
	ON dea.location = loc.location
WHERE dea.location = 'United Kingdom'
ORDER BY date


/* countries with the highest infection rates based on population size*/
SELECT dea.location, loc.population, MAX(dea.total_cases) AS HighestInfectionCount, (MAX(dea.total_cases)/loc.population)*100 as PercentPopulationInfected
FROM DeathsAndCasesByCountry dea
JOIN ProjectWork..LocationMetrics loc 
	ON dea.location = loc.location
GROUP BY dea.location, loc.population
ORDER BY PercentPopulationInfected desc


/* countries with the highest death count */
SELECT location, MAX(total_deaths) AS TotalDeathCount
FROM DeathsAndCasesByCountry dea
GROUP BY location
ORDER BY TotalDeathCount desc


/* countries with the highest death count based on population size */
SELECT dea.location, MAX(total_deaths) AS TotalDeathCount, (MAX(dea.total_deaths)/loc.population)*100 as PercentPopulationDeceased
FROM DeathsAndCasesByCountry dea
JOIN ProjectWork..LocationMetrics loc 
	ON dea.location = loc.location
GROUP BY dea.location, loc.population
ORDER BY PercentPopulationDeceased desc


/* Countries that applied the highest of stringency indexes */
SELECT TOP(15) location, max(stringency_index) as highest_string_index
FROM ProjectWork..CovidDeathsAndCases
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY highest_string_index DESC




/* join all datasets */
SELECT * FROM CovidDeathsAndCases
JOIN CovidVaccinationsAndTests ON CovidDeathsAndCases.iso_code = CovidVaccinationsAndTests.iso_code
JOIN LocationMetrics ON CovidDeathsAndCases.iso_code = LocationMetrics.iso_code






-- DROP VIEW DeathsAndCasesByCountry

