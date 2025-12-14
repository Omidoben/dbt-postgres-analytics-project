SELECT 
    orderid AS order_id,
    orderitemid AS order_item_id,
    productid AS product_id,
    quantity,
    unitprice,
    quantity * unitprice AS total_price,
    updated_at
FROM {{ source('raw', 'ordritms') }}