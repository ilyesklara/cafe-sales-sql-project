☕ SQL Data Cleaning & Analysis — Cafe Sales Dataset

📌 Project Overview

This project demonstrates a complete SQL workflow using a messy café sales dataset.
The goal was to clean and standardize transactional data before performing exploratory business analysis using SQL.

The dataset contained multiple data quality issues such as inconsistent values, invalid dates, and non-standard formats. After cleaning the dataset, various SQL queries were used to analyze sales performance and generate business insights.

This project focuses on building practical SQL skills relevant for real-world data analytics tasks.

📂 Dataset

Dataset source: Kaggle
Dataset name: Cafe Sales – Dirty Data for Cleaning Practice

The dataset contains transactional sales data including:

transaction ID
item sold
quantity
price per unit
total spent
payment method
order type (In-Store / Takeaway)
transaction date

🧹 Data Cleaning Process

A structured SQL cleaning pipeline was implemented to prepare the dataset for analysis.

1️⃣ Database Setup
Created a dedicated database
Imported the raw dataset
Created a working table for cleaning
2️⃣ Column Standardization
Renamed columns to consistent snake_case
Converted columns to appropriate data types
Standardized numeric fields
3️⃣ Date Cleaning

Invalid values such as:

ERROR
UNKNOWN
empty values

were detected and replaced with NULL before converting the column to the DATE data type.

4️⃣ Handling Invalid Values

Inconsistent categorical values were cleaned:

UNKNOWN
ERROR
empty strings

These were standardized to NULL values.

5️⃣ Data Validation

Several validation checks were performed:

negative or zero numeric values
total spent mismatches (quantity * price_per_unit)
duplicate transactions
missing dates

📊 Data Analysis

After cleaning the dataset, multiple SQL queries were written to explore the sales data.

The analysis includes:

Basic Queries
retrieving transactions
filtering specific products
exploring unique items
Aggregations
total café revenue
average transaction value
revenue by payment method
quantity sold per item
Business Questions

Examples of questions explored:

Which item generates the highest revenue?
What are the top selling items by quantity?
How does revenue change over time?
What is the difference between In-Store and Takeaway sales performance?
Advanced SQL Techniques

The analysis also includes more advanced SQL concepts:

window functions
ranking functions
subqueries
analytical views

🧠 Example Insight

Using SQL aggregations and ranking functions, it is possible to identify:

the best-performing products
daily revenue trends
transaction value distribution
differences between In-Store and Takeaway orders
🛠 Technologies Used
SQL
MySQL
MySQL Workbench

📁 Repository Structure
sql-cafe-sales-data-cleaning-analysis
│
├── data_cleaning.sql
├── data_analysis.sql
└── README.md

🎯 Project Purpose

This project was built as part of a data analytics learning path to practice:

real-world data cleaning
SQL query design
exploratory data analysis
writing structured, production-style SQL scripts

🚀 Future Improvements

Possible future extensions:

building a Power BI or Tableau dashboard
adding time-based sales analysis
implementing customer behavior insights
