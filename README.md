# 🛒 Walmart Sales Data Analytics

> **End-to-End Retail Sales Analysis using SQL, Python (Pandas & NumPy), and Tableau**

![Python](https://img.shields.io/badge/Python-3.x-blue?logo=python)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange?logo=mysql)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-blue?logo=tableau)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?logo=pandas)
![NumPy](https://img.shields.io/badge/NumPy-Numerical%20Computing-013243?logo=numpy)

## 📑 Table of Contents

- [📖 Project Overview](#-project-overview)
- [📊 Dashboard Preview](#-dashboard-preview)
- [🛠️ Tech Stack](#️-tech-stack)
- [🔄 Project Workflow](#-project-workflow)
- [📂 Project Structure](#-project-structure)
- [🐍 Python Notebook](#-python-notebook)
- [🗄️ SQL Business Analysis](#️-sql-business-analysis)
- [📈 Dashboard Features](#-dashboard-features)
- [💡 Key Insights](#-key-insights)
- [⚙️ Installation](#️-installation)
- [🚀 Future Improvements](#-future-improvements)
- [👨‍💻 Author](#-author)

## 📌 Project Overview

This project is an end-to-end retail sales analytics solution built using **Python, MySQL, and Tableau**. It analyzes Walmart sales data to uncover business insights through data cleaning, SQL-based analysis, and an interactive dashboard.

The project focuses on identifying sales trends, customer behavior, payment preferences, product performance, and branch-wise sales to support data-driven business decisions.

## 📊 Dashboard Preview

The interactive Tableau dashboard provides a comprehensive overview of Walmart sales performance.

<p align="center">
  <img src="Dashboard/dashboard.png" alt="Walmart Sales Dashboard" width="100%">
</p>

> 📌 **Tableau Public dashboard link will be added after publishing.**


## ⭐ Project Highlights

- ✅ End-to-End Walmart Sales Analytics Project
- ✅ Data Cleaning & Feature Engineering using Python
- ✅ Business Analysis using MySQL
- ✅ Interactive Tableau Dashboard
- ✅ 15+ SQL Business Problems Solved
- ✅ Retail Sales Performance Analysis
- ✅ KPI Dashboard with Interactive Filters
- ✅ Recruiter Portfolio Ready Project

  
## 🛠 Tech Stack

| Category | Tools |
|----------|-------|
| Programming | Python |
| Data Analysis | Pandas, NumPy |
| Database | MySQL |
| Visualization | Tableau |
| Version Control | Git & GitHub |
| Notebook | Jupyter Notebook |

## 📁 Dataset

The project uses Walmart retail sales transaction data.

Files included:

- Walmart.csv (Raw Dataset)
- walmart_clean_data.csv (Cleaned Dataset)

## 🔄 Project Workflow

```text
Raw Walmart Dataset (.csv)
            │
            ▼
 Data Cleaning & Preprocessing
        (Python + Pandas)
            │
            ▼
 Clean Dataset (.csv)
            │
            ├──────────────► MySQL
            │                     │
            │                     ▼
            │            Business SQL Queries
            │                     │
            ▼                     ▼
        Tableau Dashboard ◄──── Business Insights
            │
            ▼
 Interactive Data Visualization
```

## 📂 Project Structure

```text
walmart_sales_data_analytics/
│
├── Dashboard/
│   ├── dashboard.png
│   ├── README.md
│   └── walmart_sales_dashboard.twbx   (After Tableau Public export)
│
├── Dataset/
│   ├── Walmart.csv
│   ├── walmart_clean_data.csv
│   └── README.md
│
├── Docs/
│   ├── Walmart Business Problems.pdf
│   └── README.md
│
├── Notebook/
│   ├── project.ipynb
│   └── README.md
│
├── SQL/
│   ├── walmart_sales_queries.sql
│   └── README.md
│
├── README.md
├── requirements.txt
├── LICENSE
└── .gitignore

## 📒 Python Notebook

The notebook includes:

- Data Cleaning
- Feature Engineering
- Exploratory Data Analysis
- Dataset Preparation for SQL

```
### SQL Analysis: Complex Queries and Business Problem Solving
   - **Business Problem-Solving**: Write and execute complex SQL queries to answer critical business questions, such as:

    - Q.1 Find different payment method and number of transactions, numberof qty sold?
```sql
SELECT DISTINCT payment_method as payment_method,
   COUNT(*) as no_transactions,
   SUM(quantity) as no_qty_sold
FROM walmart 
GROUP BY payment_method
ORDER BY payment_method;
```
    - Q.2 Identify the highest-rated category in each branch, displaying the branch,category,AVG_rating
```sql     
SELECT *
FROM 
(  SELECT 
    branch,
    category,
    AVG(rating) as Average_rating,
    RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC ) as ranks
FROM walmart
GROUP BY branch,category
) as t1
WHERE ranks = 1;
```
	 - Q.3 Revenue trends across branches and categories.
```sql
SELECT 
     category,
     city,
     MIN(rating) As min_rating,
     AVG(rating) As avg_rating,
     MAX(rating) As max_rating
	 FROM walmart
GROUP BY category,city;
```

     - Q.4 Identifying best-selling product categories.
```sql
SELECT
     category,
     SUM(unit_price*quantity*profit_margin) As total_profit
     FROM walmart
GROUP BY category
ORDER BY total_profit DESC;
```
     - Q.5 Sales performance by time, city, and payment method.
```sql
SELECT 
    city,
    payment_method,
    CASE 
       WHEN HOUR(time) < 12 THEN 'Morning'
       WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
       ELSE 'Evening'
    END As day_time,
    COUNT(*) As total_transactions,
    SUM(total) As total_sales
FROM walmart
GROUP BY city, payment_method, day_time
ORDER BY city, total_sales DESC;
```
   - Q.6 Analyzing peak sales periods and customer buying patterns.
	 **a) Peak sales days**
```sql
SELECT 
    DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) As day_name,
    COUNT(*) As total_transactions,
    SUM(total) As total_sales
FROM walmart
GROUP BY day_name
ORDER BY total_sales DESC;
```
     **b) Peak sales months**
```sql
SELECT 
    MONTHNAME(STR_TO_DATE(date, '%d/%m/%y')) As month_name,
    COUNT(*) As total_transactions,
    SUM(total) As total_sales
FROM walmart
GROUP BY month_name
ORDER BY total_sales DESC;
```
    **c) Peak sales hours**
```sql
SELECT 
    HOUR(time) As hour_of_day,
    COUNT(*) As total_transactions,
    SUM(total) As total_sales
FROM walmart
GROUP BY hour_of_day
ORDER BY total_sales DESC;
```
    **d) Average quantity purchased per transaction (by category)**
```sql
SELECT 
    category,
    AVG(quantity) As avg_qty_per_transaction,
    COUNT(*) As total_transactions
FROM walmart
GROUP BY category
ORDER BY avg_qty_per_transaction DESC;
```
    **e) Customer rating pattern (by category)**
```sql
SELECT 
    category,
    AVG(rating) As avg_rating,
    COUNT(*) As total_transactions
FROM walmart
GROUP BY category
ORDER BY avg_rating DESC;
```

     - Q.7 Profit margin analysis by branch and category.
```sql
SELECT
    branch,
    category,
    SUM(unit_price * quantity) As total_revenue,
    SUM(unit_price * quantity * profit_margin) As total_profit,
    ROUND(AVG(profit_margin) * 100, 2) As avg_profit_margin_pct
    FROM walmart
GROUP BY branch,category
ORDER BY branch , total_profit DESC;
```
    - Q.8 Identify 5 branches with highest decrease ratio in revenue comapare to last year (current year 2023 and last year 2022)
```sql
-- 2022 sales
WITH revenue_2022
As
   (    SELECT 
         branch,
         SUM(total) As revenue
         FROM walmart
        WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2022
        GROUP BY branch
        ORDER BY branch
	),
-- 2023 sales 
revenue_2023
As
   (    SELECT 
         branch,
         SUM(total) As revenue
         FROM walmart
        WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2023
        GROUP BY branch
        ORDER BY branch
	)

SELECT
     ls.branch,
     ls.revenue As ls_year_rev,
     cs.revenue As cs_year_rev,
     ROUND((ls.revenue - cs.revenue)/ls.revenue * 100, 2) As revenue_dec_ratio
FROM revenue_2022 As ls
JOIN revenue_2023 As cs
ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY revenue_dec_ratio DESC
LIMIT 5;
```

## 📈 Dashboard Features

The Tableau dashboard provides an interactive view of Walmart sales performance with the following features:

- 📊 KPI Cards
  - Total Sales
  - Total Orders
  - Average Customer Rating
  - Average Profit Margin

- 📈 Monthly Sales Trend

- 🛍 Sales by Product Category

- 🏪 Top 5 Branches by Sales

- 🌍 Top 5 Cities by Sales

- 💳 Payment Method Distribution

- 🎛 Interactive Filters
  - Month
  - Category
  - Payment Method

## 💡 Key Insights

- 💰 The dashboard recorded **₹1,209,726** in total sales from **9,969 customer orders**.
- ⭐ The overall customer satisfaction remained strong with an **average rating of 5.83**.
- 📈 Sales increased significantly during **November and December**, indicating a strong year-end sales trend.
- 🛍️ **Fashion Accessories** (₹489,481) and **Home & Lifestyle** (₹489,250) were the highest revenue-generating product categories.
- 💳 **Credit Card** was the most preferred payment method (40%), followed by **E-wallet** (38%) and **Cash** (22%).
- 🏪 **WALM009** was the highest-performing branch with **₹25,688** in sales.
- 🌍 **Weslaco** generated the highest city-wise sales, followed by **Waxahachie** and **Plano**.
- 📊 The dashboard provides interactive filters for **Category**, **Month**, and **Payment Method**, enabling detailed business analysis.

  ## 📈 Business Impact

This project demonstrates how data analytics can support business decision-making by:

- Monitoring overall sales performance across branches.
- Identifying top-performing products and categories.
- Understanding customer payment preferences.
- Tracking monthly sales trends.
- Comparing branch and city-wise performance.
- Supporting data-driven business decisions through interactive visualizations.

## ⚙️ Installation

### Clone the repository

```bash
git clone https://github.com/Sumit6342/walmart_sales_data_analytics.git
cd walmart_sales_data_analytics
```

### Install dependencies

```bash
pip install -r requirements.txt
```

### Run the project

1. Open `Notebook/project.ipynb` for data cleaning and preprocessing.
2. Import `Dataset/walmart_clean_data.csv` into MySQL.
3. Execute queries from `SQL/walmart_sales_queries.sql`.
4. Open the Tableau dashboard (`.twbx`) once available to explore interactive visualizations.
```
  
## 👨‍💻 Author

**Sumit Mallick**

- 💼 GitHub: https://github.com/Sumit6342
- 🔗 LinkedIn: *(linkedin.com/in/sumit-mallick-ab96ab253/)*
- 📧 Email: *(sumit1610mallick@gmail.com)*


## ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub.
