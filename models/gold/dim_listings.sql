{{ config(materialized='view') }}
SELECT
    listing_id,
    listing_url,
    name AS listing_name,
    room_type,
    CASE
        WHEN minimum_nights IS NULL THEN 1
        WHEN CAST(minimum_nights AS INT) = 0 THEN 1
        ELSE CAST(minimum_nights AS INT)
    END AS minimum_nights,
    host_id,
    CAST(REPLACE(price, '$', '') AS INT) AS price,
    created_at,
    updated_at
FROM {{ ref('silver_listings') }}