CREATE DATABASE HW5
USE HW5

-- Data: CDC Mortality in the US
SELECT * FROM DBO.CDC_MORTALITY
SELECT COUNT(*) as Total_Obsrv FROM DBO.cdc_mortality



-- checking the column types of the table

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'CDC_MORTALITY'

-- duplicate values
select count(*)
from dbo.CDC_MORTALITY
GROUP BY 
HAVING COUNT(*)>1
-- 

-- NULL VALUES
SELECT COUNT(AGE_ADJUSTED_RATE) FROM DBO.CDC_MORTALITY
WHERE AGE_ADJUSTED_RATE IS not NULL


-- MISSING VALUES FOUND ON PYTHON

--General statistics

-- Checking distinct number of values in each categorical column
select count(distinct year) as Year,
count(distinct age) as Age,
count(distinct race_and_hispanic_origin) as Race,
count(distinct state) as State,
count(distinct sex) as Sex 
  from dbo.cdc_mortality

--State wise  average polpulation along the years
SELECT STATE, YEAR, AVG(POPULATION) AS AVG_POP
FROM DBO.CDC_MORTALITY
GROUP BY STATE, YEAR
ORDER BY STATE;

-- Number of distinct values in the columnS, TELLS YOU MORE ABOUT THE DATA

SELECT DISTINCT AGE FROM DBO.CDC_MORTALITY
ORDER BY AGE

SELECT DISTINCT STATE FROM DBO.CDC_MORTALITY
ORDER BY STATE
-- Contains United States and District of Columbia, so 52

-- SEX WISE NUMBER OF DATA
SELECT sex, COUNT(*) AS 'count' FROM DBO.CDC_MORTALITY
GROUP BY SEX

SELECT * FROM DBO.CDC_MORTALITY

-- TOTAL POPULATION OF THE US YEAR WISE
SELECT YEAR, SUM(POPULATION) AS TOTAL_POP_US FROM DBO.CDC_MORTALITY
WHERE STATE != 'UNITED STATES'
GROUP BY YEAR
ORDER BY YEAR
-- HAD TO REMOVE UNITED STATES FOR CORRECT FIGURES

-- MAXIMUM NUMBER OF DEATHS
SELECT TOP 1 DEATHS AS HIGHEST_DEATH_COUNT, STATE, YEAR
FROM DBO.CDC_MORTALITY
WHERE STATE != 'UNITED STATES'
ORDER BY DEATHS DESC

--MINIMUM NUMBER OF DEATHS
SELECT TOP 1 DEATHS AS LOWEST_DEATH_COUNT, STATE, YEAR
FROM DBO.CDC_MORTALITY
WHERE STATE != 'UNITED STATES'
ORDER BY DEATHS 

-- AVERAGE DEATHS YEAR ON YEAR IN THE US
SELECT YEAR, ROUND(AVG(DEATHS),0) AS AVG_DEATHS
FROM DBO.CDC_MORTALITY
WHERE STATE != 'UNITED STATES'
GROUP BY YEAR
ORDER BY YEAR

PRINT @@SERVERNAME
-- data contains male and female values only in case of state = united states, so some comparisons are be difficult

select state, 
	Round(avg(Deaths),2) as Avg_Deaths, 
	round(avg(population),2) as Avg_Population, 
	round(avg(crude_death_rate),2) as Avg_DeathRate 
from dbo.cdc_mortality
where state = 'ohio'
group by state

select Round(avg(Deaths),2) as Avg_Deaths, 
	round(avg(population),2) as Avg_Population, 
	round(avg(crude_death_rate),2) as Avg_DeathRate 
from dbo.cdc_mortality
where state !=  'united States'

