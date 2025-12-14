-- analyze the top 10 most valuable customers in terms of the total amount paid, considering only orders “completed” status.

WITH fct_orders AS(
    SELECT * FROM {{ ref("fact_orders") }}
),
dim_customers AS(
    SELECT * FROM {{ ref("dim_customers") }}
)

SELECT  
    cust.customer_id,
    cust.customer_name,
    SUM(ord.total_revenue) AS total_revenue
FROM fct_orders ord
LEFT JOIN dim_customers cust ON ord.customer_id = cust.customer_id
WHERE ord.is_order_completed = 1
GROUP BY 
    cust.customer_id, 
    cust.customer_name
ORDER BY 3 DESC 
LIMIT 10