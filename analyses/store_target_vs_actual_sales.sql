with orders as (
    select * from {{ ref("orders_stg") }}
),
salestarget as(
    select * from {{ ref("salestarget") }}
),
order_items as(
    select * from {{ ref("orderitems_stg") }}
)


select ord.store_id,
	sum(oi.quantity * oi.unitprice) as actual_sales,
	st.sales_target,
	round((sum(oi.quantity * oi.unitprice) / st.sales_target) * 100, 2) as percent_achieved
from orders ord
left join order_items oi on ord.order_id = oi.order_id
left join salestarget st on ord.store_id = cast(st.store_id as varchar(10))
group by ord.store_id, st.sales_target