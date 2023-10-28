-- Total Usage of Payment Type
SELECT 
	payment_type, 
	COUNT(order_id) AS usage_payment
FROM order_payment
GROUP BY 1
ORDER BY 2 DESC; 


-- Detail Usage of Payment Type
SELECT 
	payment_type, 
	SUM(CASE WHEN year = 2016 THEN usage_payment ELSE 0 END) AS "2016",
	SUM(CASE WHEN year = 2017 THEN usage_payment ELSE 0 END) AS "2017",
	SUM(CASE WHEN year = 2018 THEN usage_payment ELSE 0 END) AS "2018",
	SUM(usage_payment) AS total_usage_payment
FROM (
	SELECT 
		date_part('year', od.order_purchase_timestamp) AS year,
		odp.payment_type,
		COUNT(odp.payment_type) AS usage_payment
	FROM orders AS od
	JOIN order_payment AS odp ON od.order_id = odp.order_id
	GROUP BY 1, 2
	) subq	
GROUP BY 1
ORDER BY 2 DESC;