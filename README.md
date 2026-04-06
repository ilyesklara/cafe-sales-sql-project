# Cafe Sales SQL Project

## Project Overview

This project focuses on cleaning and analyzing transactional café sales data using SQL.

The goal was to simulate a real-world data workflow:

cleaning messy transactional data
validating data quality
performing business-oriented analysis using SQL

The dataset contains café transactions including items sold, quantity, payment method, location type (in-store or takeaway), and transaction dates.

## Dataset

Source: Kaggle
Dataset: Cafe Sales – Dirty Data for Cleaning Training

The dataset contains intentionally messy data including:

- invalid dates
- placeholder values (UNKNOWN, ERROR)
- inconsistent formatting
- incorrect numeric values
## Data Cleaning

Data cleaning was performed in SQL to ensure the dataset is reliable for analysis.

Key steps included:

- Renaming columns for consistency
- Handling invalid date values
- Replacing placeholder values (UNKNOWN, ERROR) with NULL
- Validating numeric columns
- Recalculating incorrect totals
- Checking for duplicates
- Performing final data validation

Example cleaning query:
```sql
UPDATE cafe_sales
SET transaction_date = NULL
WHERE transaction_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';
```
## SQL Analysis

The analysis phase explores business questions using SQL.

Examples include:

Revenue Analysis
```sql
SELECT SUM(total_spent) AS total_revenue
FROM cafe_sales;
```
Best Selling Items
```sql
SELECT
    item,
    SUM(quantity) AS total_sold
FROM cafe_sales
GROUP BY item
ORDER BY total_sold DESC;
```
Daily Revenue
```sql
SELECT
    transaction_date,
    SUM(total_spent) AS daily_revenue
FROM cafe_sales
GROUP BY transaction_date;
```
## Advanced SQL Techniques

The project also demonstrates more advanced SQL concepts:

- Window Functions
- Subqueries
- Aggregations
- Ranking
- Views

Example:

```sql
SELECT
    location,
    item,
    SUM(total_spent) AS revenue_item,
    RANK() OVER(PARTITION BY location ORDER BY SUM(total_spent) DESC) AS item_rank
FROM cafe_sales
GROUP BY location, item;
```
## Business Questions Explored

Some example analytical questions answered in this project:

- Which item generates the highest revenue?
- What are the top-selling products?
- How does revenue change by day?
- Which payment methods generate the most revenue?
- Which items perform best for in-store vs takeaway orders?
## Tools Used
- SQL
- MySQL
- MySQL Workbench
- GitHub
## Skills Demonstrated
- Data Cleaning
- Data Validation
- SQL Querying
- Data Aggregation
- Window Functions
- Business Data Analysis
## Contact
  LinkedIn: www.linkedin.com/in/klára-ilyés-398402317 Email: demeterklara88@gmail.com
