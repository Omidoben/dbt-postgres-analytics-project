SELECT 
    orderid AS order_id,
    orderdate AS order_date,
    customerid AS customer_id,
    employeeid AS employee_id,
    storeid AS store_id,
    status AS status_code,
    CASE 
        WHEN status = '01' THEN 'In Progress'
        WHEN status = '02' THEN 'Completed'
        WHEN status = '03' THEN 'Cancelled'
        ELSE NULL
    END AS status_description,
    updated_at
FROM {{ source('raw', 'ordr') }}