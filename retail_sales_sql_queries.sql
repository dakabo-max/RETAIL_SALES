-- CREATE DATABASE AND TABLE AND IMPORT DATA FROM EXTERNAL SOURCE
CREATE DATABASE IF NOT EXISTS ZA_PROJECT_P1;
CREATE TABLE RETAIL_SALES
              (
              transactions_id INT PRIMARY KEY,
              sale_date DATE,
              sale_time TIME,
              customer_id INT,
              gender VARCHAR(10),
              age INT,
              category VARCHAR(50),	
              quantiy INT,
              price_per_unit FLOAT,	
              cogs FLOAT,
              total_sale FLOAT
              );


### DATA EXPLORATION

-- **Record Count**: Determine the total number of records in the dataset.
SELECT 
   COUNT(*) 
FROM retail_sales;

-- **Customer Count**: Find out how many unique customers are in the dataset.
SELECT 
   COUNT(DISTINCT customer_id) AS customer_id_count
FROM retail_sales;

-- **Category Count**: Identify all unique product categories in the dataset.
SELECT 
   DISTINCT category 
FROM retail_sales;

-- **Null Value Check**: Check for any null values in the dataset and delete records with missing 
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


### 3. Data Analysis & Findings
-- The following SQL queries were developed to answer specific business questions:

-- 1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
SELECT 
   * 
FROM retail_sales
WHERE category = 'Clothing' 
   AND 
   quantity >= 4 
   AND 
   sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- 3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
SELECT 
   category, 
   SUM(total_sale) AS total_sales,
   COUNT(*) AS sales_count
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- 4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
SELECT 
   ROUND(AVG(age),2) AS avg_age 
FROM retail_sales
WHERE category = 'Beauty';

-- 5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
SELECT 
   * 
FROM retail_sales
WHERE total_sale > 1000;

-- 6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
SELECT 
   gender, 
   category, 
   COUNT(transactions_id) AS transaction_count
FROM retail_sales
GROUP BY gender, category
ORDER BY category;

-- 7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
SELECT 
   year, 
   month, 
   avg_sales 
FROM
  (
   SELECT 
      YEAR(sale_date) AS year,
      MONTH(sale_date) AS month,
      ROUND(AVG(total_sale),2) AS avg_sales,
      RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale),2) DESC) AS rannk
   FROM retail_sales
   GROUP BY year, month
   ) AS t1
WHERE rannk = 1;


-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
   customer_id, 
   SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- 9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
SELECT 
   category, 
   COUNT(DISTINCT customer_id) AS customer_count   
FROM retail_sales
GROUP BY category;

-- 10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
SELECT * FROM retail_sales;
SELECT 
   CASE
     WHEN sale_time < '12:00:00' THEN 'MORNING'
     WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'AFTERNOON'
     ELSE 'EVENING'
   END AS time_shift,
   COUNT(*) AS order_count
FROM retail_sales
GROUP BY time_shift;

