# COVID-19 Data Analysis Project

This project analyses global COVID-19 data using SQL, focusing on:

1) Infection trends across countries and continents.

2) Mortality rates. 
   
3) Vaccination rollout.
   
4) Peak case spikes.
   
5) Country level and continent level comparisons.

The project uses two publicly available datasets:

CovidDeaths and CovidVaccines from https://ourworldindata.org/covid-deaths

### Data Preparation

I cleaned and modelled the source data to ensure valid results, by:

1) Removed aggregate & non-country rows.

Rows such as World, European Union, and High income distort population-based calculations.

```SQL WHERE continent IS NOT NULL``` 

2) Avoided duplication by joining on (iso_code + date).
   
ON dea.iso_code = vac.iso_code
AND dea.date = vac.date

3) Treated population as a snapshot.

Population repeats daily, so summing it creates inflated numbers.
Correct approach:

Per-country: MAX(population)

Per-continent: sum of per-country values



### Questions Answered

1) Which countries have the highest COVID infection rate relative to population?

2) What percentage of a country’s population died from COVID?

3) Which continents recorded the highest total deaths?

4) How did global daily cases and deaths evolve over time?

5) Which countries recorded the highest single-day spike in new cases?

These findings were visualised in Tableau.


### Skills Demonstrated
1) SELECT and INSERT STATEMENTS.
   
2) WHERE, ORDER BY, GROUP BY AND HAVING CLAUSES. 
   
3) CAST and CASE.
   
4) INNER JOIN & LEFT JOIN across multiple tables.
   
5) Aggregations using SUM, MAX, COUNT, AVG.
   
6) Common Table Expressions (CTEs) and subqueries.
   
7) Window functions (RANK, OVER).
   
8) Tableau.
