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
LIMIT 100;

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

# How many states do our customers come from?
SELECT 
	COUNT(DISTINCT State) AS total_states
from superstore;

SELECT 
	COUNT(DISTINCT Country) AS total_customer_segments
from superstore;