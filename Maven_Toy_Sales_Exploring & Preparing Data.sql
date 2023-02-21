
--query inventory data table
SELECT *
FROM ToyInventory

--checking for table column data types

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ToyInventory'

-- I need to create a unique characters on Store_ID & Product_ID so i add characters "ST" to the Store column  and PR to the Product_Id 
--first query modifies the data type the next query  add the characters to Store_ID  & Product_ID
ALTER TABLE ToyInventory
ALTER COLUMN Store_ID VARCHAR(50)

ALTER TABLE ToyInventory
ALTER COLUMN Product_ID VARCHAR(50)

UPDATE ToyInventory
SET Store_ID = 'ST' + CAST(Store_ID AS VARCHAR(50)),
    Product_ID = 'PR' + CAST(Product_ID AS VARCHAR(50))

--check that above query has updated
SELECT *
FROM ToyInventory

--query Products data table
SELECT *
FROM ToyProducts;

--checking for table column data types

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ToyProducts';

--Noticed that Product_Cost and Product_Price columns are string, below query changes them to float, first had to remove the $ sign from each value in the column

UPDATE ToyProducts
SET Product_cost = CAST(REPLACE(Product_cost, '$', '') AS decimal(18, 2))


ALTER TABLE ToyProducts
ALTER COLUMN Product_Cost float

UPDATE ToyProducts
SET Product_Price = CAST(REPLACE(Product_Price, '$', '') AS decimal(18, 2))

ALTER TABLE ToyProducts
ALTER COLUMN Product_Price float


-- I need to create a unique characters in Product_ID so i add PR 
--first query modifies the data type the next query  add the characters 'PR' to the beginning of the values in the Product_ID column
ALTER TABLE ToyProducts
ALTER COLUMN Product_ID VARCHAR(50)

UPDATE ToyProducts
SET Product_ID = 'PR' + CAST(Product_ID AS VARCHAR(50))

--check that above query has updated
SELECT *
FROM ToyProducts


--query stores data table
SELECT *
FROM ToyStores;

--checking for table column data types

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ToyStores';

-- I need to create a unique characters in Store_ID so i add ST 
--first query modifies the data type the next query  add the characters 
ALTER TABLE ToyStores
ALTER COLUMN Store_ID VARCHAR(50)

UPDATE ToyStores
SET Store_ID = 'ST' + CAST(Store_ID AS VARCHAR(50))

--check that above query has updated
SELECT *
FROM ToyStores

--I want to remove  "Maven Toys" infront of the store names so we run the below query
UPDATE ToyStores
SET Store_Name = REPLACE(Store_Name, 'Maven Toys ', '')
WHERE Store_Name LIKE 'Maven Toys %'



--query sales data table

SELECT *
FROM Toysales;

--check for columns data types
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Toysales'


--Notice Sales table has both Store_ID, Product_ID so need to add ST and PR characters to Store_ID & Product_ID respectively to match stores table and Products table which will be useful when joining the tables
--checking for table column data types
-- to update Store_ID and Product_ID columns we run below query

ALTER TABLE Toysales
ALTER COLUMN Store_ID VARCHAR(50);

UPDATE Toysales
SET Store_ID = 'ST' + CAST(Store_ID AS VARCHAR(50));

ALTER TABLE Toysales
ALTER COLUMN Product_ID VARCHAR(50);

UPDATE Toysales
SET Product_ID = 'PR' + CAST(Product_ID AS VARCHAR(50));

-- I need to create a unique sales id so i add characters "SA" to the sale_id column, first query modifies the 
--data type of the Sale_id column from float to VARCHAR , the next query 
-- add the letters 'SA' to the beginning of the values in the Sale_id column
ALTER TABLE Toysales
ALTER COLUMN Sale_id VARCHAR(50);

UPDATE Toysales
SET Sale_id = 'SA' + CAST(Sale_id AS VARCHAR(50));


--check that above query has updated
SELECT *
FROM Toysales

