/*
    This model performs basic cleaning on the raw sales data.
    In a real FSI scenario, this is where we would handle 
    data type casting and initial security filtering.
*/

{{ config(materialized='table') }}

WITH raw_data AS (
    -- Hardcode the reference for a second to bypass source issues
    SELECT * FROM RAW.PUBLIC.SALES_DATA
)

SELECT
    id AS sale_id,
    sales_rep AS representative_id,
    territory,
    amount AS transaction_amount,
    CASE 
        WHEN amount > 100000 THEN 'High Value'
        ELSE 'Standard'
    END AS deal_tier
FROM raw_data

WITH raw_data AS (
    SELECT * FROM {{ source('raw', 'sales_data') }}
)

SELECT
    id AS sale_id,
    sales_rep AS representative_id,
    territory,
    amount AS transaction_amount,
    -- Simple transformation example:
    CASE 
        WHEN amount > 100000 THEN 'High Value'
        ELSE 'Standard'
    END AS deal_tier
FROM raw_data
