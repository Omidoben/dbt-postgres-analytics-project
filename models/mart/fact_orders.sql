WITH orders AS(
    SELECT * FROM {{ ref("int_orders_fact")}}
)

SELECT *
FROM orders