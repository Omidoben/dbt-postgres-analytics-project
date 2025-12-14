-- analyze the top 10 most valuable customers in terms of the total amount paid, considering only orders 
-- “completed” status, and classify customers by total revenue generated

WITH fct_orders AS(
    SELECT * FROM {{ ref("fact_orders") }}
),
dim_customers AS(
    SELECT * FROM {{ ref("dim_customers") }}
),

total_revenue_per_customer AS(
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
    ),
customer_range_per_paid_amount AS(
    SELECT * FROM {{ ref("customer_range_per_paid_amount") }}
)

SELECT
    customer_id,
    customer_name,
    total_revenue,
    classification
FROM total_revenue_per_customer tac 
LEFT JOIN customer_range_per_paid_amount crp 
ON tac.total_revenue >= crp.min_range and tac.total_revenue <= crp.max_range
