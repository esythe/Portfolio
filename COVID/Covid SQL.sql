-- 1. Total covid cases v Total covid deaths

SELECT 
	[location], 
	[date], 
	total_cases, 
	total_deaths, 
	(CAST(total_deaths AS REAL) / total_cases) * 100 AS death_percentage
FROM CovidDeaths
WHERE [location] LIKE '%kingdom%'
ORDER BY death_percentage DESC

-- 2. Total cases v population, displaying the percentage of the population with covid

SELECT 
	[location], 
	[date], 
	total_cases, 
	[population], 
	(CAST(total_cases AS REAL) / [population]) * 100 AS population_percentage
FROM CovidDeaths
WHERE [location] LIKE '%kingdom%'
ORDER BY population_percentage ASC

-- 3. Countries with the highest covid infection rate compared to its population

SELECT 
	[location],  
	MAX (total_cases) AS highest_infection_count, 
	[population], 
	MAX(CAST(total_cases AS REAL) / [population]) * 100 AS population_percentage
FROM CovidDeaths
GROUP BY [location], [population]
ORDER BY population_percentage DESC

-- 4. Countries with the highest death count per population

SELECT 
	[location],  
	MAX (total_deaths) AS highest_death_count, 
	[population]
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY [location], [population]
ORDER BY highest_death_count DESC

-- 5. Continents with the highest death count per population

SELECT 
	continent,  
	MAX (total_deaths) AS continent_death_count
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY continent_death_count DESC

-- 6. Global daily cases and daily deaths

SELECT 
	continent,
	[date],
	SUM (new_cases) AS total_daily_cases,
	SUM (new_deaths) AS total_daily_deaths
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY [date], continent
ORDER BY [date] ASC

-- 7. Death percentage of daily new cases

SELECT 
	continent,
	[date],
	SUM (new_cases) AS total_daily_cases,
	SUM (new_deaths) AS total_daily_deaths,
	CASE
		WHEN SUM (new_cases) = 0 THEN NULL
		ELSE SUM (CAST (new_deaths AS REAL)) / SUM (new_cases) * 100
	END AS daily_death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY [date], continent
ORDER BY [date] ASC

-- 8. Continental death percentage of total cases
SELECT 
	continent,
	SUM (new_cases) AS total_cases,
	SUM (new_deaths) AS total_deaths,
	CASE
		WHEN SUM (new_cases) = 0 THEN NULL
		ELSE SUM (CAST (new_deaths AS REAL)) / SUM (new_cases) * 100
	END AS continental_death_percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY continent ASC

-- 9. Analysing the total population vs total vaccinations
SELECT dea.continent, dea.[location], dea.[date], dea.population, vac.new_vaccinations
FROM CovidDeaths dea
JOIN Covidvaccines vac
	ON dea.location = vac.location
	---and dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.[location], dea.[date]
