☕ Cafe Sales Data Cleaning & Analysis (SQL Project)

📌 Project Overview

This project demonstrates real-world data cleaning and exploratory data analysis using SQL.
The dataset contains messy transactional data from a fictional café and was cleaned, standardized, and analyzed to extract meaningful business insights.

The project simulates a typical data analyst workflow:

Data cleaning and validation
Data transformation
Data quality checks
Business analysis with SQL queries
Creation of analytical views

Dataset source: Kaggle
Dataset: Cafe Sales – Dirty Data for Cleaning Training

🧹 Data Cleaning Process

The dataset originally contained several common real-world data issues:

inconsistent column names
invalid date values
incorrect numeric formats
placeholder values such as UNKNOWN and ERROR
Cleaning steps performed:

✔ Created a working table for safe transformations
✔ Standardized column names
✔ Converted incorrect data types
✔ Fixed calculated fields (total_spent)
✔ Removed invalid values
✔ Replaced placeholder values with NULL
✔ Validated numeric values
✔ Checked for duplicates
✔ Performed final data validation checks

Example Cleaning Logic
UPDATE cafe_sales
SET item = NULL
WHERE item IN ('UNKNOWN', '', 'ERROR');

Date validation:

UPDATE cafe_sales
SET transaction_date = NULL
WHERE transaction_date NOT REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';

📊 Data Analysis

After cleaning the dataset, several business questions were explored using SQL.

Example questions answered:
What is the total revenue of the café?
Which items generate the most revenue?
What are the top-selling products?
Which location performs best?
What is the average transaction value?
How does daily revenue change over time?

📈 Example Analytical Queries
Total revenue
SELECT SUM(total_spent) AS total_revenue
FROM cafe_sales;
Top 3 best-selling items
SELECT
	item,
	SUM(quantity) AS total_sold_quantity
FROM cafe_sales
GROUP BY item
ORDER BY total_sold_quantity DESC
LIMIT 3;
Daily revenue
SELECT 
	transaction_date,
	SUM(total_spent) AS daily_revenue
FROM cafe_sales
GROUP BY transaction_date
ORDER BY transaction_date;

⚡ Advanced SQL Techniques Used

This project also demonstrates more advanced SQL concepts:

Window functions
Subqueries
Aggregations
Ranking functions
Analytical views
Example: Running daily revenue
SELECT
	transaction_date,
	total_spent,
	SUM(total_spent) OVER(
		PARTITION BY transaction_date
		ORDER BY transaction_date
	) AS running_daily_revenue
FROM cafe_sales;

📂 Project Structure

cafe-sales-sql-project
│
├── data_cleaning.sql
├── data_analysis.sql
└── README.md

🛠 Technologies Used
SQL
MySQL
Kaggle Dataset

🎯 Skills Demonstrated

This project highlights several key data analytics skills:

Data cleaning in SQL
Data validation techniques
Data quality auditing
Business-oriented SQL analysis
Window functions and ranking
Analytical view creation

📌 Key Insights

Example findings from the dataset:

Certain items generate significantly more revenue than others
Payment methods show different revenue distributions
Sales patterns vary by location
Daily revenue trends can be monitored with SQL views

🚀 Future Improvements

Possible extensions of the project:

Build a Power BI / Tableau dashboard
Add monthly and weekly revenue analysis
Create customer segmentation
Implement stored procedures for automated cleaning

👩‍💻 Author

Klára Ilyés

Aspiring Data Analyst / Data Engineer focused on SQL, data cleaning, and data analysis.
