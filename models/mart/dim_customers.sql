WITH customers AS(
    SELECT * FROM {{ ref("customer_stg") }}
)

SELECT
    customer_id,
    customer_name,
    email
FROM customers