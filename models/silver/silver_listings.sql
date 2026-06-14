{{ config(materialized='table') }}
SELECT
    id AS listing_id,
    listing_url,
    name,
    room_type,
    minimum_nights,
    host_id,
    price,
    created_at,
    updated_at
FROM {{ ref('bronze_listings') }}
WHERE name IS NOT NULL
