 select *
from PortfolioProject..CovidDeaths
order by 3,4


select *
from PortfolioProject..CovidVaccinations
order by 3,4


select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2


--TOTAL CASES VS TOTAL DEATHS

select location, date, total_cases, total_deaths, (total_deaths/population)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where location like '%states%'
order by 1,2


---TOTAL CASES VS POPULATION

 select location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
---where location like '%states%'
order by 1,2


----COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION
select location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeaths
---where location like '%states%'
group by location, population
order by PercentPopulationInfected desc


---COUNTRIES WT THE HIGHEST DEATH COUNT PER POPULATION
select location, MAX(total_deaths) AS TotalDeathCount
from PortfolioProject..CovidDeaths
---where location like '%states%'
group by location
order by TotalDeathCount desc



-- CONTINENT wt the highest death count per population

select continent, MAX(cast(total_deaths as int)) AS TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc


----GLOBAL NUMBERS
 select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
---where location like '%states%'
where continent is not null
--group by date
order by 1,2


---LOOKING AT TOTAL POPULATION VS VACCINATION
 select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3