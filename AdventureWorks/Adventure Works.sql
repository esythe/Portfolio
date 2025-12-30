--Adventure Works Dataset.

-- 1. What are total sales by year and month? 

SELECT 
	D.CalendarYear AS [Year],
	D.EnglishMonthName AS [Month],
	COUNT (FIS.SalesOrderNumber) AS NumOfSales,
	FORMAT (SUM (FIS.SalesAmount), 'c') AS TotalSales
FROM 
	FactInternetSales FIS
JOIN 
	DimDate D ON FIS.OrderDateKey = D.DateKey
GROUP BY 
	D.EnglishMonthName, D.CalendarYear, D.MonthNumberOfYear
ORDER BY 
	D.CalendarYear, D.MonthNumberOfYear;

-- 2. Which products generate the highest revenue?

SELECT TOP 5 
	Prod.EnglishProductName AS ProductName,
	FORMAT (SUM (Fis.SalesAmount), 'c') AS TotalSale
FROM 
	FactInternetSales Fis
JOIN 
	DimProduct Prod ON Fis.ProductKey = Prod.ProductKey
GROUP BY 
	Prod.EnglishProductName
ORDER BY 
	SUM(Fis.SalesAmount) DESC;

-- Customer Insights

-- 3. Who are the top customers by lifetime spend? 

SELECT TOP 10
	CONCAT (Cust.FirstName, ' ', Cust.LastName) AS FullName, 
	FORMAT (ROUND (LTS.TotalSale, 2), 'c') AS TotalSale
FROM (
	SELECT
		Fis.CustomerKey,
		SUM (Fis.SalesAmount) AS TotalSale
	FROM 
		FactInternetSales Fis
	GROUP BY 
		Fis.CustomerKey
) LTS
JOIN 
	DimCustomer Cust ON LTS.CustomerKey = Cust.CustomerKey
ORDER BY 
	TotalSale DESC;


-- 4. What is the average order value per customer segment?
-- a. The below shows the total number of orders and avg sales revenue from customers.
SELECT 
	COUNT (CustomerKey) AS CNumOfOrders,
	FORMAT (AVG (SalesAmount), 'c') AS CAvgSalesAmount
FROM 
	FactInternetSales
WHERE 
	CustomerKey IS NOT NULL

UNION ALL
-- b. The below shows the total number of orders avg sales revenue from resellers.
SELECT 
	COUNT (ResellerKey) AS RNumOfOrders,
	FORMAT (AVG (SalesAmount), 'c') AS RAvgSalesAmount
FROM 
	FactResellerSales
WHERE 
	ResellerKey IS NOT NULL;

-- 5. Which regions generate the most sales?

SELECT 
	SalesT.SalesTerritoryCountry,
	FORMAT (MAX (TotalRegionalSales), 'c') AS HighestRegionalSales
FROM
	(SELECT 
		SUM (Fis.SalesAmount) AS TotalRegionalSales, 
		Fis.SalesTerritoryKey
	FROM 
		FactInternetSales Fis
	GROUP BY 
		Fis.SalesTerritoryKey) TRS
JOIN 
	DimSalesTerritory SalesT	
ON 
	SalesT.SalesTerritoryKey = TRS.SalesTerritoryKey
GROUP BY 
	SalesTerritoryCountry;

-- 6. Which products have the lowest inventory levels?

WITH LatestDate AS (
    SELECT MAX(DateKey) as MaxDateKey, ProductKey
    FROM FactProductInventory
	GROUP BY ProductKey
)
SELECT
    p.ProductKey,
    p.EnglishProductName,
    SUM(f.UnitsBalance) AS TotalUnitsBalance,
    p.SafetyStockLevel
FROM FactProductInventory f
JOIN LatestDate ld
    ON f.DateKey = ld.MaxDateKey AND f.ProductKey = ld.ProductKey
JOIN DimProduct p
	ON p.ProductKey = F.ProductKey
GROUP BY
    p.ProductKey,
    p.EnglishProductName,
    p.SafetyStockLevel
HAVING SUM(f.UnitsBalance) < p.SafetyStockLevel
ORDER BY TotalUnitsBalance ASC;

-- 7. What is the average delivery time per product category?

SELECT 
	PCat.ProductCategoryKey,
	PCat.EnglishProductCategoryName,
	AVG (DATEDIFF (DAY, Fis.OrderDate, Fis.DueDate)) AS AvgDeliveryDate
FROM 
	DimProductCategory PCat
JOIN 
	DimProductSubcategory ProdSub ON ProdSub.ProductCategoryKey = PCat.ProductCategoryKey
JOIN 
	DimProduct Prod ON Prod.ProductSubcategoryKey = ProdSub.ProductSubcategoryKey
JOIN 
	FactInternetSales Fis ON Fis.ProductKey = Prod.ProductKey
GROUP BY 
	PCat.ProductCategoryKey,
	PCat.EnglishProductCategoryName
ORDER BY
	ProductCategoryKey;

-- 8. What is the monthly sales growth rate?

SELECT
	D.EnglishMonthName AS [Month],
	D.CalendarYear AS [Year],
	FORMAT (ROUND (SUM (Fis.SalesAmount), 2), 'c') AS MonthSalesAmount
FROM 
	FactInternetSales FIS
JOIN 
	DimDate D ON FIS.OrderDateKey = D.DateKey
GROUP BY 
	D.EnglishMonthName, D.CalendarYear, D.MonthNumberOfYear
ORDER BY 
	D.CalendarYear, D.MonthNumberOfYear;