-- Problem statement
-- In one of our projects, we successfully passed all our dbt tests in lower environments. However, upon
-- moving the code to production, we encountered several data quality issues.

-- Root cause
-- We discovered the tests in lower environments were run with insufficient test data

-- To address this problem we define the minimum number of rows for each table that would be considered
-- adequate for thorough testing


-- Define the expected record counts for each table
{% set expected_counts = {
    'cust': 50,
    'ordritms': 1000,
    'ordr': 200
} %}

-- test the count of records in each table
{% for table, expected_count in expected_counts.items() %}
    SELECT '{{ table }}' AS table_name,
            (SELECT COUNT(*) FROM {{ source('raw', table) }}) AS record_count,
            {{ expected_count }} AS expected_count
    WHERE (SELECT COUNT(*) FROM {{ source('raw', table) }}) < {{ expected_count }}
    {% if not loop.last %} UNION ALL {% endif %}
{% endfor %}



