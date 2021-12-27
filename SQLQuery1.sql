Select *
From CovidProject..coviddeaths
order by 3,4


Select Location,date, total_cases, new_cases, total_deaths
From CovidProject..coviddeaths
order by 1,2

-- Looking at total cases vs total deaths
Select Location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS deathpercentage
From CovidProject..coviddeaths
Where location like '%australia%'
order by 1,2


-- Showing contintents with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From CovidProject..coviddeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From CovidProject..coviddeaths
where continent is not null 
order by 1,2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine in australia
Select dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations,SUM(Cast(vac.new_vaccinations as int)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.location like '%australia%' 
order by 2,3



-- Using common table expression to perform Calculation on Partition By in previous query, greater than 100 percentage shows double vaccination
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.location like '%australia%' 
)
Select *, (RollingPeopleVaccinated/Population)*100 AS PercentageVaccinated
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, vac.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidProject..CovidDeaths dea
Join CovidProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.location like '%australia%'

Select *, (RollingPeopleVaccinated/Population)*100 AS PercentageVaccinated
From #PercentPopulationVaccinated




-- Creating View to store data for later visualizations

Create View WorldPercentPopulationVaccinated as
Select vac.continent, vac.location, vac.date, vac.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by vac.Location Order by vac.location, vac.Date) as RollingPeopleVaccinated
From CovidProject..CovidVaccination vac
where vac.continent is not null 

Select *
From WorldPercentPopulationVaccinated