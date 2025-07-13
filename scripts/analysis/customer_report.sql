/*
====================================================================================================
Customer Report
====================================================================================================
Purpose:
 - To consolidate key customer metrics and behaviours

Highlights:
 1. Gathers essential fields such as names, ages, and transaction details
 2. Segments customers into categories (VIP, Regular, New) and age groups
 3. Aggregates customer-level metrics:
	- total orders
	- total sales
	- total quantity purchased
	- total products
	- lifespan (in months)
 4. Calculates valuable KPIs:
	- recency (months since last order)
	- average order value
	- average monthly spend 
====================================================================================================
*/
CREATE VIEW gold.report_customer AS
/*
----------------------------------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
----------------------------------------------------------------------------------------------------
*/
WITH base_query AS (
SELECT
	order_number,
	product_key,
	order_date,
	total_sales,
	quantity,
	c.customer_key,
	customer_number,
	CONCAT(first_name, ' ', last_name) AS customer_name,
	DATEDIFF(year, birthdate, GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
WHERE order_date IS NOT NULL
),
/*
----------------------------------------------------------------------------------------------------
2) Aggregated Query: Complete aggregations on Base Query
----------------------------------------------------------------------------------------------------
*/
customer_aggregation AS (
SELECT 
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(total_sales) AS total_spendings,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
FROM base_query
GROUP BY 
	customer_key,
	customer_number,
	customer_name,
	age
)
/*
----------------------------------------------------------------------------------------------------
3) Final Query: Create final report based on Aggregated Query
----------------------------------------------------------------------------------------------------
*/
SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE
		WHEN age < 20 THEN 'Under 20'
		WHEN age < 30 THEN '20-29'
		WHEN age < 40 THEN '30-39'
		WHEN age < 20 THEN '40-49'
		ELSE '50 and above'
	END AS age_group,
	CASE
		WHEN lifespan >= 12 AND total_spendings > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND total_spendings <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_group,
	last_order_date,
	DATEDIFF(month, last_order_date, GETDATE()) AS recency,
	total_orders,
	total_spendings,
	total_quantity,
	total_products,
	lifespan,
	total_spendings / total_orders AS avg_order_value,
	CASE
		WHEN lifespan = 0 THEN total_spendings
		ELSE total_spendings / lifespan
	END AS avg_monthly_spendings
FROM customer_aggregation;
