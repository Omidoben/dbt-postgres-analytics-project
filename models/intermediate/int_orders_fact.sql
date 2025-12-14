with orders as (
    select * from {{ ref("orders_stg") }}
),
orderitems as (
    select * from {{ ref("orderitems_stg") }}
)

SELECT  
    o.order_id,
    oi.order_item_id,
    o.customer_id,
    o.employee_id,
    o.store_id,
    o.order_date,
    o.status_code,
    o.status_description,
    COUNT(DISTINCT(o.order_id)) AS num_orders,
    SUM(oi.total_price) AS total_revenue,
    CASE 
        WHEN o.status_code = '02' THEN 1
        ELSE 0
        END AS is_order_completed
FROM orders o
LEFT JOIN orderitems oi
ON o.order_id = oi.order_id
GROUP BY
    o.order_id,
    oi.order_item_id,
    o.customer_id,
    o.employee_id,
    o.store_id,
    o.order_date,
    o.status_code,
    o.status_description