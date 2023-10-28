-- Total Revenue of Each Year
WITH subq_revenue_year AS (
	SELECT 
		date_part('year', od.order_purchase_timestamp) AS year,
		SUM(revenue) AS total_revenue
	FROM (
		SELECT order_id, SUM(price + freight_value) AS revenue
		FROM order_items
		GROUP BY 1
	) subq
	JOIN orders AS od ON subq.order_id = od.order_id
	WHERE order_status = 'delivered'
	GROUP BY 1
	ORDER BY 1),

-- Total Customer Canceled Order
subq_cust_ccl_od AS (
	SELECT 
		date_part('year', order_purchase_timestamp) AS year,
		COUNT(cust_ccl) AS total_canceled
	FROM (
		SELECT order_id, COUNT(order_status) AS cust_ccl
		FROM orders
		GROUP BY 1
	) subq
	JOIN orders AS od ON subq.order_id = od.order_id
	WHERE order_status = 'canceled'
	GROUP BY 1
	ORDER BY 1), 
	

-- Top Category Product with Total Revenue
subq_top_product AS (
	SELECT 
		year,
		product_category_name AS top_product,
		ROUND(total_revenue) AS top_pro_revenue
	FROM (
		SELECT 
			year,
			pd.product_category_name,
			SUM(subq2.revenue) AS total_revenue,
			RANK() OVER (PARTITION BY year ORDER BY SUM(subq2.revenue) DESC) AS rev_rank
		FROM (SELECT order_id, date_part('year', order_purchase_timestamp) AS year
			 FROM orders WHERE order_status = 'delivered') subq
		JOIN (
			SELECT order_id, product_id, SUM(price + freight_value) AS revenue 
			FROM order_items
			GROUP BY order_id, product_id) subq2
		ON subq.order_id = subq2.order_id
		JOIN products AS pd
		ON subq2.product_id = pd.product_id
		GROUP BY year, pd.product_category_name) subq3  
	WHERE rev_rank = 1),
	
-- Most Canceled Product Category
subq_top_ccl_pro AS(
	SELECT 
		year,
		product_category_name AS most_ccl_pro,
		total_pro_canceled
	FROM (
		SELECT 
			year,
			pd.product_category_name,
			SUM(subq2.ccl_orders) AS total_pro_canceled,
			RANK() OVER (PARTITION BY year ORDER BY SUM(subq2.ccl_orders) DESC) AS rev_rank
		FROM (SELECT order_id, date_part('year', order_purchase_timestamp) AS year
			 FROM orders WHERE order_status = 'canceled') subq 
		JOIN (
			SELECT order_id, product_id, COUNT(order_id) AS ccl_orders
			FROM order_items
			GROUP BY order_id, product_id) subq2
		ON subq.order_id = subq2.order_id
		JOIN products AS pd
		ON subq2.product_id = pd.product_id
		GROUP BY year, pd.product_category_name) subq3
	WHERE rev_rank = 1
)


SELECT sry.year, sry.total_revenue, stp.top_product, stp.top_pro_revenue, scco.total_canceled, stcp.most_ccl_pro, stcp.total_pro_canceled
FROM subq_revenue_year AS sry
JOIN subq_cust_ccl_od AS scco ON sry.year = scco.year
JOIN subq_top_product AS stp ON sry.year = stp.year
JOIN subq_top_ccl_pro AS stcp ON sry.year = stcp.year