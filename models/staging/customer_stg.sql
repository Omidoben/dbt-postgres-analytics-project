SELECT 
    customerid AS customer_id,
    CONCAT(firstname, ' ', lastname) AS customer_name,
    email,
    phone,
    address,
    city,
    state,
    zipcode,
    updated_at
FROM {{ source('raw', 'cust') }}


-- is_incremental macro. This macro will return true if the running model is configured with materialized=
-- 'incremental'

-- the where condition filters rows based on the timestamp column _etl_loaded_at. It compares this timestamp 
-- to the maximum _etl_loaded_at time stamp from the current table ({{ this }}), which effectively checks 
-- whether the row’s load timestamp is greater than or equal to the maximum load timestamp in the current table
{% if is_incremental() %}

where _etl_loaded_at >= (select max(_etl_loaded_at) from {{ this }} )

{% endif %}