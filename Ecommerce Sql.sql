SELECT * FROM Synthetic_Ecommerce_Sales_analyzed

--> o	Which products generate the most revenue?
SELECT 
    Product,
    SUM(Revenue) AS TotalRevenue,
    CAST(
        100.0 * SUM(Revenue) / SUM(SUM(Revenue)) OVER ()
        AS DECIMAL(5,2)
    ) AS Product_Earnings
FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY Product
ORDER BY SUM(Revenue) DESC;

--> o	Which categories generate the most revenue?
SELECT 
    Category,
    SUM(Revenue) AS TotalRevenue,
    CAST(
        100.0 * SUM(Revenue) / SUM(SUM(Revenue)) OVER ()
        AS DECIMAL(5,2)
    ) AS Category_Earnings
FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY Category
ORDER BY SUM(Revenue) DESC;
2.	Trend Analysis
o	How does revenue vary by month?
SELECT Month(OrderDate), SUM(Revenue),  
CAST(
        100.0 * SUM(Revenue) / SUM(SUM(Revenue)) OVER ()
        AS DECIMAL(5,2)
    ) AS Monthly_earnings FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY Month(OrderDate)
ORDER BY SUM(Revenue) DESC
3.	Customer Analysis
o	Who are the top customers by revenue?
SELECT TOP 10 CustomerID,COUNT(CustomerID), SUM(Revenue), CAST(
        100.0 * SUM(Revenue) / SUM(SUM(Revenue)) OVER ()
        AS DECIMAL(5,2)
    ) AS Customer_earnings FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY CustomerID
ORDER BY SUM(Revenue) DESC 

-->o	Which customer segments (if we add them) are most valuable?
SELECT CustomerID, COUNT(CustomerID), SUM(Revenue) AS Customer_earnings FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY CustomerID
ORDER BY COUNT(CustomerID) DESC
--> so there are no customer segments the least customer retuned once at least
--> we have 1000 unique customers.

4.	Regional Analysis
o	Which regions perform best?
SELECT Region, SUM(Revenue) AS Region_earnings FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY Region
ORDER BY SUM(Revenue) DESC
o	Are there underperforming regions that need attention?
---> To term under performing they'd doing below avcerage or a certaian revenue amount.
--> none is doing that now so all is performing well.
 
ALTER TABLE Synthetic_Ecommerce_Sales_analyzed
ALTER COLUMN Revenue BIGINT;


 SELECT distinct P.Product, c.Category, SUM(P.Revenue + c.Revenue) AS Product_Category_Earnings FROM Synthetic_Ecommerce_Sales_analyzed P
 CROSS JOIN Synthetic_Ecommerce_Sales_analyzed c
 GROUP BY  P.Product, c.Category
 ORDER BY SUM(P.Revenue + c.Revenue)

 SELECT product, Sum(quantity), SUM(Revenue) AS Region_earnings FROM Synthetic_Ecommerce_Sales_analyzed
GROUP BY Product
ORDER BY SUM(Revenue) DESC
