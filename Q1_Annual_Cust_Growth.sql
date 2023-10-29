-- Monthly Active Users (MAU) by Year
WITH subq_mau AS (
	SELECT 
		year, ROUND(AVG(monthly_active_user), 2) AS avg_mau
	FROM (
		SELECT 
			COUNT(DISTINCT cust.customer_unique_id) AS monthly_active_user,
			date_part('month', od.order_purchase_timestamp) AS month,
			date_part('year', od.order_purchase_timestamp) AS year
		FROM customers as cust
		RIGHT JOIN orders as od ON cust.customer_id = od.customer_id
		GROUP BY month, year
		) AS subq
	GROUP BY year
	ORDER BY year),


-- New Customers Each Year
subq_new_cust AS (
	SELECT 
		year, COUNT(customer_unique_id) AS total_new_cust
	FROM (
		SELECT 
			MIN(date_part('year', od.order_purchase_timestamp)) AS year,
			cust.customer_unique_id
		FROM orders AS od
		JOIN customers AS cust ON cust.customer_id = od.customer_id
		GROUP BY 2
			) AS subq
	GROUP BY year
	ORDER BY year),


-- Total Delivered Order
subq_deliv_od AS (
	SELECT
		date_part('year', od.order_purchase_timestamp) AS year, 
		SUM(tot_order) AS delivered_order
	FROM (
		SELECT order_id,
		COUNT(od.order_status) AS tot_order
		FROM orders as od 
		WHERE order_status = 'delivered'
		GROUP BY 1
	) AS subq
	JOIN orders AS od ON subq.order_id = od.order_id
	GROUP BY 1
	ORDER BY 1),


-- Customer Repeat Orders
subq_rep_od AS (
	SELECT 
		year, COUNT(DISTINCT repeat_order) AS total_cust_repeat_order
	FROM (
		SELECT 
			cust.customer_unique_id AS repeat_order,
			date_part('year', od.order_purchase_timestamp) AS year,
			COUNT(od.order_id) AS total_order
		FROM orders AS od
		JOIN customers AS cust ON cust.customer_id = od.customer_id
		GROUP BY 1,2
		HAVING COUNT(od.order_id)>1
			) AS subq
	GROUP BY year),


-- Average Customer Order 
subq_avg_od AS (
	SELECT 
		year, ROUND(AVG (avg_order), 3) AS avg_cust_order
	FROM (
		SELECT 
			cust.customer_unique_id AS customer,
			date_part('year', od.order_purchase_timestamp) AS year,
			COUNT(order_id) AS avg_order
		FROM customers AS cust
		JOIN orders AS od ON cust.customer_id = od.customer_id
		GROUP BY 1, 2
			) AS subq
	GROUP BY 1
	ORDER BY 1)


-- Merge the Metrics
SELECT 
	mauy.year,
	mauy.avg_mau,
	ncey.total_new_cust,
	dlv.delivered_order,
	cro.total_cust_repeat_order,
	aco.avg_cust_order
FROM subq_mau as mauy
JOIN subq_new_cust AS ncey ON ncey.year = mauy.year
JOIN subq_deliv_od AS dlv ON dlv.year = mauy.year
JOIN subq_rep_od AS cro ON cro.year = mauy.year
JOIN subq_avg_od AS aco ON aco.year = mauy.year
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY 1;