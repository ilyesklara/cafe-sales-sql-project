-- =========================================
-- Cafe Sales Analysis Project
-- Author: Klára Ilyés
-- =========================================

-- -----------------------------------------
-- 1. Basic Queries
-- -----------------------------------------

-- 1.1. The first 20 transactions
SELECT 
	transaction_id, 
	item, 
	quantity, 
	price_per_unit, 
	total_spent
FROM cafe_sales
LIMIT 20;

-- 1.2. Coffee transactions
SELECT * 
FROM cafe_sales
WHERE item = 'Coffee';

-- 1.3. All transactions where total_spent is greater than 20
SELECT *
FROM cafe_sales
WHERE total_spent > 20;

-- 1.4. All unique items sold in the café.
SELECT DISTINCT item
FROM cafe_sales;


-- -----------------------------------------
-- 2. Aggregations
-- -----------------------------------------

-- 2.1. Total revenue of the café.
SELECT SUM(total_spent) AS total_revenue
FROM cafe_sales;

-- 2.2. Total quantity sold per item sorted by highest quantity first
SELECT
	item,
    SUM(quantity) as total_quantity
FROM cafe_sales
GROUP BY item
ORDER BY SUM(quantity) DESC;

-- 2.3. Average transaction value
SELECT AVG(total_spent) AS avg_transaction_value
FROM cafe_sales;

-- 2.4. Total revenue per payment method
SELECT 
	payment_method,
    SUM(total_spent) AS total_revenue
FROM cafe_sales
GROUP BY payment_method;


-- -----------------------------------------
-- 3. Business Questions
-- -----------------------------------------

-- 3.1. Which item generated the highest total revenue?
SELECT
	item,
    SUM(total_spent) AS total_revenue_per_item
FROM cafe_sales
GROUP BY item
ORDER BY SUM(total_spent) DESC
LIMIT 1;

-- 3.2. Top 3 best-selling items by quantity
SELECT
	item,
    SUM(quantity) AS total_sold_quantity
FROM cafe_sales
GROUP BY item
ORDER BY total_sold_quantity DESC
LIMIT 3;

-- 3.3. Which location generated the highest revenue
SELECT
	location,
    SUM(total_spent) AS total_revenue
FROM cafe_sales
WHERE location IS NOT NULL
GROUP BY location
ORDER BY total_revenue DESC
LIMIT 1;

-- 3.4. Daily revenue
SELECT 
	transaction_date,
    SUM(total_spent) AS daily_revenue
FROM cafe_sales
WHERE transaction_date IS NOT NULL
GROUP BY transaction_date
ORDER BY transaction_date;


-- -----------------------------------------
-- 4. Advanced Analysis
-- -----------------------------------------

-- 4.1. Running daily revenue
SELECT
	transaction_id,
	transaction_date,
    total_spent,
	SUM(total_spent) OVER(PARTITION BY transaction_date ORDER BY transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_daily_revenue
FROM cafe_sales
WHERE transaction_date IS NOT NULL
ORDER BY transaction_date;

-- 4.2. Top-selling item per location
SELECT
	location,
    item,
    SUM(total_spent) AS revenue_item,
    RANK() OVER(PARTITION BY location ORDER BY SUM(total_spent) DESC) AS item_rank
FROM cafe_sales
WHERE location IS NOT NULL AND item IS NOT NULL
GROUP BY location, item
ORDER BY location, item_rank;

-- 4.3. Transactions where the transaction value is higher than the average transaction value

SELECT * FROM cafe_sales
WHERE total_spent > (
	SELECT AVG(total_spent)
	FROM cafe_sales
);


-- -----------------------------------------
-- 5. View for daily sales summary
-- -----------------------------------------
CREATE VIEW daily_sales_summary AS 
	SELECT 
		transaction_date,
		COUNT(*) AS total_transactions,
		SUM(total_spent) AS total_revenue,
		AVG(total_spent) AS avg_transaction_value
	FROM cafe_sales
    WHERE transaction_date IS NOT NULL
    GROUP BY transaction_date;

SELECT * FROM daily_sales_summary;
