/*
====================================================================================================
Product Report
====================================================================================================
Purpose:
 - To consolidate key product metrics and behaviours

Highlights:
 1. Gathers essential fields such as product name, category, subcategory and cost
 2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers
 3. Aggregates product-level metrics:
	- total orders
	- total sales
	- total quantity sold
	- total customers (unique)
	- lifespan (in months)
 4. Calculates valuable KPIs:
	- recency (months since last sale)
	- average order revenue
	- average monthly revenue
====================================================================================================
*/
CREATE VIEW gold.report_products AS
/*
----------------------------------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
----------------------------------------------------------------------------------------------------
*/
WITH base_query AS (
SELECT
	s.product_key,
	product_name,
	category,
	subcategory,
	cost,
	order_number,
	total_sales,
	quantity,
	customer_key,
	order_date
FROM gold.fact_sales as s
LEFT JOIN gold.dim_products as p
	ON s.product_key = p.product_key
),
/*
----------------------------------------------------------------------------------------------------
2) Aggregate Query: Complete aggregations on Base Query
----------------------------------------------------------------------------------------------------
*/
product_aggregates AS (
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	MAX(order_date) AS latest_order,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(total_sales) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT customer_key) AS total_customers,
	DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan,
	AVG(total_sales / quantity) AS avg_selling_price
FROM base_query
GROUP BY 
	product_key,
	product_name,
	category,
	subcategory,
	cost
)
/*
----------------------------------------------------------------------------------------------------
3) Final Query: Build report from Aggregate Query
----------------------------------------------------------------------------------------------------
*/
SELECT
	product_key,
	product_name,
	category,
	subcategory,
	latest_order,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	lifespan,
	avg_selling_price,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	DATEDIFF(month, latest_order, GETDATE()) AS recency,
	total_sales / total_orders AS avg_order_revenue,
	total_sales / lifespan AS avg_monthly_revenue
FROM product_aggregates;
