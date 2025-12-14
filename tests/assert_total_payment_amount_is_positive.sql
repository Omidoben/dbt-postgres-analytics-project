SELECT
    order_id,
    SUM(total_price) AS total_amount
FROM {{ ref("orderitems_stg") }}
GROUP BY 1
HAVING SUM(total_price) < 0