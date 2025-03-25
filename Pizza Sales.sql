Create Database Pizza_Sales

Use Pizza_Sales
Go

Select * From Pizza_Sales

--A. KPI’s
--1. Total Revenue:

Select 
    Sum(total_price) As Total_Revenue
From
    pizza_sales

--2. Average Order Value

Select
    (Sum(total_price)/Count(Distinct order_id)) As Avg_Order_Value
From
    pizza_sales

--3. Total Pizzas Sold

Select
    Sum(quantity) As Total_Pizza_Sold
From
    pizza_sales

--4. Total Orders

Select
    Count(Distinct order_id) As Total_Orders
From 
    pizza_sales

--5. Average Pizzas Per Order

Select
    Cast(Sum(quantity)/Cast(Count (Distinct order_id) As Decimal(10,2)) As Decimal(10,2)) As Avg_Pizzas_Per_Order
From
    pizza_sales

--6. Daily Trend for Total Orders

Select
    DATENAME(DW, order_date) As Order_Day,
	Count(Distinct order_id) As Total_Orders
From
    pizza_sales
Group By
    DATENAME(DW, order_date)

--7. Hourly Trend for Orders

Select
    DATEPART(Hour, order_time) As Order_Hours,
	Count(Distinct order_id) As Total_Orders
From
    pizza_sales
Group By
    DATEPART(Hour, order_time)
Order By
    DATEPART(Hour, order_time)
    
--8. % of Sales by Pizza Category

Select
    pizza_category,
    Cast(Sum(total_price) As decimal(10,2)) As Total_revenue,
	Cast(Sum(total_price)*100 / (select sum(total_price) From pizza_sales) As Decimal(10,2)) As PCT
From
    pizza_sales
Group By
    pizza_category

--9. % of Sales by Pizza Size

Select
    pizza_size,
	Cast(Sum(total_price) As Decimal(10,2)) As Total_Revenue,
	Cast(Sum(total_price)*100 / (Select Sum(total_price) From pizza_sales) As Decimal(10,2)) As PCT
From
    pizza_sales
Group By
    pizza_size
Order By
    PCT Desc

--10. Total Pizzas Sold by Pizza Category

Select
    pizza_category,
	Sum(quantity) As Total_Pizzas
From
    pizza_sales
Group By
    pizza_category
Order By
    Total_Pizzas Desc

--11. Top 5 Best Sellers by Total Pizzas Sold

Select * From pizza_sales

Select Top 5
    pizza_name,
	Sum(quantity) As Total_Pizzas
From
    pizza_sales
Group By
    pizza_name
Order By
    Total_pizzas desc

--12. Bottom 5 Best Sellers by Total Pizzas Sold

Select Top 5
    pizza_name,
	Sum(quantity) As Total_Pizzas
From
    pizza_sales
Group By
    pizza_name
Order By
    Total_pizzas 