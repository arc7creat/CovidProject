

/* Checking the data in Netflixstock
*/

Select * 
FROM PProject.dbo.NetflixStock

/*Correcting Date Format*/

Select CONVERT(varchar,date,23) AS date
FROM PProject.dbo.NetflixStock

ALTER TABLE PProject.dbo.NetflixStock
Add dateDataCollected Date;

Update PProject.dbo.NetflixStock
SET dateDataCollected = CONVERT(varchar,date,23)

Alter Table PProject.dbo.NetflixStock
Drop Column date


/* Opening stock price 2002-2022
*/

Select  dateDataCollected
		,open AS OpeningStockPrice
		FROM PProject.dbo.NetflixStock ;

/* Highest stock price 2002-2022
*/

Select  dateDataCollected
		,high AS HighestStockPrice
		FROM PProject.dbo.NetflixStock ;

/* Lowest stock price 2002-2022
*/

Select  dateDataCollected
		,low AS LowestStockPrice
		FROM PProject.dbo.NetflixStock ;

/* Number Of Share Traded 2002-2022
*/

Select  dateDataCollected
		,Volume AS SharesTraded
		FROM PProject.dbo.NetflixStock ;

/* Number Of Share Traded per year 2002-2022
*/

Select  YEAR(dateDataCollected) AS Year
		,SUM(Volume) AS SharesTradedPerYear
		FROM PProject.dbo.NetflixStock 
		GROUP BY YEAR(dateDataCollected)
		ORDER BY Year;

/* Total Shares traded till 2022
*/

Select  SUM(Volume)
		FROM PProject.dbo.NetflixStock ;

/* Highest stock Price till 2022
*/

Select  MAX(High)
		FROM PProject.dbo.NetflixStock ;

/* Lowest stock price till 2022
*/

Select  MIN(Low)
		FROM PProject.dbo.NetflixStock
		;

/* Highest Amount Of stock sold 2022
*/

Select  MAX(Volume)
		FROM PProject.dbo.NetflixStock
		;

/* Highest Openingstock 2022
*/

Select  MAX(Opening)
		FROM PProject.dbo.NetflixStock
		;


/* Lowest Closing stock 2022
*/

Select  MIN(Closing)
		FROM PProject.dbo.NetflixStock
		;

/* Number Of Share Traded per month 2002-2022
*/

Select   YEAR(dateDataCollected) AS Year, MONTH(dateDataCollected) AS Month
		,SUM(Volume) AS SharesTradedPerMonth
		FROM PProject.dbo.NetflixStock 
		GROUP BY MONTH(dateDataCollected), YEAR(dateDataCollected)
		ORDER BY Year, Month;