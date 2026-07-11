CREATE DATABASE walmart_db;
USE walmart_db;
SHOW TABLES;
SELECT * FROM walmart;


-- Business Problems
-- Q.1 Find different payment method and number of transactions, numberof qty sold?
SELECT DISTINCT payment_method as payment_method,
   COUNT(*) as no_transactions,
   SUM(quantity) as no_qty_sold
FROM walmart 
GROUP BY payment_method
ORDER BY payment_method;

-- Q.2 Identify the highest-rated category in each branch, displaying the branch,category,AVG_rating
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

-- Q.3 Identify the busiest day foo each branch besed on the number of transaction?
WITH DayCounts As (
SELECT
      branch,
      DAYNAME(STR_TO_DATE(date, '%d/%m/%y')) AS day_name,
      COUNT(*) As total_transactions
FROM walmart
GROUP BY branch,day_name
),
RankedDays As (
  SELECT 
       branch,
       day_name,
       total_transactions,
	 RANK() OVER(PARTITION BY branch ORDER BY total_transactions DESC ) As day_rank
     FROM DayCounts
)
SELECT 
     branch,
     day_name,
     total_transactions
     FROM RankedDays
     WHERE day_rank = 1;
     
-- Q.4 Calculate Total Quantity Sold by Payment Method?
SELECT
	payment_method,
    SUM(quantity) As total_qty_sold
    FROM walmart
GROUP BY payment_method
ORDER BY payment_method;

-- Q.5 What are the average, minimum, and maximum ratings for each category in each city?
SELECT 
     category,
     city,
     MIN(rating) As min_rating,
     AVG(rating) As avg_rating,
     MAX(rating) As max_rating
	 FROM walmart
GROUP BY category,city;

-- Q.6  What is the total profit for each category, ranked from highest to lowest?
SELECT
     category,
     SUM(unit_price*quantity*profit_margin) As total_profit
     FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

-- Q.7 What is the most frequently used payment method in each branch?
SELECT 
     branch,
     payment_method,
     COUNT(payment_method) As method_count
     FROM walmart
GROUP BY branch,payment_method
ORDER BY branch,method_count DESC;

-- Q.8 How many transactions occur in each shift (Morning, Afternoon, Evening) across branches?

SELECT 
    branch,
    CASE 
       WHEN HOUR(time)<12 THEN 'Morning'
       WHEN HOUR(time) BETWEEN 12 AND 17 THEN 'Afternoon'
       ELSE 'Evening'
       END As day_time,
       COUNT(*) As total_transactions
       FROM walmart
GROUP BY branch,day_time
ORDER BY branch, total_transactions DESC;

-- Q.9 Identify 5 branches with highest decrease ratio in revenue comapare to last year (current year 2023 and last year 2022)
-- rev_dec_ratio = (last_yaer_rev - cur_year_rev)/last_year_rev * 100

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
     ls.revenue As lS_year_rev,
     cs.revenue As cs_year_rev,
     ROUND((ls.revenue - cs.revenue)/ls.revenue * 100, 2) As revenue_dec_ratio
FROM revenue_2022 As ls
JOIN revenue_2023 As cs
ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY revenue_dec_ratio DESC
LIMIT 5;


