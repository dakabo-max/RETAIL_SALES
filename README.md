# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `ZA_PROJECT_P1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `ZA_PROJECT_P1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
              quantity INT,
              price_per_unit FLOAT,	
              cogs FLOAT,
              total_sale FLOAT
              );

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- SELECT 
   COUNT(*) 
FROM retail_sales;

- **Customer Count**: Find out how many unique customers are in the dataset.
```sql
- SELECT 
   COUNT(DISTINCT customer_id) AS customer_id_count
FROM retail_sales;

- **Category Count**: Identify all unique product categories in the dataset.
```sql
- SELECT 
   DISTINCT category 
FROM retail_sales;

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
```sql
SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;


### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
   * 
FROM retail_sales
WHERE category = 'Clothing' 
   AND 
   quantity >= 4 
   AND 
   sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
   category, 
   SUM(total_sale) AS total_sales,
   COUNT(*) AS sales_count
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT 
   ROUND(AVG(age),2) AS avg_age 
FROM retail_sales
WHERE category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT 
   * 
FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
   gender, 
   category, 
   COUNT(transactions_id) AS transaction_count
FROM retail_sales
GROUP BY gender, category
ORDER BY category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT 
   customer_id, 
   SUM(total_sale) AS total_sale
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
   category, 
   COUNT(DISTINCT customer_id) AS customer_count   
FROM retail_sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
SELECT 
   CASE
     WHEN sale_time < '12:00:00' THEN 'MORNING'
     WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'AFTERNOON'
     ELSE 'EVENING'
   END AS time_shift,
   COUNT(*) AS order_count
FROM retail_sales
GROUP BY time_shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Limitations

13 rows were truncated whilst importing the dataset into MySQL Workbench. 3 Rows containing Null values and 10 Error Data.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.




