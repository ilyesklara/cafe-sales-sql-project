-- =========================================
-- Cafe Sales Data Cleaning Project
-- Author: Klára Ilyés
-- =========================================

-- -----------------------------------------
-- Dataset source: Kaggle
-- Dataset: Cafe Sales - Dirty Data for Cleaning Training
-- Goal: Clean and standardize transactional sales data
-- -----------------------------------------


-- -----------------------------------------
-- 1️. Database + Safety
-- -----------------------------------------

CREATE DATABASE cafe_db;
USE cafe_db;

SELECT * FROM dirty_cafe_sales LIMIT 10;
DESCRIBE dirty_cafe_sales;


-- -----------------------------------------
-- 2. Create Clean Working Table
-- -----------------------------------------

CREATE TABLE cafe_sales AS
SELECT * FROM dirty_cafe_sales;


-- -----------------------------------------
-- 3. Column Renaming (Standardization)
-- -----------------------------------------

ALTER TABLE cafe_sales
CHANGE `Transaction ID` transaction_id VARCHAR(50);

ALTER TABLE cafe_sales
CHANGE `Item` item VARCHAR(50);

ALTER TABLE cafe_sales
CHANGE `Quantity` quantity INT;

ALTER TABLE cafe_sales
CHANGE `Price Per Unit` price_per_unit DECIMAL(10,2);

ALTER TABLE cafe_sales 
CHANGE `Total Spent` total_spent DECIMAL(10,2); -- Error Code: 1366. Incorrect DECIMAL value: '0' for column '' at row -1	0.016 sec

-- -----------------------------------------
-- Recalculate 'Total Spent' before converting to DECIMAL
-- -----------------------------------------
UPDATE cafe_sales
SET `Total Spent` = quantity * price_per_unit;

ALTER TABLE cafe_sales 
CHANGE `Total Spent` total_spent DECIMAL(10,2);
-- -----------------------------------------

ALTER TABLE cafe_sales
CHANGE `Payment Method` payment_method VARCHAR(50);

ALTER TABLE cafe_sales
CHANGE `Location` location VARCHAR(50);

ALTER TABLE cafe_sales 
CHANGE `Transaction Date` transaction_date DATE; -- Error Code: 1292. Incorrect date value: 'ERROR' for column 'transaction_date' at row 12	0.016 sec

-- -----------------------------------------
-- Convert `Transaction Date` in VARCHAR and clean before converting to DATE
-- -----------------------------------------
ALTER TABLE cafe_sales 
CHANGE `Transaction Date` transaction_date VARCHAR(50);

SELECT * FROM cafe_sales
WHERE transaction_date IS NULL;

SELECT *
FROM cafe_sales
WHERE transaction_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

SELECT DISTINCT transaction_date
FROM cafe_sales
WHERE transaction_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

-- Replace invalid date values with NULL
UPDATE cafe_sales
SET transaction_date = NULL
WHERE transaction_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

-- Convert column to DATE type
ALTER TABLE cafe_sales
MODIFY transaction_date DATE;
-- -----------------------------------------


-- -----------------------------------------
-- 4️. Initial Data Audit Section
-- -----------------------------------------

-- Check distinct values
SELECT DISTINCT item FROM cafe_sales;
SELECT DISTINCT payment_method FROM cafe_sales;
SELECT DISTINCT location FROM cafe_sales;


-- -----------------------------------------
-- 5️. Handle UNKNOWN Values
-- -----------------------------------------

UPDATE cafe_sales
SET item = NULL
WHERE item IN ('UNKNOWN', '', 'ERROR');

UPDATE cafe_sales
SET payment_method = NULL
WHERE payment_method IN ('UNKNOWN', '', 'ERROR');

UPDATE cafe_sales
SET location = NULL
WHERE location IN ('UNKNOWN', '', 'ERROR');


-----------------------------------------
-- 6️. Numeric Validation
-----------------------------------------

-- Quantity:
SELECT *
FROM cafe_sales
WHERE quantity <= 0;

SELECT DISTINCT quantity
FROM cafe_sales; 
-- All values > 0, no need to make changes
-- -----------------------------------------

-- Price Per Unit:
SELECT *
FROM cafe_sales
WHERE price_per_unit <= 0;

SELECT DISTINCT price_per_unit
FROM cafe_sales;
-- All values > 0, no need to make changes
-- -----------------------------------------

-- Total Spent:
SELECT *
FROM cafe_sales
WHERE total_spent <= 0;

SELECT DISTINCT total_spent
FROM cafe_sales;
-- All values > 0, no need to make changes
-- -----------------------------------------


-- -----------------------------------------
-- 7. Check Total Mismatches
-- -----------------------------------------

SELECT *
FROM cafe_sales
WHERE total_spent != quantity * price_per_unit;
-- Total values are correct
-- -----------------------------------------


-- -----------------------------------------
-- 8. Duplicate Check
-- -----------------------------------------

SELECT transaction_id, COUNT(*)
FROM cafe_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;
-- There are no duplicates
-- -----------------------------------------


-- -----------------------------------------
-- 9. Date Validation
-- -----------------------------------------

SELECT *
FROM cafe_sales
WHERE transaction_date IS NULL;


-- -----------------------------------------
-- 10. Final Validation Section
-- -----------------------------------------

-- Final row count
SELECT COUNT(*) FROM cafe_sales;

-- Check NULL distribution
SELECT
SUM(transaction_id IS NULL) AS null_transaction,
SUM(item IS NULL) AS null_item,
SUM(quantity IS NULL) AS null_quantity,
SUM(price_per_unit IS NULL) AS null_price,
SUM(total_spent IS NULL) AS null_total,
SUM(payment_method IS NULL) AS null_pay_method,
SUM(location IS NULL) AS null_location,
SUM(transaction_date IS NULL) AS null_date
FROM cafe_sales;

