-- I need to join sales', 'products', 'stores', 'inventory tables, first i check where 

SELECT COLUMN_NAME, TABLE_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME IN ('Toysales', 'Toyproducts', 'Toystores', 'Toyinventory') 
GROUP BY COLUMN_NAME, TABLE_NAME, DATA_TYPE;


-- create new table
CREATE TABLE ToySalesData (
    Date datetime,
	Sale_ID varchar(50),
    Product_Category nvarchar(255),
    Product_Cost float,
    Product_Name nvarchar(255),
    Product_Price float,
    Product_ID varchar(50),
    Store_City nvarchar(255),
    Store_Location nvarchar(255),
    Store_Name nvarchar(255),
    Store_Open_Date datetime,
    Units float
);

-- insert joined data into new table
INSERT INTO ToySalesData (
    Date, Product_Category, Product_Cost, Product_Name, Product_Price,
    Product_ID, Store_City, Store_Location, Store_Name,
    Store_Open_Date, Sale_ID, Units
)
SELECT ts.Date, tp.Product_Category, tp.Product_Cost, tp.Product_Name, tp.Product_Price,
       ts.Product_ID, tss.Store_City, tss.Store_Location, tss.Store_Name, 
       tss.Store_Open_Date, ts.Sale_ID, ts.Units
FROM ToySales ts
JOIN ToyProducts tp ON ts.Product_ID = tp.Product_ID
JOIN ToyStores tss ON ts.Store_ID = tss.Store_ID;


SELECT
*
FROM
ToySalesData

SELECT SUM(Product_Price * Units) AS TotalSales
FROM ToySalesData;

--Calculating totalSales and adding a column
ALTER TABLE ToySalesData
ADD TotalSales FLOAT;

UPDATE ToySalesData
SET TotalSales = Product_Price * Units;

--calculating Cost of goods sold
ALTER TABLE ToySalesData
ADD CostOfGoodsSold FLOAT;

UPDATE ToySalesData
SET CostOfGoodsSold = Product_Cost * Units;

--Calculating Profit
ALTER TABLE ToySalesData
ADD GrossProfit FLOAT;

UPDATE ToySalesData
SET GrossProfit = TotalSales - CostOfGoodsSold;

--Calculating gross profit margin
ALTER TABLE ToySalesData
ADD GrossProfit_Margin FLOAT;

UPDATE ToySalesData
SET GrossProfit_Margin = GrossProfit/TotalSales 

SELECT AVG(GrossProfit_Margin) AS AverageGrossProfitMargin
FROM ToySalesData;

SELECT SUM(TotalSales) AS TotalSalesSum
FROM ToySalesData;

SELECT SUM(GrossProfit) AS TotalGrossProfit
FROM ToySalesData;

SELECT SUM(Units) AS TotalQuantitySold
FROM ToySalesData;

SELECT COUNT(Sale_ID) AS TotalOrders
FROM ToySalesData;



