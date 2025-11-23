-- 1. List all customers and their membership type.

SELECT 
	C.CustomerID,
	CONCAT (C.FirstName, ' ', C.LastName) AS FullName,
	M.MembershipName
FROM Customers C
JOIN Memberships M ON M.MembershipID = C.MembershipID
ORDER BY M.MembershipName

-- 2. Show all payments made in February 2024.

SELECT *
FROM Payments
WHERE PaymentDate BETWEEN '2024-02-01' AND '2024-02-29'
ORDER BY PaymentDate

-- 3. Find the total number of customers who have a membership.

SELECT COUNT (C.CustomerID) AS MembershipCustomers
FROM Customers C
WHERE C.MembershipID IS NOT NULL

-- 4. List the sessions sorted from cheapest to most expensive.

SELECT 
	SessionName,
	BasePrice
FROM [Sessions]
ORDER BY BasePrice

-- 5. Count how many customers joined per month.

SELECT 
	COUNT (CustomerID) AS NumberOfCustomers,
	DATENAME (m, DateOfFirstVisit) AS [Month],
	DATENAME (YYYY, DateOfFirstVisit) AS [Year]
FROM Customers
GROUP BY 
	DATENAME (YYYY, DateOfFirstVisit),
	DATENAME (m, DateOfFirstVisit),
	MONTH (DateOfFirstVisit)
ORDER BY 
	MONTH (DateOfFirstVisit), [YEAR]
	
-- 6. Show total revenue generated per session.

SELECT 
	S.SessionName,
	SUM (P.AmountPaid) AS TotalRevenue
FROM Payments P
JOIN [Sessions] S ON S.SessionID = P.SessionID
GROUP BY S.SessionName
ORDER BY TotalRevenue

-- 7. Who are the top 5 highest-spending customers?
-- The first query uses a CTE with a TOP 5 and the ORDER BY CLAUSE to get the information

WITH TotalSpent AS (
	SELECT TOP 5
	P.CustomerID,
	SUM (P.AmountPaid) AS AmountSpent
	FROM Payments P
	GROUP BY P.CustomerID
	ORDER BY AmountSpent DESC
)
SELECT CONCAT (C.FirstName, ' ', C.LastName) AS FullName, TotalSpent.AmountSpent
FROM TotalSpent
JOIN Customers C ON C.CustomerID = TotalSpent.CustomerID
	
-- This second query, for the same question, uses a CTE with a RANK Function. An examination of the query plan show both queries cost the same.

WITH TotalSpent AS (
	SELECT TOP 5
	C.CustomerID,
	CONCAT (C.FirstName, ' ', C.LastName) AS FullName,
	SUM (P.AmountPaid) AS AmountSpent, 
	RANK () OVER (ORDER BY (SUM (P.AmountPaid)) DESC) AS SpendRank
	FROM Payments P
	JOIN Customers C ON C.CustomerID = P.CustomerID
	GROUP BY C.CustomerID, CONCAT (C.FirstName, ' ', C.LastName)
)
SELECT *
FROM TotalSpent
WHERE SpendRank <= 5
ORDER BY SpendRank

--  8. Calculate the average membership discount given across all member purchased sessions in two decimal places.

SELECT CAST (ROUND (AVG ((S.BasePrice - P.AmountPaid) / S.BasePrice * 100), 2) AS DECIMAL (5, 2)) AS AvgDiscount
FROM Payments P
JOIN [Sessions] S ON S.SessionID = P.SessionID
WHERE P.PaymentMethod = 'MembershipDiscount'

-- 9. Show the number of payments made using full price vs membership discount.

SELECT 
	COUNT (CASE WHEN PaymentMethod = 'FullPrice' THEN 1 END) AS FullPricePayments,
	COUNT (CASE WHEN PaymentMethod = 'MembershipDiscount' THEN 1 END) AS MembershipDiscountPayments
FROM PAYMENTS

-- 10. List all customers who have never made a payment.

SELECT * FROM Customers C
LEFT JOIN Payments P ON P.CustomerID = C.CustomerID
WHERE P.PaymentID IS NULL

-- 11. Show which membership type brings in the most paying customers.

SELECT TOP 1
	M.MembershipName,
	SUM (P.AmountPaid) AS TotalMembershipAmount
FROM Memberships M
JOIN Payments P ON P.PurchasedMembershipID = M.MembershipID
GROUP BY M.MembershipName
ORDER BY TotalMembershipAmount DESC

-- 12. Find the average payment amount per session.

SELECT 
	S.SessionName, 
	AVG(P.AmountPaid) AS AvgAmountPaid
FROM Payments P
JOIN [Sessions] S ON P.SessionID = S.SessionID
GROUP BY S.SessionName

-- 13. Show the total number of purchases per session.

SELECT 
	S.SessionName,
	COUNT (P.AmountPaid) AS NumPurchases
FROM [Sessions] S
JOIN Payments P ON P.SessionID =  S.SessionID
GROUP BY S.SessionName

-- 14. Identify customers who have purchased at least 3 sessions.

SELECT 
	CustomerID,
	COUNT (AmountPaid) AS NumOfPayments
FROM Payments
WHERE PurchasedMembershipID IS NULL
GROUP BY CustomerID
HAVING COUNT (AmountPaid) >= 3
	
-- Extras for tableu visualisation


-- This shows date joined for all customers 
SELECT 
	DateofFirstVisit,
	COUNT (CustomerID) AS TotalNumOfCustomers
FROM Customers 
GROUP BY DateofFirstVisit

-- Number of customers per membership.
SELECT 
	M.MembershipName,
	COUNT (M.MembershipName) AS NumOfMembershipCustomers
FROM Customers C
JOIN Memberships M ON M.MembershipID = C.MembershipID
GROUP BY MembershipName
ORDER BY M.MembershipName


-- Total number of customers.

SELECT COUNT (CustomerID) AS TotalCustomers
FROM Customers 

-- Total Revenue 

SELECT SUM (AmountPaid) AS TotalRevenue
FROM Payments 
