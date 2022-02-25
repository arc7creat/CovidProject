/* 
Number of variants detected
num_sequences - the number of sequences processed (for the country, variant and date);
perc_sequences - percentage of sequences from the total number of sequences (for the country, variant and date);
numsequencestotal - total number of sequences (for the country, variant and date);
*/

Select *
FROM PProject.dbo.covidvariants

Select Distinct(variant)
FROM PProject.dbo.covidvariants

/* 
Correcting date format
*/

Select CONVERT(varchar,date,23) AS date
FROM PProject.dbo.covidvariants

ALTER TABLE covidvariants
Add dateCaseRegistered Date;

Update covidvariants
SET dateCaseRegistered = CONVERT(varchar,date,23)

Alter Table covidvariants
Drop Column date


/*
Variants with number of cases worldwide
*/

Select DISTINCT(variant), SUM(num_sequences) AS TotalCases
FROM PProject.dbo.covidvariants
Group By variant
Order By  variant


/*
Variants affected countries
*/

Select DISTINCT(location), SUM(num_sequences) AS TotalCases
FROM PProject.dbo.covidvariants
GROUP By location
ORDER By location


Select DISTINCT(location), variant, SUM(num_sequences) AS VariantCase
FROM PProject.dbo.covidvariants
Group By variant, location
ORDER BY location, variant









