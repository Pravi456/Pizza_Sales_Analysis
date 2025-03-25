# Pizza Sales Analysis Project

## Project Overview
This project is focused on analyzing key performance indicators (KPIs) and trends in pizza sales data using SQL queries. The goal is to gain insights into business performance by extracting meaningful metrics and visualizing important trends.

## Problem Statement
The objective of this analysis is to evaluate pizza sales performance through the following key metrics:
- Total Revenue
- Average Order Value
- Total Pizzas Sold
- Total Orders
- Average Pizzas Per Order

Additionally, visualizations are required for:
- Daily Trend for Total Orders
- Hourly Trend for Total Orders
- Percentage of Sales by Pizza Category
- Percentage of Sales by Pizza Size
- Total Pizzas Sold by Pizza Category
- Top 5 Best Sellers by Total Pizzas Sold
- Bottom 5 Worst Sellers by Total Pizzas Sold

## SQL Queries
The project includes SQL queries to compute the required KPIs and sales distributions. Below are some of the key queries used:

### KPI Calculations:
1. **Total Revenue:**
   ```sql
   SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;
   ```
2. **Average Order Value:**
   ```sql
   SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value FROM pizza_sales;
   ```
3. **Total Pizzas Sold:**
   ```sql
   SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales;
   ```
4. **Total Orders:**
   ```sql
   SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;
   ```
5. **Average Pizzas Per Order:**
   ```sql
   SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order FROM pizza_sales;
   ```

### Trend Analysis:
- **Daily Trend for Total Orders:**
   ```sql
   SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
   FROM pizza_sales
   GROUP BY DATENAME(DW, order_date);
   ```
- **Hourly Trend for Orders:**
   ```sql
   SELECT DATEPART(HOUR, order_time) AS Order_Hour, COUNT(DISTINCT order_id) AS Total_Orders
   FROM pizza_sales
   GROUP BY DATEPART(HOUR, order_time)
   ORDER BY DATEPART(HOUR, order_time);
   ```

### Sales Distribution:
- **Percentage of Sales by Pizza Category:**
   ```sql
   SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
   CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
   FROM pizza_sales
   GROUP BY pizza_category;
   ```
- **Percentage of Sales by Pizza Size:**
   ```sql
   SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
   CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
   FROM pizza_sales
   GROUP BY pizza_size
   ORDER BY pizza_size;
   ```

### Best and Worst Sellers:
- **Top 5 Best Sellers by Total Pizzas Sold:**
   ```sql
   SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
   FROM pizza_sales
   GROUP BY pizza_name
   ORDER BY Total_Pizza_Sold DESC;
   ```
- **Bottom 5 Worst Sellers by Total Pizzas Sold:**
   ```sql
   SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
   FROM pizza_sales
   GROUP BY pizza_name
   ORDER BY Total_Pizza_Sold ASC;
   ```

## Usage
- The SQL queries can be executed on a relational database containing the `pizza_sales` table.
- Results from these queries can be used to generate various charts such as bar charts, line charts, pie charts, and funnel charts for better visualization.
- Filtering by month or quarter can be applied using the `WHERE` clause, as shown below:
  ```sql
  SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders
  FROM pizza_sales
  WHERE MONTH(order_date) = 1
  GROUP BY DATENAME(DW, order_date);
  ```
  *This example filters data for January (MONTH(order_date) = 1).*

## Author
Created by - Sainadh

