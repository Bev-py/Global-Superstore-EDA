-- A database created for the Exploratory data analysis of the 'Global Superstore' Dataset

CREATE DATABASE Global_Superstore_Sales;	# Creates the database

USE global_superstore_sales; 	# Initite the database

# Create the table
CREATE TABLE superstore (
    Category VARCHAR(50),
    City VARCHAR(100),
    Country VARCHAR(100),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Discount DECIMAL(10, 2),
    Market VARCHAR(50),
    OrderDate DATE,
    OrderID VARCHAR(50),
    OrderPriority VARCHAR(20),
    ProductID VARCHAR(50),
    ProductName VARCHAR(255),
    Profit DECIMAL(10, 2),
    Quantity INT,
    Region VARCHAR(50),
    RowID INT,
    SalesAmount INT,
    Segment VARCHAR(50),
    ShipDate DATE,
    ShipMode VARCHAR(50),
    ShippingCost DECIMAL(10, 2),
    State VARCHAR(100),
    SubCategory VARCHAR(50),
    OrderYear INT,
    Market2 VARCHAR(50),
    weeknum INT
);

# Load the data into your table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstore.csv'
INTO TABLE superstore
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;	-- Ignores the first row from the table i.e. column titles

# Check to make sure the column data types are correct
DESCRIBE superstore;

#Exploring the data
SELECT *
FROM superstore
LIMIT 50;

# Check the entire dataset for NULL values
SELECT
    COUNT(CASE WHEN Category IS NULL THEN 1 END) AS Category_NULLs,
    COUNT(CASE WHEN City IS NULL THEN 1 END) AS City_NULLs,
    COUNT(CASE WHEN Country IS NULL THEN 1 END) AS Country_NULLs,
    COUNT(CASE WHEN Customer_ID IS NULL THEN 1 END) AS Customer_ID_NULLs,
    COUNT(CASE WHEN Customer_Name IS NULL THEN 1 END) AS Customer_Name_NULLs,
    COUNT(CASE WHEN Discount IS NULL THEN 1 END) AS Column3_NULLs,
    COUNT(CASE WHEN Market IS NULL THEN 1 END) AS Market_NULLs,
    COUNT(CASE WHEN OrderDate IS NULL THEN 1 END) AS OrderDate_NULLs,
    COUNT(CASE WHEN OrderID IS NULL THEN 1 END) AS OrderID_NULLs,
    COUNT(CASE WHEN OrderPriority IS NULL THEN 1 END) AS OrderPriority_NULLs,
    COUNT(CASE WHEN ProductID IS NULL THEN 1 END) AS ProductID_NULLs,
    COUNT(CASE WHEN ProductName IS NULL THEN 1 END) AS ProductName_NULLs,
    COUNT(CASE WHEN Profit IS NULL THEN 1 END) AS Profit_NULLs,
    COUNT(CASE WHEN Quantity IS NULL THEN 1 END) AS Quantity_NULLs,
    COUNT(CASE WHEN Region IS NULL THEN 1 END) AS Region_NULLs,
    COUNT(CASE WHEN RowID IS NULL THEN 1 END) AS RowID_NULLs,
    COUNT(CASE WHEN SalesAmount IS NULL THEN 1 END) AS SalesAmount_NULLs,
    COUNT(CASE WHEN Segment IS NULL THEN 1 END) AS Segment_NULLs,
    COUNT(CASE WHEN ShipDate IS NULL THEN 1 END) AS ShipDate_NULLs,
    COUNT(CASE WHEN ShipMode IS NULL THEN 1 END) AS ShipMode_NULLs,
    COUNT(CASE WHEN ShippingCost IS NULL THEN 1 END) AS ShippingCost_NULLs,
    COUNT(CASE WHEN State IS NULL THEN 1 END) AS State_NULLs,
    COUNT(CASE WHEN SubCategory IS NULL THEN 1 END) AS SubCategory_NULLs,
    COUNT(CASE WHEN OrderYear IS NULL THEN 1 END) AS OrderYear_NULLs,
    COUNT(CASE WHEN Market2 IS NULL THEN 1 END) AS Market2_NULLs,
    COUNT(CASE WHEN weeknum IS NULL THEN 1 END) AS weeknum_NULLs

FROM superstore; 	-- there are no Null values in this dataset

# Check for Duplicates
SELECT s.*
FROM superstore s
JOIN (
    SELECT RowID, COUNT(*) AS count
    FROM superstore
    GROUP BY RowID
    HAVING COUNT(*) > 1
) AS duplicates 
ON duplicates.RowID = s.RowID;		-- No duplicated rows


-- EDA
# DESCRIPTIVE STATISTICS
SELECT 
	SUM(Quantity) AS total_order_Quantity,
	SUM(SalesAmount) AS totalSalesAmount,
    SUM(Profit) AS total_Profit,
	AVG(Profit) AS avg_profit,
    MAX(Quantity) AS maximum_order_quantity,
    MIN(Quantity) AS minimum_order_quantity
FROM superstore;
    
# How many customers does the store have?
SELECT 
	COUNT(DISTINCT Customer_ID) AS total_customer
FROM superstore;

# How many customer segments does store have?
SELECT 
	COUNT(DISTINCT Segment) AS total_customer_segments
FROM superstore;

# How many region and countries do our customers come from?
SELECT 
	COUNT(DISTINCT Country) AS total_states,
    COUNT(DISTINCT Region) AS Regions
from superstore;

-- Find the Top 5 products by order quantity and profit
SELECT ProductName,
	SUM(Quantity) AS Total_quantity,
	SUM(Profit) AS Total_profit
FROM superstore
GROUP BY ProductName
ORDER BY SUM(Profit) DESC, SUM(Quantity)
LIMIT 5;

-- 			BUSINES QUESTIONS
# Total Sales and Profit per customer segment
SELECT Segment,
	SUM(SalesAmount) AS Total_sales,
	SUM(Profit) AS total_profit
FROM superstore
GROUP BY Segment
ORDER BY SUM(Profit) DESC;

-- What is the behaviour of different customer segments across differnt regions?
SELECT
    Segment,
    Region,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    SUM(Quantity) AS QuantityOrdered,
    COUNT(DISTINCT OrderID) AS TotalOrders
FROM superstore
GROUP BY Segment, Region
ORDER BY TotalSales DESC, TotalProfit DESC;  


# Total Sales and Profit per Market and Country
SELECT Market,
	Country,
    SUM(SalesAmount) AS Total_sales,
	SUM(Profit) AS total_profit
FROM superstore
GROUP BY Market, Country
ORDER BY Market;

-- Find the Top 5 Countries by Profit
SELECT Country,
	SUM(Profit) AS Total_profit
FROM superstore
GROUP BY Country
ORDER BY SUM(Profit) DESC
LIMIT 5;

/* What is the total sales and profit generated in each market, 
and which market is most profitable? */
SELECT 
	Market,
    SUM(SalesAmount) AS total_Sales,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Market
ORDER BY SUM(Profit) DESC;

/* What is the total sales and profit generated in each country, 
and which country is most profitable? */
SELECT 
	Country,
    SUM(SalesAmount) AS total_Sales,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Country
ORDER BY SUM(Profit) DESC;

-- Which product categories and sub-categories generate the most profit?	
SELECT 
	Category,
    SUM(Quantity) AS total_quantity_sold,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY SUM(Profit) DESC;

SELECT 
	SubCategory,
    SUM(Quantity) AS total_quantity_sold,
    SUM(Profit) AS total_profit
FROM superstore
GROUP BY SubCategory
ORDER BY SUM(Profit) DESC;

-- Who are the top 5 customers by sales and profit?
WITH CustomerSales AS (
    SELECT 
        Customer_ID,
        Customer_Name,
        SUM(SalesAmount) AS Total_Sales,
        SUM(Profit) AS Total_Profit,
        RANK() OVER (ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM superstore
    GROUP BY Customer_ID, Customer_Name
)
SELECT * 
FROM CustomerSales
WHERE SalesRank <= 5;

-- What are the best-selling products in each subcategory, and how does their profitability compare?
WITH ProductSales AS (
    SELECT 
        SubCategory,
        ProductID,
        ProductName,
        SUM(SalesAmount) AS Total_Sales,
        SUM(Profit) AS Total_Profit,
        RANK() OVER (PARTITION BY SubCategory ORDER BY SUM(SalesAmount) DESC) AS SalesRank
    FROM superstore
    GROUP BY SubCategory, ProductID, ProductName
)
SELECT 
    SubCategory,
    ProductID,
    ProductName,
    Total_Sales,
    Total_Profit
FROM ProductSales
WHERE SalesRank = 1
ORDER BY SubCategory, Total_Sales DESC;

-- Explore the relationship between discount vs sales and profit
SELECT
    ProductID,
    ProductName,
    SUM(Discount) AS TotalDiscount,
    SUM(Quantity) AS TotalQuantityOrdered,
    SUM(SalesAmount) AS TotalSalesAmount,
    SUM(Profit) AS TotalProfit,
    CASE
        WHEN SUM(Discount) > 0.5 THEN 'High Discount'
        WHEN SUM(Discount) BETWEEN 0.2 AND 0.5 THEN 'Medium Discount'
        ELSE 'Low Discount'
    END AS DiscountCategory
FROM superstore
GROUP BY ProductID, ProductName
ORDER BY TotalDiscount DESC
LIMIT 10;  -- Limiting to top 10 products with highest discounts

/* How long does it take, on average, to ship orders in each region? 
Are there regions with high shipping delays? */
SELECT 
    Region,
    AVG(DATEDIFF(ShipDate, OrderDate)) AS AvgShippingTime
FROM superstore
GROUP BY Region
ORDER BY AvgShippingTime DESC;

-- What is the most common shipping mode across all countries?
SELECT 
    Country,
    ShipMode, 
    COUNT(*) AS Count
FROM superstore
GROUP BY Country, ShipMode
ORDER BY Count DESC;

-- What is the monthly, quarterly and yearly sales performance?
SELECT
    YEAR(OrderDate) AS order_Year,
    QUARTER(OrderDate) AS order_Quarter,
    MONTH(OrderDate) AS order_Month,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit
FROM superstore
GROUP BY order_Year, order_Quarter, order_Month
ORDER BY order_Year, order_Quarter DESC, order_Month DESC;

-- Calculate the moving average for sales and profit for each year, month, quarter
# Yearly Averages
SELECT
    YEAR(OrderDate) AS Order_Year,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    AVG(SUM(SalesAmount)) OVER (ORDER BY YEAR(OrderDate) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS YearlyMovingAvgSales,
    AVG(SUM(Profit)) OVER (ORDER BY YEAR(OrderDate) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS YearlyMovingAvgProfit
FROM superstore
GROUP BY YEAR(OrderDate)
ORDER BY Order_Year DESC;

# Quarterly Averages
SELECT
    YEAR(OrderDate) AS Order_Year,
    QUARTER(OrderDate) AS Order_quarter,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    AVG(SUM(SalesAmount)) OVER (ORDER BY YEAR(OrderDate), QUARTER(OrderDate) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS QuarterlyMovingAvgSales,
    AVG(SUM(Profit)) OVER (ORDER BY YEAR(OrderDate), QUARTER(OrderDate) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS QuarterlyMovingAvgProfit
FROM superstore
GROUP BY YEAR(OrderDate), QUARTER(OrderDate)
ORDER BY Order_Year DESC, Order_quarter DESC;

# Monthly Averages
SELECT
    YEAR(OrderDate) AS Order_Year,
    MONTH(OrderDate) AS Order_Month,
    SUM(SalesAmount) AS TotalSales,
    SUM(Profit) AS TotalProfit,
    AVG(SUM(SalesAmount)) OVER (ORDER BY YEAR(OrderDate), MONTH(OrderDate) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MonthlyMovingAvgSales,
    AVG(SUM(Profit)) OVER (ORDER BY YEAR(OrderDate), MONTH(OrderDate) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MonthlyMovingAvgProfit
FROM superstore
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY Order_Year DESC, Order_Month DESC;

-- Who are the repeat customers, and what is their purchase frequency?
SELECT
    Customer_ID,
    Customer_Name,
    TotalOrders,
    FirstOrderDate,
    LastOrderDate,
    DATEDIFF(LastOrderDate, FirstOrderDate)  AS DaysBetweenFirstAndLastOrder
FROM
    (SELECT
        Customer_ID,
        Customer_Name,
        COUNT(DISTINCT OrderID) AS TotalOrders,
        MIN(OrderDate) AS FirstOrderDate,
        MAX(OrderDate) AS LastOrderDate
     FROM superstore
     GROUP BY Customer_ID, Customer_Name
    ) AS customer_orders
WHERE TotalOrders > 1
ORDER BY TotalOrders DESC;

-- What is the average order value for the top customers?
SELECT
    Customer_ID,
    Customer_Name,
    TotalSales / OrderCount AS AverageOrderValue,
    RANK() OVER (ORDER BY TotalSales / OrderCount DESC) AS AOVRanking
FROM
    (SELECT
        Customer_ID,
        Customer_Name,
        SUM(SalesAmount) AS TotalSales,
        COUNT(DISTINCT OrderID) AS OrderCount
     FROM superstore
     GROUP BY Customer_ID
    ) AS customer_sales
ORDER BY AOVRanking;
